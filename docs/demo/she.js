function setupWasm(fileName, nameSpace, setupFct) {
	console.log('setupWasm ' + fileName)
	let mod = {}
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

const MCLBN_CURVE_FP254BNB = 0
const MCLBN_FP_UNIT_SIZE = 4

function define_she_extra_functions(mod) {
	wrap_outputString = function(func, doesReturnString = true) {
		return function(x, ioMode = 0) {
			let maxBufSize = 2048
			let stack = mod.Runtime.stackSave()
			let pos = mod.Runtime.stackAlloc(maxBufSize)
			let n = func(pos, maxBufSize, x, ioMode)
			if (n < 0) {
				throw('err gen_str:' + x)
			}
			if (doesReturnString) {
				let s = ''
				for (let i = 0; i < n; i++) {
					s += String.fromCharCode(mod.HEAP8[pos + i])
				}
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
	wrap_outputArray = function(func) {
		return wrap_outputString(func, false)
	}
	wrap_input0 = function(func, returnValue = false) {
		return function(buf, ioMode = 0) {
			let stack = mod.Runtime.stackSave()
			let pos = mod.Runtime.stackAlloc(buf.length)
			if (typeof(buf) == "string") {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf.charCodeAt(i)
				}
			} else {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf[i]
				}
			}
			let r = func(pos, buf.length, ioMode)
			mod.Runtime.stackRestore(stack)
			if (returnValue) return r
			if (r) throw('err wrap_input0 ' + buf)
		}
	}
	wrap_input1 = function(func, returnValue = false) {
		return function(x1, buf, ioMode = 0) {
			let stack = mod.Runtime.stackSave()
			let pos = mod.Runtime.stackAlloc(buf.length)
			if (typeof(buf) == "string") {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf.charCodeAt(i)
				}
			} else {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf[i]
				}
			}
			let r = func(x1, pos, buf.length, ioMode)
			mod.Runtime.stackRestore(stack)
			if (returnValue) return r
			if (r) throw('err wrap_input1 ' + buf)
		}
	}
	wrap_input2 = function(func, returnValue = false) {
		return function(x1, x2, buf, ioMode = 0) {
			let stack = mod.Runtime.stackSave()
			let pos = mod.Runtime.stackAlloc(buf.length)
			if (typeof(buf) == "string") {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf.charCodeAt(i)
				}
			} else {
				for (let i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf[i]
				}
			}
			let r = func(x1, x2, pos, buf.length, ioMode)
			mod.Runtime.stackRestore(stack)
			if (returnValue) return r
			if (r) throw('err wrap_input2 ' + buf)
		}
	}
	wrap_keyShare = function(func, dataSize) {
		return function(x, vec, id) {
			let k = vec.length
			let p = mod._malloc(dataSize * k)
			for (let i = 0; i < k; i++) {
				mod._memcpy(p + i * dataSize, vec[i], dataSize)
			}
			let r = func(x, p, k, id)
			mod._free(p)
			if (r) throw('keyShare ' + k)
		}
	}
	wrap_dec = function(func) {
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
	///////////////////////////////////////////////////////////////
	const FR_SIZE = MCLBN_FP_UNIT_SIZE * 8
	const G1_SIZE = FR_SIZE * 3
	const G2_SIZE = FR_SIZE * 3 * 2
	const GT_SIZE = FR_SIZE * 12

	const SECRETKEY_SIZE = FR_SIZE * 2
	const PUBLICKEY_SIZE = G1_SIZE + G2_SIZE
	const CIPHERTEXT_G1_SIZE = G1_SIZE * 2
	const CIPHERTEXT_G2_SIZE = G2_SIZE * 2
	const CIPHERTEXT_GT_SIZE = GT_SIZE * 4

	she_free = function(p) {
		mod._free(p)
	}
	///////////////////////////////////////////////////////////////
	sheSecretKey_malloc = function() {
		return mod._malloc(SECRETKEY_SIZE)
	}
	sheSecretKeySerialize = wrap_outputArray(_sheSecretKeySerialize)
	sheSecretKeyDeserialize = wrap_input1(_sheSecretKeyDeserialize)
	///////////////////////////////////////////////////////////////
	shePublicKey_malloc = function() {
		return mod._malloc(PUBLICKEY_SIZE)
	}
	shePublicKeySerialize = wrap_outputArray(_shePublicKeySerialize)
	shePublicKeyDeserialize = wrap_input1(_shePublicKeyDeserialize)
	///////////////////////////////////////////////////////////////
	sheCipherTextG1_malloc = function() {
		return mod._malloc(CIPHERTEXT_G1_SIZE)
	}
	sheCipherTextG1Serialize = wrap_outputArray(_sheCipherTextG1Serialize)
	sheCipherTextG1Deserialize = wrap_input1(_sheCipherTextG1Deserialize)
	sheDecG1 = wrap_dec(_sheDecG1)
	///////////////////////////////////////////////////////////////
	sheCipherTextG2_malloc = function() {
		return mod._malloc(CIPHERTEXT_G2_SIZE)
	}
	sheCipherTextG2Serialize = wrap_outputArray(_sheCipherTextG2Serialize)
	sheCipherTextG2Deserialize = wrap_input1(_sheCipherTextG2Deserialize)
	///////////////////////////////////////////////////////////////
	sheCipherTextGT_malloc = function() {
		return mod._malloc(CIPHERTEXT_GT_SIZE)
	}
	sheCipherTextGTSerialize = wrap_outputArray(_sheCipherTextGTSerialize)
	sheCipherTextGTDeserialize = wrap_input1(_sheCipherTextGTDeserialize)
	sheDecGT = wrap_dec(_sheDecGT)

	sheInit = function(curveType = MCLBN_CURVE_FP254BNB) {
		let r = _sheInit(curveType, MCLBN_FP_UNIT_SIZE)
		console.log('sheInit ' + r)
		if (r) throw('sheInit')
//		r = sheSetRangeForGTDLP(128, 1024)
	}
}

