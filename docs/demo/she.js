(function(return_she) {
	if (typeof exports === 'object') {
		module.exports = return_she()
	} else {
		window.she = return_she()
	}
})(function() {
	const crypto = window.crypto || window.msCrypto

	const MCLBN_CURVE_FP254BNB = 0
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

	let mod = {}
	let she = {}
	she.mod = mod

	const setupWasm = function(fileName, nameSpace, setupFct) {
		console.log('setupWasm ' + fileName)
		fetch(fileName)
			.then(response => response.arrayBuffer())
			.then(buffer => new Uint8Array(buffer))
			.then(binary => {
				mod['wasmBinary'] = binary
				mod['onRuntimeInitialized'] = function() {
					setupFct(mod, nameSpace)
					console.log('setupWasm end')
				}
				Module(mod)
			})
		return mod
	}

	const define_she_extra_functions = function(mod) {
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
		const wrap_input0 = function(func, returnValue = false) {
			return function(buf, ioMode = 0) {
				let stack = mod.Runtime.stackSave()
				let pos = mod.Runtime.stackAlloc(buf.length)
				if (typeof(buf) == "string") {
					AsciiStrToMem(pos, buf)
				} else {
					Uint8ArrayToMem(pos, buf)
				}
				let r = func(pos, buf.length, ioMode)
				mod.Runtime.stackRestore(stack)
				if (returnValue) return r
				if (r) throw('err wrap_input0 ' + buf)
			}
		}
		const wrap_input1 = function(func, returnValue = false) {
			return function(x1, buf, ioMode = 0) {
				let stack = mod.Runtime.stackSave()
				let pos = mod.Runtime.stackAlloc(buf.length)
				if (typeof(buf) == "string") {
					AsciiStrToMem(pos, buf)
				} else {
					Uint8ArrayToMem(pos, buf)
				}
				let r = func(x1, pos, buf.length, ioMode)
				mod.Runtime.stackRestore(stack)
				if (returnValue) return r
				if (r) throw('err wrap_input1 ' + buf)
			}
		}
		const wrap_input2 = function(func, returnValue = false) {
			return function(x1, x2, buf, ioMode = 0) {
				let stack = mod.Runtime.stackSave()
				let pos = mod.Runtime.stackAlloc(buf.length)
				if (typeof(buf) == "string") {
					AsciiStrToMem(pos, buf)
				} else {
					Uint8ArrayToMem(pos, buf)
				}
				let r = func(x1, x2, pos, buf.length, ioMode)
				mod.Runtime.stackRestore(stack)
				if (returnValue) return r
				if (r) throw('err wrap_input2 ' + buf)
			}
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
		const copyToUint32Array = function(a, pos) {
			for (let i = 0; i < a.length; i++) {
				a[i] = mod.HEAP32[pos / 4 + i]
			}
		}
		const copyFromUint32Array = function(pos, a) {
			for (let i = 0; i < a.length; i++) {
				mod.HEAP32[pos / 4 + i] = a[i]
			}
		}
		she.callSetter = function(func, a, p1, p2) {
			let pos = mod._malloc(a.length * 4)
			func(pos, p1, p2) // p1, p2 may be undefined
			copyToUint32Array(a, pos)
			mod._free(pos)
		}
		she.callGetter = function(func, a, p1, p2) {
			let pos = mod._malloc(a.length * 4)
			mod.HEAP32.set(a, pos / 4)
			let s = func(pos, p1, p2)
			mod._free(pos)
			return s
		}
		she.callModifier = function(func, a, p1, p2) {
			let pos = mod._malloc(a.length * 4)
			mod.HEAP32.set(a, pos / 4)
			func(pos, p1, p2) // p1, p2 may be undefined
			copyToUint32Array(a, pos)
			mod._free(pos)
		}
		she.toHex = function(a, start, n) {
			let s = ''
			for (let i = 0; i < n; i++) {
				s += ('0' + a[start + i].toString(16)).slice(-2)
			}
			return s
		}
		she.callEnc = function(func, cstr, pub, m) {
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
		she.callMul = function(func, cstr, pub, m) {
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
		she.callAddSub = function(func, cstr, x, y) {
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
		// z = func(x, y)
		she.callMulInt = function(func, cstr, x, y) {
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
		she.callDec = function(func, sec, c) {
			let stack = mod.Runtime.stackSave()
			let secPos = mod.Runtime.stackAlloc(sec.length * 4)
			let cPos = mod.Runtime.stackAlloc(c.length * 4)
			copyFromUint32Array(secPos, sec);
			copyFromUint32Array(cPos, c);
			let r = func(secPos, cPos)
			mod.Runtime.stackRestore(stack)
			return r
		}
		she_free = function(p) {
			mod._free(p)
		}
		sheSecretKey_malloc = function() {
			return mod._malloc(SHE_SECRETKEY_SIZE)
		}
		shePublicKey_malloc = function() {
			return mod._malloc(SHE_PUBLICKEY_SIZE)
		}
		sheCipherTextG2_malloc = function() {
			return mod._malloc(SHE_CIPHERTEXT_G2_SIZE)
		}
		sheCipherTextGT_malloc = function() {
			return mod._malloc(SHE_CIPHERTEXT_GT_SIZE)
		}
		sheCipherTextG1_malloc = function() {
			return mod._malloc(SHE_CIPHERTEXT_G1_SIZE)
		}
		sheSecretKeySerialize = wrap_outputArray(_sheSecretKeySerialize)
		sheSecretKeyDeserialize = wrap_input1(_sheSecretKeyDeserialize)
		shePublicKeySerialize = wrap_outputArray(_shePublicKeySerialize)
		shePublicKeyDeserialize = wrap_input1(_shePublicKeyDeserialize)
		sheCipherTextG1Serialize = wrap_outputArray(_sheCipherTextG1Serialize)
		sheCipherTextG1Deserialize = wrap_input1(_sheCipherTextG1Deserialize)
		sheDecG1 = wrap_dec(_sheDecG1)
		sheCipherTextG2Serialize = wrap_outputArray(_sheCipherTextG2Serialize)
		sheCipherTextG2Deserialize = wrap_input1(_sheCipherTextG2Deserialize)
		sheDecG2 = wrap_dec(_sheDecG2)
		sheCipherTextGTSerialize = wrap_outputArray(_sheCipherTextGTSerialize)
		sheCipherTextGTDeserialize = wrap_input1(_sheCipherTextGTDeserialize)
		sheDecGT = wrap_dec(_sheDecGT)

		sheInit = function(curveType = MCLBN_CURVE_FP254BNB) {
			let r = _sheInit(curveType, MCLBN_FP_UNIT_SIZE)
			console.log('sheInit ' + r)
			if (r) throw('sheInit')
		}
		she.SecretKey = function() {
			this.a_ = new Uint32Array(SHE_SECRETKEY_SIZE / 4)
		}
		she.SecretKey.prototype.serialize = function() {
			return she.callGetter(sheSecretKeySerialize, this.a_)
		}
		she.SecretKey.prototype.deserialize = function(s) {
			return she.callSetter(sheSecretKeyDeserialize, this.a_, s)
		}
		she.PublicKey = function() {
			this.a_ = new Uint32Array(SHE_PUBLICKEY_SIZE / 4)
		}
		she.PublicKey.prototype.serialize = function() {
			return she.callGetter(shePublicKeySerialize, this.a_)
		}
		she.PublicKey.prototype.deserialize = function(s) {
			return she.callSetter(shePublicKeyDeserialize, this.a_, s)
		}
		she.CipherTextG1 = function() {
			this.a_ = new Uint32Array(SHE_CIPHERTEXT_G1_SIZE / 4)
		}
		she.CipherTextG1.prototype.serialize = function() {
			return she.callGetter(sheCipherTextG1Serialize, this.a_)
		}
		she.CipherTextG1.prototype.deserialize = function(s) {
			return she.callSetter(sheCipherTextG1Deserialize, this.a_, s)
		}
		she.CipherTextG2 = function() {
			this.a_ = new Uint32Array(SHE_CIPHERTEXT_G2_SIZE / 4)
		}
		she.CipherTextG2.prototype.serialize = function() {
			return she.callGetter(sheCipherTextG2Serialize, this.a_)
		}
		she.CipherTextG2.prototype.deserialize = function(s) {
			return she.callSetter(sheCipherTextG2Deserialize, this.a_, s)
		}
		she.CipherTextGT = function() {
			this.a_ = new Uint32Array(SHE_CIPHERTEXT_GT_SIZE / 4)
		}
		she.CipherTextGT.prototype.serialize = function() {
			return she.callGetter(sheCipherTextGTSerialize, this.a_)
		}
		she.CipherTextGT.prototype.deserialize = function(s) {
			return she.callSetter(sheCipherTextGTDeserialize, this.a_, s)
		}
		she.SecretKey.prototype.setByCSPRNG = function() {
			let stack = mod.Runtime.stackSave()
			let secPos = mod.Runtime.stackAlloc(this.a_.length * 4)
			sheSecretKeySetByCSPRNG(secPos)
			copyToUint32Array(this.a_, secPos)
			mod.Runtime.stackRestore(stack)
		}
		she.SecretKey.prototype.getPublicKey = function() {
			let pub = new she.PublicKey()
			let stack = mod.Runtime.stackSave()
			let secPos = mod.Runtime.stackAlloc(this.a_.length * 4)
			let pubPos = mod.Runtime.stackAlloc(pub.a_.length * 4)
			copyFromUint32Array(secPos, this.a_)
			sheGetPublicKey(pubPos, secPos)
			copyToUint32Array(pub.a_, pubPos)
			mod.Runtime.stackRestore(stack)
			return pub
		}
		she.PublicKey.prototype.encG1 = function(m) {
			return she.callEnc(sheEnc32G1, she.CipherTextG1, this.a_, m)
		}
		she.PublicKey.prototype.encG2 = function(m) {
			return she.callEnc(sheEnc32G2, she.CipherTextG2, this.a_, m)
		}
		she.PublicKey.prototype.encGT = function(m) {
			return she.callEnc(sheEnc32GT, she.CipherTextGT, this.a_, m)
		}
		// return x + y
		she.add = function(x, y) {
			if  (x.a_.length != y.a_.length) throw('she.add:bad type')
			let add = null
			let cstr = null
			if (she.CipherTextG1.prototype.isPrototypeOf(x)) {
				add = sheAddG1
				cstr = she.CipherTextG1
			} else if (she.CipherTextG2.prototype.isPrototypeOf(x)) {
				add = sheAddG2
				cstr = she.CipherTextG2
			} else if (she.CipherTextGT.prototype.isPrototypeOf(x)) {
				add = sheAddGT
				cstr = she.CipherTextGT
			} else {
				throw('she.add:not supported')
			}
			return she.callAddSub(add, cstr, x.a_, y.a_)
		}
		// return x - y
		she.sub = function(x, y) {
			if  (x.a_.length != y.a_.length) throw('she.sub:bad type')
			let sub = null
			let cstr = null
			if (she.CipherTextG1.prototype.isPrototypeOf(x)) {
				sub = sheSubG1
				cstr = she.CipherTextG1
			} else if (she.CipherTextG2.prototype.isPrototypeOf(x)) {
				sub = sheSubG2
				cstr = she.CipherTextG2
			} else if (she.CipherTextGT.prototype.isPrototypeOf(x)) {
				sub = sheSubGT
				cstr = she.CipherTextGT
			} else {
				throw('she.sub:not supported')
			}
			return she.callAddSub(sub, cstr, x.a_, y.a_)
		}
		// return x * (int)y
		she.mulInt = function(x, y) {
			let mulInt = null
			let cstr = null
			if (she.CipherTextG1.prototype.isPrototypeOf(x)) {
				mulInt = sheMul32G1
				cstr = she.CipherTextG1
			} else if (she.CipherTextG2.prototype.isPrototypeOf(x)) {
				mulInt = sheMul32G2
				cstr = she.CipherTextG2
			} else if (she.CipherTextGT.prototype.isPrototypeOf(x)) {
				mulInt = sheMul32GT
				cstr = she.CipherTextGT
			} else {
				throw('she.mulInt:not supported')
			}
			return she.callMulInt(mulInt, cstr, x.a_, y)
		}
		// return (G1)x * (G2)y
		she.mul = function(x, y) {
			if (!she.CipherTextG1.prototype.isPrototypeOf(x)
				|| !she.CipherTextG2.prototype.isPrototypeOf(y)) throw('she.mul:bad type')
			let z = new she.CipherTextGT()
			let stack = mod.Runtime.stackSave()
			let xPos = mod.Runtime.stackAlloc(x.a_.length * 4)
			let yPos = mod.Runtime.stackAlloc(y.a_.length * 4)
			let zPos = mod.Runtime.stackAlloc(z.a_.length * 4)
			copyFromUint32Array(xPos, x.a_)
			copyFromUint32Array(yPos, y.a_)
			sheMul(zPos, xPos, yPos)
			copyToUint32Array(z.a_, zPos)
			mod.Runtime.stackRestore(stack)
			return z
		}
		she.SecretKey.prototype.dec = function(c) {
			let dec = null
			if (she.CipherTextG1.prototype.isPrototypeOf(c)) {
				dec = sheDecG1
			} else if (she.CipherTextG2.prototype.isPrototypeOf(c)) {
				dec = sheDecG2
			} else if (she.CipherTextGT.prototype.isPrototypeOf(c)) {
				dec = sheDecGT
			} else {
				throw('she.SecretKey.dec is not supported')
			}
			return she.callDec(dec, this.a_, c.a_)
		}
	}

	she.init = function(range = 1024, tryNum = 1024, callback = null) {
		setupWasm('mclshe.wasm', null, function(_mod, ns) {
			mod = _mod
			define_exported_she(mod)
			define_she_extra_functions(mod)
			sheInit()
			console.log('initializing sheSetRangeForDLP')
			let r = sheSetRangeForDLP(range, tryNum)
			console.log('finished ' + r)
			if (callback) callback()
		})
	}
	return she
})
