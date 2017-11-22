(function(generator) {
  if (typeof exports === 'object') {
    exports.mod = require('./she_c.js')
    generator(exports, true)
  } else {
    let exports = {}
    exports.mod = {}
    window.she = generator(exports, false)
  }
})(function(exports, isNodeJs) {

  const MCLBN_CURVE_FP254BNB = 0
  const MCLBN_CURVE_FP382_1 = 1
  const MCLBN_CURVE_FP382_2 = 2

  const MCLBN_FP_UNIT_SIZE = 4

  const MCLBN_FP_SIZE = MCLBN_FP_UNIT_SIZE * 8
  const MCLBN_G1_SIZE = MCLBN_FP_SIZE * 3
  const MCLBN_G2_SIZE = MCLBN_FP_SIZE * 6
  const MCLBN_GT_SIZE = MCLBN_FP_SIZE * 12

  const SHE_SECRETKEY_SIZE = MCLBN_FP_SIZE * 2
  const SHE_PUBLICKEY_SIZE = MCLBN_G1_SIZE + MCLBN_G2_SIZE
  const SHE_CIPHERTEXT_G1_SIZE = MCLBN_G1_SIZE * 2
  const SHE_CIPHERTEXT_G2_SIZE = MCLBN_G2_SIZE * 2
  const SHE_CIPHERTEXT_GT_SIZE = MCLBN_GT_SIZE * 4

  let mod = exports.mod

  /*
    init she
    @param range [in] table size of DLP ; require 8 * table size
    @param tryNum [in] how many search ; O(tryNum) time
    can decrypt (range * tryNum) range value
  */
  exports.init = (range = 1024, tryNum = 1024) => {
    console.log('init')
    if (!isNodeJs) {
      fetch('she_c.wasm')
        .then(response => response.arrayBuffer())
        .then(buffer => new Uint8Array(buffer))
        .then(binary => { Module(mod) })
    }
    return new Promise((resolve) => {
      mod.onRuntimeInitialized = () => {
        define_extra_functions(mod)
        let r = mod._sheInit(MCLBN_CURVE_FP254BNB, MCLBN_FP_UNIT_SIZE)
        console.log(`initializing sheSetRangeForDLP(range=${range}, tryNum=${tryNum})`)
        r = mod._sheSetRangeForDLP(range, tryNum)
        console.log('finished ' + r)
        resolve()
      }
    })
  }

  const ptrToStr = function(pos, n) {
    let s = ''
      for (let i = 0; i < n; i++) {
      s += String.fromCharCode(mod.HEAP8[pos + i])
    }
    return s
  }
  const Uint8ArrayToMem = function(pos, buf) {
    for (let i = 0; i < buf.length; i++) {
      mod.HEAP8[pos + i] = buf[i]
    }
  }
  const AsciiStrToMem = function(pos, s) {
    for (let i = 0; i < s.length; i++) {
      mod.HEAP8[pos + i] = s.charCodeAt(i)
    }
  }
  const copyToUint32Array = function(a, pos) {
    a.set(mod.HEAP32.subarray(pos / 4, pos / 4 + a.length))
//    for (let i = 0; i < a.length; i++) {
//      a[i] = mod.HEAP32[pos / 4 + i]
//    }
  }
  const copyFromUint32Array = function(pos, a) {
    for (let i = 0; i < a.length; i++) {
      mod.HEAP32[pos / 4 + i] = a[i]
    }
  }
  exports.toHex = function(a, start, n) {
    let s = ''
    for (let i = 0; i < n; i++) {
      s += ('0' + a[start + i].toString(16)).slice(-2)
    }
    return s
  }
  // Uint8Array to hex string
  exports.toHexStr = function(a) {
    return exports.toHex(a, 0, a.length)
  }
  // hex string to Uint8Array
  exports.fromHexStr = function(s) {
    if (s.length & 1) throw('fromHexStr:length must be even ' + s.length)
    let n = s.length / 2
    let a = new Uint8Array(n)
    for (let i = 0; i < n; i++) {
      a[i] = parseInt(s.slice(i * 2, i * 2 + 2), 16)
    }
    return a
  }

  const wrap_outputString = function(func, doesReturnString = true) {
    return function(x, ioMode = 0) {
      let maxBufSize = 2048
      let stack = mod.Runtime.stackSave()
      let pos = mod.Runtime.stackAlloc(maxBufSize)
      let n = func(pos, maxBufSize, x, ioMode)
      if (n < 0) {
        throw('err gen_str:' + x)
      }
      if (doesReturnString) {
        let s = ptrToStr(pos, n)
        mod.Runtime.stackRestore(stack)
        return s
      } else {
        let a = new Uint8Array(n)
        for (let i = 0; i < n; i++) {
          a[i] = mod.HEAP8[pos + i]
        }
        mod.Runtime.stackRestore(stack)
        return a
      }
    }
  }
  const wrap_outputArray = function(func) {
    return wrap_outputString(func, false)
  }
  /*
    argNum : n
    func(x0, ..., x_(n-1), buf, ioMode)
    => func(x0, ..., x_(n-1), pos, buf.length, ioMode)
  */
  const wrap_input = function(func, argNum, returnValue = false) {
    return function() {
      const args = [...arguments]
      let buf = args[argNum]
      let ioMode = args[argNum + 1] // may undefined
      let stack = mod.Runtime.stackSave()
      let pos = mod.Runtime.stackAlloc(buf.length)
      if (typeof(buf) == "string") {
        AsciiStrToMem(pos, buf)
      } else {
        Uint8ArrayToMem(pos, buf)
      }
      let r = func(...args.slice(0, argNum), pos, buf.length, ioMode)
      mod.Runtime.stackRestore(stack)
      if (returnValue) return r
      if (r) throw('err wrap_input ' + buf)
    }
  }
  const callSetter = function(func, a, p1, p2) {
    let pos = mod._malloc(a.length * 4)
    func(pos, p1, p2) // p1, p2 may be undefined
    copyToUint32Array(a, pos)
    mod._free(pos)
  }
  const callGetter = function(func, a, p1, p2) {
    let pos = mod._malloc(a.length * 4)
    mod.HEAP32.set(a, pos / 4)
    let s = func(pos, p1, p2)
    mod._free(pos)
    return s
  }
  const wrap_dec = function(func) {
    return function(sec, c) {
      let stack = mod.Runtime.stackSave()
      let pos = mod.Runtime.stackAlloc(8)
      let r = func(pos, sec, c)
      mod.Runtime.stackRestore(stack)
      if (r != 0) throw('sheDec')
      let v = mod.HEAP32[pos / 4]
      return v
    }
  }
  const callEnc = function(func, cstr, pub, m) {
    let c = new cstr()
    let stack = mod.Runtime.stackSave()
    let cPos = mod.Runtime.stackAlloc(c.a_.length * 4)
    let pubPos = mod.Runtime.stackAlloc(pub.length * 4)
    copyFromUint32Array(pubPos, pub);
    func(cPos, pubPos, m)
    copyToUint32Array(c.a_, cPos)
    mod.Runtime.stackRestore(stack)
    return c
  }
  // return func(x, y)
  const callAddSub = function(func, cstr, x, y) {
    let z = new cstr()
    let stack = mod.Runtime.stackSave()
    let xPos = mod.Runtime.stackAlloc(x.length * 4)
    let yPos = mod.Runtime.stackAlloc(y.length * 4)
    let zPos = mod.Runtime.stackAlloc(z.a_.length * 4)
    copyFromUint32Array(xPos, x);
    copyFromUint32Array(yPos, y);
    func(zPos, xPos, yPos)
    copyToUint32Array(z.a_, zPos)
    mod.Runtime.stackRestore(stack)
    return z
  }
  // return func(x, y)
  const callMulInt = function(func, cstr, x, y) {
    let z = new cstr()
    let stack = mod.Runtime.stackSave()
    let xPos = mod.Runtime.stackAlloc(x.length * 4)
    let zPos = mod.Runtime.stackAlloc(z.a_.length * 4)
    copyFromUint32Array(xPos, x);
    func(zPos, xPos, y)
    copyToUint32Array(z.a_, zPos)
    mod.Runtime.stackRestore(stack)
    return z
  }
  // return func(c)
  const callDec = function(func, sec, c) {
    let stack = mod.Runtime.stackSave()
    let secPos = mod.Runtime.stackAlloc(sec.length * 4)
    let cPos = mod.Runtime.stackAlloc(c.length * 4)
    copyFromUint32Array(secPos, sec);
    copyFromUint32Array(cPos, c);
    let r = func(secPos, cPos)
    mod.Runtime.stackRestore(stack)
    return r
  }
  const callIsZero = function(func, sec, c) {
    let stack = mod.Runtime.stackSave()
    let secPos = mod.Runtime.stackAlloc(sec.length * 4)
    let cPos = mod.Runtime.stackAlloc(c.length * 4)
    copyFromUint32Array(secPos, sec);
    copyFromUint32Array(cPos, c);
    let r = func(secPos, cPos)
    mod.Runtime.stackRestore(stack)
    return r
  }
  // reRand(c)
  const callReRand = function(func, c, pub) {
    let stack = mod.Runtime.stackSave()
    let cPos = mod.Runtime.stackAlloc(c.length * 4)
    let pubPos = mod.Runtime.stackAlloc(pub.length * 4)
    copyFromUint32Array(cPos, c);
    copyFromUint32Array(pubPos, pub);
    let r = func(cPos, pubPos)
    copyToUint32Array(c, cPos)
    mod.Runtime.stackRestore(stack)
    if (r) throw('callReRand err')
  }
  // convert
  const callConvert = function(func, pub, c) {
    let ct = new exports.CipherTextGT()
    let stack = mod.Runtime.stackSave()
    let ctPos = mod.Runtime.stackAlloc(ct.a_.length * 4)
    let pubPos = mod.Runtime.stackAlloc(pub.length * 4)
    let cPos = mod.Runtime.stackAlloc(c.length * 4)
    copyFromUint32Array(pubPos, pub);
    copyFromUint32Array(cPos, c);
    let r = func(ctPos, pubPos, cPos)
    copyToUint32Array(ct.a_, ctPos)
    mod.Runtime.stackRestore(stack)
    if (r) throw('callConvert err')
    return ct
  }
  const define_extra_functions = function(mod) {
    mod.sheSecretKeySerialize = wrap_outputArray(mod._sheSecretKeySerialize)
    mod.sheSecretKeyDeserialize = wrap_input(mod._sheSecretKeyDeserialize, 1)
    mod.shePublicKeySerialize = wrap_outputArray(mod._shePublicKeySerialize)
    mod.shePublicKeyDeserialize = wrap_input(mod._shePublicKeyDeserialize, 1)
    mod.sheCipherTextG1Serialize = wrap_outputArray(mod._sheCipherTextG1Serialize)
    mod.sheCipherTextG1Deserialize = wrap_input(mod._sheCipherTextG1Deserialize, 1)
    mod.sheDecG1 = wrap_dec(mod._sheDecG1)
    mod.sheCipherTextG2Serialize = wrap_outputArray(mod._sheCipherTextG2Serialize)
    mod.sheCipherTextG2Deserialize = wrap_input(mod._sheCipherTextG2Deserialize, 1)
    mod.sheDecG2 = wrap_dec(mod._sheDecG2)
    mod.sheCipherTextGTSerialize = wrap_outputArray(mod._sheCipherTextGTSerialize)
    mod.sheCipherTextGTDeserialize = wrap_input(mod._sheCipherTextGTDeserialize, 1)
    mod.sheDecGT = wrap_dec(mod._sheDecGT)

    class Common {
      constructor(size) {
        this.a_ = new Uint32Array(size / 4)
      }
      fromHexStr(s) {
        this.deserialize(exports.fromHexStr(s))
      }
      toHexStr() {
        return exports.toHexStr(this.serialize())
      }
      dump(msg = '') {
        console.log(msg + this.toHexStr())
      }
    }
    exports.SecretKey = class extends Common {
      constructor() {
        super(SHE_SECRETKEY_SIZE)
      }
      serialize() {
        return callGetter(mod.sheSecretKeySerialize, this.a_)
      }
      deserialize(s) {
        callSetter(mod.sheSecretKeyDeserialize, this.a_, s)
      }
      setByCSPRNG() {
        let stack = mod.Runtime.stackSave()
        let secPos = mod.Runtime.stackAlloc(this.a_.length * 4)
        mod._sheSecretKeySetByCSPRNG(secPos)
        copyToUint32Array(this.a_, secPos)
        mod.Runtime.stackRestore(stack)
      }
      getPublicKey() {
        let pub = new exports.PublicKey()
        let stack = mod.Runtime.stackSave()
        let secPos = mod.Runtime.stackAlloc(this.a_.length * 4)
        let pubPos = mod.Runtime.stackAlloc(pub.a_.length * 4)
        copyFromUint32Array(secPos, this.a_)
        mod._sheGetPublicKey(pubPos, secPos)
        copyToUint32Array(pub.a_, pubPos)
        mod.Runtime.stackRestore(stack)
        return pub
      }
      dec(c) {
        let dec = null
        if (exports.CipherTextG1.prototype.isPrototypeOf(c)) {
          dec = mod.sheDecG1
        } else if (exports.CipherTextG2.prototype.isPrototypeOf(c)) {
          dec = mod.sheDecG2
        } else if (exports.CipherTextGT.prototype.isPrototypeOf(c)) {
          dec = mod.sheDecGT
        } else {
          throw('exports.SecretKey.dec:not supported')
        }
        return callDec(dec, this.a_, c.a_)
      }
      isZero(c) {
        let isZero = null
        if (exports.CipherTextG1.prototype.isPrototypeOf(c)) {
          isZero = mod._sheIsZeroG1
        } else if (exports.CipherTextG2.prototype.isPrototypeOf(c)) {
          isZero = mod._sheIsZeroG2
        } else if (exports.CipherTextGT.prototype.isPrototypeOf(c)) {
          isZero = mod._sheIsZeroGT
        } else {
          throw('exports.SecretKey.isZero:not supported')
        }
        return callIsZero(isZero, this.a_, c.a_)
      }
    }

    exports.getSecretKeyFromHexStr = function(s) {
      r = new exports.SecretKey()
      r.fromHexStr(s)
      return r
    }
    exports.PublicKey = class extends Common {
      constructor() {
        super(SHE_PUBLICKEY_SIZE)
      }
      serialize() {
        return callGetter(mod.shePublicKeySerialize, this.a_)
      }
      deserialize(s) {
        callSetter(mod.shePublicKeyDeserialize, this.a_, s)
      }
      encG1(m) {
        return callEnc(mod._sheEnc32G1, exports.CipherTextG1, this.a_, m)
      }
      encG2(m) {
        return callEnc(mod._sheEnc32G2, exports.CipherTextG2, this.a_, m)
      }
      encGT(m) {
        return callEnc(mod._sheEnc32GT, exports.CipherTextGT, this.a_, m)
      }
      reRand(c) {
        let reRand = null
        if (exports.CipherTextG1.prototype.isPrototypeOf(c)) {
          reRand = mod._sheReRandG1
        } else if (exports.CipherTextG2.prototype.isPrototypeOf(c)) {
          reRand = mod._sheReRandG2
        } else if (exports.CipherTextGT.prototype.isPrototypeOf(c)) {
          reRand = mod._sheReRandGT
        } else {
          throw('exports.PublicKey.reRand:not supported')
        }
        return callReRand(reRand, c.a_, this.a_)
      }
      // convert to CipherTextGT
      convert(c) {
        let convert = null
        if (exports.CipherTextG1.prototype.isPrototypeOf(c)) {
          convert = mod._sheConvertG1
        } else if (exports.CipherTextG2.prototype.isPrototypeOf(c)) {
          convert = mod._sheConvertG2
        } else {
          throw('exports.PublicKey.convert:not supported')
        }
        return callConvert(convert, this.a_, c.a_)
      }
    }

    exports.getPublicKeyFromHexStr = function(s) {
      r = new exports.PublicKey()
      r.fromHexStr(s)
      return r
    }
    exports.CipherTextG1 = class extends Common {
      constructor() {
        super(SHE_CIPHERTEXT_G1_SIZE)
      }
      serialize() {
        return callGetter(mod.sheCipherTextG1Serialize, this.a_)
      }
      deserialize(s) {
        callSetter(mod.sheCipherTextG1Deserialize, this.a_, s)
      }
    }

    exports.getCipherTextG1FromHexStr = function(s) {
      r = new exports.CipherTextG1()
      r.fromHexStr(s)
      return r
    }
    exports.CipherTextG2 = class extends Common {
      constructor() {
        super(SHE_CIPHERTEXT_G2_SIZE)
      }
      serialize() {
        return callGetter(mod.sheCipherTextG2Serialize, this.a_)
      }
      deserialize(s) {
        callSetter(mod.sheCipherTextG2Deserialize, this.a_, s)
      }
    }

    exports.getCipherTextG2FromHexStr = function(s) {
      r = new exports.CipherTextG2()
      r.fromHexStr(s)
      return r
    }

    exports.CipherTextGT = class extends Common {
      constructor() {
        super(SHE_CIPHERTEXT_GT_SIZE)
      }
      serialize() {
        return callGetter(mod.sheCipherTextGTSerialize, this.a_)
      }
      deserialize(s) {
        callSetter(mod.sheCipherTextGTDeserialize, this.a_, s)
      }
    }

    exports.getCipherTextGTFromHexStr = function(s) {
      r = new exports.CipherTextGT()
      r.fromHexStr(s)
      return r
    }
    // return x + y
    exports.add = function(x, y) {
      if  (x.a_.length != y.a_.length) throw('exports.add:bad type')
      let add = null
      let cstr = null
      if (exports.CipherTextG1.prototype.isPrototypeOf(x)) {
        add = mod._sheAddG1
        cstr = exports.CipherTextG1
      } else if (exports.CipherTextG2.prototype.isPrototypeOf(x)) {
        add = mod._sheAddG2
        cstr = exports.CipherTextG2
      } else if (exports.CipherTextGT.prototype.isPrototypeOf(x)) {
        add = mod._sheAddGT
        cstr = exports.CipherTextGT
      } else {
        throw('exports.add:not supported')
      }
      return callAddSub(add, cstr, x.a_, y.a_)
    }
    // return x - y
    exports.sub = function(x, y) {
      if  (x.a_.length != y.a_.length) throw('exports.sub:bad type')
      let sub = null
      let cstr = null
      if (exports.CipherTextG1.prototype.isPrototypeOf(x)) {
        sub = mod._sheSubG1
        cstr = exports.CipherTextG1
      } else if (exports.CipherTextG2.prototype.isPrototypeOf(x)) {
        sub = mod._sheSubG2
        cstr = exports.CipherTextG2
      } else if (exports.CipherTextGT.prototype.isPrototypeOf(x)) {
        sub = mod._sheSubGT
        cstr = exports.CipherTextGT
      } else {
        throw('exports.sub:not supported')
      }
      return callAddSub(sub, cstr, x.a_, y.a_)
    }
    // return x * (int)y
    exports.mulInt = function(x, y) {
      let mulInt = null
      let cstr = null
      if (exports.CipherTextG1.prototype.isPrototypeOf(x)) {
        mulInt = mod._sheMul32G1
        cstr = exports.CipherTextG1
      } else if (exports.CipherTextG2.prototype.isPrototypeOf(x)) {
        mulInt = mod._sheMul32G2
        cstr = exports.CipherTextG2
      } else if (exports.CipherTextGT.prototype.isPrototypeOf(x)) {
        mulInt = mod._sheMul32GT
        cstr = exports.CipherTextGT
      } else {
        throw('exports.mulInt:not supported')
      }
      return callMulInt(mulInt, cstr, x.a_, y)
    }
    // return (G1)x * (G2)y
    exports.mul = function(x, y) {
      if (!exports.CipherTextG1.prototype.isPrototypeOf(x)
        || !exports.CipherTextG2.prototype.isPrototypeOf(y)) throw('exports.mul:bad type')
      let z = new exports.CipherTextGT()
      let stack = mod.Runtime.stackSave()
      let xPos = mod.Runtime.stackAlloc(x.a_.length * 4)
      let yPos = mod.Runtime.stackAlloc(y.a_.length * 4)
      let zPos = mod.Runtime.stackAlloc(z.a_.length * 4)
      copyFromUint32Array(xPos, x.a_)
      copyFromUint32Array(yPos, y.a_)
      mod._sheMul(zPos, xPos, yPos)
      copyToUint32Array(z.a_, zPos)
      mod.Runtime.stackRestore(stack)
      return z
    }
  }
  return exports
})
