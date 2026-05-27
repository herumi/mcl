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
    mod.HEAP8 = new Int8Array(memory.buffer)
    mod.HEAP32 = new Int32Array(memory.buffer)

    // Export mclBn* wasm functions with _ prefix
    const exports = instance.exports
    for (const name in exports) {
      if (name.startsWith('mclBn') && typeof exports[name] === 'function') {
        mod['_' + name] = exports[name]
      }
    }
    mod._malloc = exports.malloc
    mod._free = exports.free

    // Stack pointer operations (direct wasm exports)
    mod.stackSave = exports.stackSave
    mod.stackAlloc = exports.stackAlloc
    mod.stackRestore = exports.stackRestore

    // Call global constructors if present
    if (exports.__wasm_call_ctors) exports.__wasm_call_ctors()

    return mod
  })
}

if (typeof module !== 'undefined') module.exports = createModule
