function createModule (opts) {
  const wasmBase64 = '@@WASM_BASE64@@'
  const wasmBytes = Uint8Array.from(atob(wasmBase64), function (c) { return c.charCodeAt(0) })

  const memory = new WebAssembly.Memory({ initial: 32 })

  const imports = {
    env: {
      memory,
      cryptoGetRandomValues: function (ptr, size) {
        const buf = new Uint8Array(memory.buffer)
        const a = new Uint8Array(size)
        opts.cryptoGetRandomValues(a)
        buf.set(a, ptr)
      }
    }
  }

  return WebAssembly.instantiate(wasmBytes, imports).then(function (result) {
    const instance = result.instance
    const mod = {}

    mod.wasmMemory = memory
    // memory.grow() detaches the old ArrayBuffer, so recreate the views on demand.
    // A view on a detached buffer has length 0; testing that is much cheaper
    // than reading memory.buffer (a native getter) on every access.
    let HEAP8 = new Int8Array(memory.buffer)
    let HEAP32 = new Int32Array(memory.buffer)
    const h8 = function () {
      if (HEAP8.length === 0) HEAP8 = new Int8Array(memory.buffer)
      return HEAP8
    }
    const h32 = function () {
      if (HEAP32.length === 0) HEAP32 = new Int32Array(memory.buffer)
      return HEAP32
    }
    Object.defineProperty(mod, 'HEAP8', { get: h8 })
    Object.defineProperty(mod, 'HEAP32', { get: h32 })

    // Export mclBn* and bls* wasm functions with _ prefix
    const exports = instance.exports
    for (const name in exports) {
      const matched = name.startsWith('mclBn') || (opts.prefix ? name.startsWith(opts.prefix) : name.startsWith('bls'))
      if (matched && typeof exports[name] === 'function') {
        mod['_' + name] = exports[name]
      }
    }
    mod._malloc = exports.malloc
    mod._free = exports.free

    // Stack pointer operations
    if (exports.stackSave) {
      // USE_STACK=0 (stack.s) or USE_STACK=1 (stack_c.c): use wasm exports
      mod.stackSave = exports.stackSave
      mod.stackAlloc = exports.stackAlloc
      mod.stackRestore = exports.stackRestore
    } else {
      // USE_STACK=2: JS implementation via __stack_pointer global
      const g_sp = exports.__stack_pointer // WebAssembly.Global (mutable i32)
      mod.stackSave = function () { return g_sp.value }
      mod.stackRestore = function (sp) { g_sp.value = sp }
      mod.stackAlloc = function (n) {
        const sp = (g_sp.value - n) & ~15
        g_sp.value = sp
        return sp
      }
    }

    // Harden stackAlloc so an oversize request cannot corrupt __stack_pointer.
    // The default stack size comes from the linker -z stack-size, injected at
    // build time in Makefile.wasm; opts.stackSize can override it at runtime.
    const STACK_SIZE = opts.stackSize || @@STACK_SIZE@@
    const stackLow = mod.stackSave() - STACK_SIZE
    const rawStackAlloc = mod.stackAlloc
    mod.stackAlloc = function (n) {
      const sp = mod.stackSave()
      if (!(n >= 0 && n <= sp - stackLow)) {
        throw new Error('stackAlloc: bad size ' + n)
      }
      return rawStackAlloc(n)
    }

    // ------------------------------------------------------------------
    // Common wrappers shared by mcl-wasm, bls-wasm, bls-eth-wasm, she-wasm
    // and ecdsa-wasm.
    //
    // A value lives on the JS side as a Uint32Array `a`. Each wrapper copies
    // its operands onto the wasm stack, calls `func` and copies the result
    // back, then restores the stack in `finally` so that a throw (e.g. the
    // stackAlloc size guard above) never leaves __stack_pointer lowered.
    //
    // Performance notes (each stackAlloc is a JS wrapper plus a wasm call):
    // - all operands of one call are allocated with a single stackAlloc and
    //   laid out at 16-byte aligned offsets inside that block
    // - extra parameters p1, p2 have fixed arity (no rest/spread); passing
    //   `undefined` to a wasm i32 parameter yields 0 and surplus arguments are
    //   ignored, so callers may omit them
    const stackSave = mod.stackSave
    const stackAlloc = mod.stackAlloc
    const stackRestore = mod.stackRestore
    // byte size of a (Uint32Array) rounded up to 16
    const sizeOf = function (a) {
      return (a.length * 4 + 15) & ~15
    }
    // byte size of arr = [Uint32Array, ...] packed with stride arr[0].length * 4
    const sizeOfArray = function (arr) {
      return (arr[0].length * 4 * arr.length + 15) & ~15
    }
    const copyArrayToHeap32 = function (H, arr, pos) {
      const n = arr.length
      const size = arr[0].length * 4
      for (let i = 0; i < n; i++) {
        H.set(arr[i], (pos + size * i) >> 2)
      }
    }

    // --- primitives (callers must wrap in stackSave/try/finally/stackRestore)
    // copy a (Uint32Array) to wasm memory at pos
    const copyToHeap32 = function (a, pos) {
      h32().set(a, pos >> 2)
    }
    // copy wasm memory at pos to a (Uint32Array)
    const copyFromHeap32 = function (a, pos) {
      const p = pos >> 2
      a.set(h32().subarray(p, p + a.length))
    }
    // stack alloc a.length * 4 bytes (uninitialized)
    const salloc = function (a) {
      return stackAlloc(a.length * 4)
    }
    // stack alloc and copy a
    const sallocCopy = function (a) {
      const pos = stackAlloc(a.length * 4)
      h32().set(a, pos >> 2)
      return pos
    }
    // stack alloc and copy a byte array (Uint8Array)
    const sallocBytes = function (buf) {
      const pos = stackAlloc(buf.length)
      h8().set(buf, pos)
      return pos
    }
    // stack alloc and copy arr = [Uint32Array, ...] (all of the same length) contiguously
    const sallocArray = function (arr) {
      if (arr.length === 0) throw new Error('sallocArray: zero size array')
      const pos = stackAlloc(sizeOfArray(arr))
      copyArrayToHeap32(h32(), arr, pos)
      return pos
    }
    // copy contiguous wasm memory at pos back to arr = [Uint32Array, ...]
    const saveArray = function (arr, pos) {
      const n = arr.length
      if (n === 0) return
      const size = arr[0].length * 4
      const H = h32()
      for (let i = 0; i < n; i++) {
        const p = (pos + size * i) >> 2
        arr[i].set(H.subarray(p, p + arr[i].length))
      }
    }
    mod.copyToHeap32 = copyToHeap32
    mod.copyFromHeap32 = copyFromHeap32
    mod.salloc = salloc
    mod.sallocCopy = sallocCopy
    mod.sallocBytes = sallocBytes
    mod.sallocArray = sallocArray
    mod.saveArray = saveArray

    // --- one-shot calls (stack is saved/restored inside)
    // a = func(p1, p2) ; throw if func returns non-zero
    mod.callSetter = function (func, a, p1, p2) {
      const stack = stackSave()
      let r
      try {
        const pos = stackAlloc(a.length * 4)
        r = func(pos, p1, p2)
        copyFromHeap32(a, pos)
      } finally {
        stackRestore(stack)
      }
      if (r) throw new Error('callSetter err')
    }
    // return func(a, p1, p2)
    mod.callGetter = function (func, a, p1, p2) {
      const stack = stackSave()
      try {
        const pos = stackAlloc(a.length * 4)
        h32().set(a, pos >> 2)
        return func(pos, p1, p2)
      } finally {
        stackRestore(stack)
      }
    }
    // return func(x, y, p1) ; e.g. isEqual, verify
    mod.callGetter2 = function (func, x, y, p1) {
      const stack = stackSave()
      try {
        const xPos = stackAlloc(sizeOf(x) + sizeOf(y))
        const yPos = xPos + sizeOf(x)
        const H = h32()
        H.set(x, xPos >> 2)
        H.set(y, yPos >> 2)
        return func(xPos, yPos, p1)
      } finally {
        stackRestore(stack)
      }
    }
    // y = func(x, p1) ; return the value of func
    mod.callOp1 = function (func, y, x, p1) {
      const stack = stackSave()
      try {
        const xPos = stackAlloc(sizeOf(x) + sizeOf(y))
        const yPos = xPos + sizeOf(x)
        h32().set(x, xPos >> 2)
        const r = func(yPos, xPos, p1)
        copyFromHeap32(y, yPos)
        return r
      } finally {
        stackRestore(stack)
      }
    }
    // z = func(x, y) ; return the value of func
    mod.callOp2 = function (func, z, x, y) {
      const stack = stackSave()
      try {
        const xPos = stackAlloc(sizeOf(x) + sizeOf(y) + sizeOf(z))
        const yPos = xPos + sizeOf(x)
        const zPos = yPos + sizeOf(y)
        const H = h32()
        H.set(x, xPos >> 2)
        H.set(y, yPos >> 2)
        const r = func(zPos, xPos, yPos)
        copyFromHeap32(z, zPos)
        return r
      } finally {
        stackRestore(stack)
      }
    }
    // y = func(vec, n, id) ; secret sharing (evaluate polynomial)
    // vec = [Uint32Array, ...], id = Uint32Array
    mod.callShare = function (func, y, vec, id) {
      const n = vec.length
      if (n === 0) throw new Error('callShare: zero size array')
      const stack = stackSave()
      try {
        const yPos = stackAlloc(sizeOf(y) + sizeOfArray(vec) + sizeOf(id))
        const vecPos = yPos + sizeOf(y)
        const idPos = vecPos + sizeOfArray(vec)
        const H = h32()
        copyArrayToHeap32(H, vec, vecPos)
        H.set(id, idPos >> 2)
        const r = func(yPos, vecPos, n, idPos)
        copyFromHeap32(y, yPos)
        return r
      } finally {
        stackRestore(stack)
      }
    }
    // y = func(idVec, vec, n) ; secret sharing (Lagrange interpolation)
    mod.callRecover = function (func, y, idVec, vec) {
      const n = vec.length
      if (n === 0) throw new Error('callRecover: zero size array')
      if (n !== idVec.length) throw new Error('callRecover: bad length')
      const stack = stackSave()
      try {
        const yPos = stackAlloc(sizeOf(y) + sizeOfArray(idVec) + sizeOfArray(vec))
        const idVecPos = yPos + sizeOf(y)
        const vecPos = idVecPos + sizeOfArray(idVec)
        const H = h32()
        copyArrayToHeap32(H, idVec, idVecPos)
        copyArrayToHeap32(H, vec, vecPos)
        const r = func(yPos, idVecPos, vecPos, n)
        copyFromHeap32(y, yPos)
        return r
      } finally {
        stackRestore(stack)
      }
    }

    // --- ascii helpers
    const ptrToAsciiStr = function (pos, n) {
      const H = h8()
      let s = ''
      for (let i = 0; i < n; i++) {
        s += String.fromCharCode(H[pos + i])
      }
      return s
    }
    const asciiStrToPtr = function (pos, s) {
      const H = h8()
      for (let i = 0; i < s.length; i++) {
        H[pos + i] = s.charCodeAt(i)
      }
    }
    mod.ptrToAsciiStr = ptrToAsciiStr
    mod.asciiStrToPtr = asciiStrToPtr

    // --- string / byte-buffer calls on a value a (Uint32Array)
    // func(buf, maxBufSize, x, ioMode) writes n bytes to buf and returns n (0 on error).
    // Return them as a string, or as a Uint8Array if returnAsStr === false.
    // buf has room for a.length * 32 bits (base-2 getStr of every word) plus a margin.
    mod.callGetStr = function (func, a, ioMode, returnAsStr) {
      if (ioMode === undefined) ioMode = 0
      const bufSize = a.length * 32 + 16
      const stack = stackSave()
      try {
        const pos = stackAlloc(sizeOf(a) + bufSize)
        const bufPos = pos + sizeOf(a)
        h32().set(a, pos >> 2)
        const n = func(bufPos, bufSize, pos, ioMode)
        if (n <= 0) throw new Error('err callGetStr')
        if (returnAsStr === false) return new Uint8Array(h8().subarray(bufPos, bufPos + n))
        return ptrToAsciiStr(bufPos, n)
      } finally {
        stackRestore(stack)
      }
    }
    // Uint8Array = func(buf, maxBufSize, x)
    mod.callSerialize = function (func, a) {
      return mod.callGetStr(func, a, 0, false)
    }
    // a = func(x, buf, bufSize) with buf = Uint8Array ; func returns the number of
    // bytes consumed ; throw unless all of buf was consumed
    mod.callDeserialize = function (func, a, buf) {
      const stack = stackSave()
      let r
      try {
        const pos = stackAlloc(sizeOf(a) + buf.length)
        const bufPos = pos + sizeOf(a)
        h8().set(buf, bufPos)
        r = func(pos, bufPos, buf.length)
        copyFromHeap32(a, pos)
      } finally {
        stackRestore(stack)
      }
      if (r === 0 || r !== buf.length) throw new Error('err callDeserialize: ' + r + ' != ' + buf.length)
    }
    // a = func(x, buf, bufSize, ioMode) with buf = String | Uint8Array | Array ;
    // throw if func returns non-zero (setStr, setLittleEndian, setHashOf, hashAndMapTo, ...)
    mod.callSetInput = function (func, a, buf, ioMode) {
      const isStr = typeof buf === 'string'
      if (!isStr && !(buf instanceof Uint8Array) && !Array.isArray(buf)) {
        throw new Error('err bad type:"' + Object.prototype.toString.apply(buf) + '". Use String or Uint8Array.')
      }
      const stack = stackSave()
      let r
      try {
        const pos = stackAlloc(sizeOf(a) + buf.length)
        const bufPos = pos + sizeOf(a)
        if (isStr) {
          asciiStrToPtr(bufPos, buf)
        } else {
          h8().set(buf, bufPos)
        }
        r = func(pos, bufPos, buf.length, ioMode)
        copyFromHeap32(a, pos)
      } finally {
        stackRestore(stack)
      }
      if (r) throw new Error('err callSetInput')
    }

    // --- string / byte-buffer wrappers

    // func(buf, maxBufSize, x, ioMode) writes n bytes to buf and returns n;
    // the wrapper (x, ioMode = 0) returns them as a string (or Uint8Array)
    mod.wrapGetStr = function (func, returnAsStr) {
      if (returnAsStr === undefined) returnAsStr = true
      const maxBufSize = 4096
      return function (x, ioMode) {
        if (ioMode === undefined) ioMode = 0
        const stack = stackSave()
        try {
          const pos = stackAlloc(maxBufSize)
          const n = func(pos, maxBufSize, x, ioMode)
          if (n <= 0) throw new Error('err gen_str:' + x)
          if (returnAsStr) return ptrToAsciiStr(pos, n)
          return new Uint8Array(h8().subarray(pos, pos + n))
        } finally {
          stackRestore(stack)
        }
      }
    }
    mod.wrapSerialize = function (func) {
      return mod.wrapGetStr(func, false)
    }
    // func(x, buf, bufSize) returns the number of bytes read; the wrapper
    // (x, buf: Uint8Array) throws unless all of buf was consumed
    mod.wrapDeserialize = function (func) {
      return function (x, buf) {
        const stack = stackSave()
        let r
        try {
          const pos = sallocBytes(buf)
          r = func(x, pos, buf.length)
        } finally {
          stackRestore(stack)
        }
        if (r === 0 || r !== buf.length) throw new Error('err wrapDeserialize: ' + r + ' != ' + buf.length)
      }
    }
    /*
      argNum : n
      func(x0, ..., x_(n-1), buf, bufSize, ioMode)
      => wrapper(x0, ..., x_(n-1), buf, ioMode) where buf is a String, Uint8Array or Array
      returnValue : true => return the value of func, false => throw if non-zero
    */
    mod.wrapInput = function (func, argNum, returnValue) {
      return function () {
        const buf = arguments[argNum]
        const typeStr = Object.prototype.toString.apply(buf)
        if (typeStr !== '[object String]' && typeStr !== '[object Uint8Array]' && typeStr !== '[object Array]') {
          throw new Error('err bad type:"' + typeStr + '". Use String or Uint8Array.')
        }
        const ioMode = arguments[argNum + 1] // may be undefined
        const stack = stackSave()
        let r
        try {
          const pos = stackAlloc(buf.length)
          if (typeStr === '[object String]') {
            asciiStrToPtr(pos, buf)
          } else {
            h8().set(buf, pos)
          }
          switch (argNum) {
            case 0: r = func(pos, buf.length, ioMode); break
            case 1: r = func(arguments[0], pos, buf.length, ioMode); break
            case 2: r = func(arguments[0], arguments[1], pos, buf.length, ioMode); break
            default: {
              const args = Array.prototype.slice.call(arguments, 0, argNum)
              args.push(pos, buf.length, ioMode)
              r = func.apply(null, args)
            }
          }
        } finally {
          stackRestore(stack)
        }
        if (returnValue) return r
        if (r) throw new Error('err wrapInput')
      }
    }

    // Call global constructors if present
    if (exports.__wasm_call_ctors) exports.__wasm_call_ctors()

    return mod
  })
}

if (typeof module !== 'undefined') module.exports = createModule
