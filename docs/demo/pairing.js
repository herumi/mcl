function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

function setupWasm(fileName, nameSpace, setupFct) {
	console.log('setupWasm ' + fileName)
	var mod = {}
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

var MCLBN_FP_UNIT_SIZE = 4

var module = setupWasm('mclbn.wasm', null, function(mod, ns) {
	define_exported_mcl(mod)
	define_extra_functions(mod)
	var r = mclBn_init(0)
	setText('status', r ? 'err:' + r : 'ok')
})

function define_extra_functions(mod) {
	gen_setStr = function(func) {
		return function(x, buf, ioMode) {
			if (ioMode == null) { ioMode = 0 }
			var stack = mod.Runtime.stackSave()
			var pos = mod.Runtime.stackAlloc(buf.length)
			for (var i = 0; i < buf.length; i++) {
				mod.HEAP8[pos + i] = buf.charCodeAt(i)
			}
			r = func(x, pos, buf.length, ioMode)
			mod.Runtime.stackRestore(stack)
			if (r) console.log('err gen_setStr ' + r)
		}
	}
	gen_getStr = function(func) {
		return function(x, ioMode) {
			if (ioMode == null) { ioMode = 0 }
			var maxBufSize = 2048
			var stack = mod.Runtime.stackSave()
			var pos = mod.Runtime.stackAlloc(maxBufSize)
			var n = func(pos, maxBufSize, x, ioMode)
			if (n < 0) {
				console.log('err gen_getStr')
				return ''
			}
			var s = ''
			for (var i = 0; i < n; i++) {
				s += String.fromCharCode(mod.HEAP8[pos + i])
			}
			mod.Runtime.stackRestore(stack)
			return s
		}
	}
	gen_deserialize = function(func) {
		return function(x, buf) {
			var stack = mod.Runtime.stackSave()
			var pos = mod.Runtime.stackAlloc(buf.length)
			if (typeof(buf) == "string") {
				for (var i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf.charCodeAt(i)
				}
			} else {
				for (var i = 0; i < buf.length; i++) {
					mod.HEAP8[pos + i] = buf[i]
				}
			}
			r = func(x, pos, buf.length)
			mod.Runtime.stackRestore(stack)
			if (r) console.log('err gen_deserialize ' + r)
		}
	}
	gen_serialize = function(func) {
		return function(x) {
			var maxBufSize = 2048
			var stack = mod.Runtime.stackSave()
			var pos = mod.Runtime.stackAlloc(maxBufSize)
			var n = func(pos, maxBufSize, x)
			if (n < 0) {
				console.log('err gen_serialize')
				return ''
			}
			var a = new Uint8Array(n)
			for (var i = 0; i < n; i++) {
				a[i] = mod.HEAP8[pos + i]
			}
			mod.Runtime.stackRestore(stack)
			return a
		}
	}
	///////////////////////////////////////////////////////////////
	mclBn_init = function(curveType) {
		_mclBn_init(curveType, MCLBN_FP_UNIT_SIZE)
	}
	mclBnFr_malloc = function() {
		return mod._malloc(MCLBN_FP_UNIT_SIZE * 8)
	}
	mclBnFr_free = function(x) {
		mod._free(x)
	}
	mclBnFr_deserialize = gen_deserialize(_mclBnFr_deserialize)
	mclBnFr_setLittleEndian = gen_deserialize(_mclBnFr_setLittleEndian)
	mclBnFr_setStr = gen_setStr(_mclBnFr_setStr)
	mclBnFr_getStr = gen_getStr(_mclBnFr_getStr)
	mclBnFr_setHashOf = gen_deserialize(_mclBnFr_setHashOf)

	///////////////////////////////////////////////////////////////
	mclBnG1_malloc = function() {
		return mod._malloc(MCLBN_FP_UNIT_SIZE * 8 * 3)
	}
	mclBnG1_free = function(x) {
		mod._free(x)
	}
	mclBnG1_setStr = gen_setStr(_mclBnG1_setStr)
	mclBnG1_getStr = gen_getStr(_mclBnG1_getStr)
	mclBnG1_deserialize = gen_deserialize(_mclBnG1_deserialize)
	mclBnG1_serialize = gen_serialize(_mclBnG1_serialize)
	mclBnG1_hashAndMapTo = gen_deserialize(_mclBnG1_hashAndMapTo)

	///////////////////////////////////////////////////////////////
	mclBnG2_malloc = function() {
		return mod._malloc(MCLBN_FP_UNIT_SIZE * 8 * 2 * 3)
	}
	mclBnG2_free = function(x) {
		mod._free(x)
	}
	mclBnG2_setStr = gen_setStr(_mclBnG2_setStr)
	mclBnG2_getStr = gen_getStr(_mclBnG2_getStr)
	mclBnG2_deserialize = gen_deserialize(_mclBnG2_deserialize)
	mclBnG2_serialize = gen_serialize(_mclBnG2_serialize)
	mclBnG2_hashAndMapTo = gen_deserialize(_mclBnG2_hashAndMapTo)

	///////////////////////////////////////////////////////////////
	mclBnGT_malloc = function() {
		return mod._malloc(MCLBN_FP_UNIT_SIZE * 8 * 12)
	}
	mclBnGT_free = function(x) {
		mod._free(x)
	}
	mclBnGT_deserialize = gen_deserialize(_mclBnGT_deserialize)
	mclBnGT_serialize = gen_serialize(_mclBnGT_serialize)
	mclBnGT_setStr = gen_setStr(_mclBnGT_setStr)
	mclBnGT_getStr = gen_getStr(_mclBnGT_getStr)
}

function rand(val) {
	var x = mclBnFr_malloc()
	mclBnFr_setByCSPRNG(x)
	setValue(val, mclBnFr_getStr(x))
	mclBnFr_free(x)
}

function TestFr() {
	var x = mclBnFr_malloc()
	var y = mclBnFr_malloc()
	var z = mclBnFr_malloc()


	mclBnFr_setStr(x, getValue('x'))
//	mclBnFr_setInt(x, getValue('x') | 0)
	mclBnFr_setStr(y, getValue('y'))
	mclBnFr_add(z, x, y)
	setText('ret_add', mclBnFr_getStr(z))
	mclBnFr_sub(z, x, y)
	setText('ret_sub', mclBnFr_getStr(z))
	mclBnFr_mul(z, x, y)
	setText('ret_mul', mclBnFr_getStr(z))
	if (!mclBnFr_isZero(y)) {
		mclBnFr_div(z, x, y)
		setText('ret_div', mclBnFr_getStr(z))
	} else {
		setText('ret_div', 'err : y is zero')
	}
	mclBnFr_setHashOf(x, getValue('hash_x'))
	setText('ret_hash_x', mclBnFr_getStr(x))


	mclBnFr_free(x)
	mclBnFr_free(y)
	mclBnFr_free(z)
}

function TestG1() {
	var P1 = mclBnG1_malloc()
	var P2 = mclBnG1_malloc()
	var P3 = mclBnG1_malloc()
	var x = mclBnFr_malloc()

	mclBnG1_hashAndMapTo(P1, getValue('hash_P1'))
	setText('P1', mclBnG1_getStr(P1))

	mclBnG1_hashAndMapTo(P2, getValue('hash_P2'))
	setText('P2', mclBnG1_getStr(P2))

	mclBnG1_add(P3, P1, P2)
	setText('P1addP2', mclBnG1_getStr(P3))

	mclBnG1_sub(P3, P1, P2)
	setText('P1subP2', mclBnG1_getStr(P3))

	mclBnFr_setStr(x, getValue('x'))
	mclBnG1_mul(P3, P1, x)
	setText('P1mulx', mclBnG1_getStr(P3))

	mclBnFr_free(x)
	mclBnG1_free(P1)
	mclBnG1_free(P2)
	mclBnG1_free(P3)
}

function TestG2() {
	var Q1 = mclBnG2_malloc()
	var Q2 = mclBnG2_malloc()
	var Q3 = mclBnG2_malloc()
	var x = mclBnFr_malloc()

	mclBnG2_hashAndMapTo(Q1, getValue('hash_Q1'))
	setText('Q1', mclBnG2_getStr(Q1))

	mclBnG2_hashAndMapTo(Q2, getValue('hash_Q2'))
	setText('Q2', mclBnG2_getStr(Q2))

	mclBnG2_add(Q3, Q1, Q2)
	setText('Q1addQ2', mclBnG2_getStr(Q3))

	mclBnG2_sub(Q3, Q1, Q2)
	setText('Q1subQ2', mclBnG2_getStr(Q3))

	mclBnFr_setStr(x, getValue('x'))
	mclBnG2_mul(Q3, Q1, x)
	setText('Q1mulx', mclBnG2_getStr(Q3))

	mclBnFr_free(x)
	mclBnG2_free(Q1)
	mclBnG2_free(Q2)
	mclBnG2_free(Q3)
}

function bench(label, count, func) {
	var start = Date.now()
	for (var i = 0; i < count; i++) {
		func()
	}
	var end = Date.now()
	var t = (end - start) / count
	setText(label, t)
}

function TestPairing() {
	var a = mclBnFr_malloc()
	var b = mclBnFr_malloc()
	var ab = mclBnFr_malloc()
	var P = mclBnG1_malloc()
	var aP = mclBnG1_malloc()
	var Q = mclBnG2_malloc()
	var bQ = mclBnG2_malloc()
	var e1 = mclBnGT_malloc()
	var e2 = mclBnGT_malloc()

	mclBnFr_setStr(a, getValue('a'))
	mclBnFr_setStr(b, getValue('b'))
	mclBnFr_mul(ab, a, b)
	setText('ab', mclBnFr_getStr(ab))

	mclBnG1_hashAndMapTo(P, getValue('hash_P'))
	setText('P', mclBnG1_getStr(P))
	mclBnG2_hashAndMapTo(Q, getValue('hash_Q'))
	setText('Q', mclBnG2_getStr(Q))
	mclBnG1_mul(aP, P, a)
	setText('aP', mclBnG1_getStr(aP))
	mclBnG2_mul(bQ, Q, b)
	setText('bQ', mclBnG2_getStr(bQ))

	mclBn_pairing(e1, P, Q);
	setText('ePQ', mclBnGT_getStr(e1))
	mclBn_pairing(e2, aP, bQ);
	setText('eaPbQ', mclBnGT_getStr(e2))
	mclBnGT_pow(e1, e1, ab)
	setText('ePQab', mclBnGT_getStr(e1))
	setText('verify_pairing', !!mclBnGT_isEqual(e1, e2))

	bench('time_pairing', 50, () => mclBn_pairing(e1, P, Q))
	mclBnFr_setByCSPRNG(a)
	bench('time_g1mul', 50, () => mclBnG1_mulCT(aP, P, a))
	bench('time_g2mul', 50, () => mclBnG2_mulCT(bQ, Q, a))

	mclBnGT_free(e2)
	mclBnGT_free(e1)
	mclBnG2_free(bQ)
	mclBnG2_free(Q)
	mclBnG1_free(aP)
	mclBnG1_free(P)
	mclBnFr_free(ab)
	mclBnFr_free(b)
	mclBnFr_free(a)
}
