function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

(function() {
	const range = 2048
	const tryNum = 100
	she.init(range, tryNum, function() { setText('status', 'ok')})
}())

function putSecretKey(x, msg = "") {
	console.log(msg + ' sk=' + Uint8ArrayToHexString(sheSecretKeySerialize(x)))
}
function putPublicKey(x, msg = "") {
	console.log(msg + ' pk=' + Uint8ArrayToHexString(shePublicKeySerialize(x)))
}
function putCipherTextG1(x, msg = "") {
	console.log(msg + ' ctG1=' + Uint8ArrayToHexString(sheCipherTextG1Serialize(x)))
}
function putCipherTextG2(x, msg = "") {
	console.log(msg + ' ctG2=' + Uint8ArrayToHexString(sheCipherTextG2Serialize(x)))
}
function putCipherTextGT(x, msg = "") {
	console.log(msg + ' ctGT=' + Uint8ArrayToHexString(sheCipherTextGTSerialize(x)))
}

function bench(label, count, func) {
	let start = Date.now()
	for (let i = 0; i < count; i++) {
		func()
	}
	let end = Date.now()
	let t = (end - start) / count
	setText(label, t)
}

function benchPairing() {
//	bench('time_pairing', 50, () => mclBn_pairing(e, P, Q))
}

function onClickBenchmark() {
}

function onClickTestSHE() {
	try {
		let sec = sheSecretKey_malloc()
		let pub = shePublicKey_malloc()
		let c11 = sheCipherTextG1_malloc()
		let c12 = sheCipherTextG1_malloc()
		let c21 = sheCipherTextG2_malloc()
		let c22 = sheCipherTextG2_malloc()
		let ct = sheCipherTextGT_malloc()

		sheSecretKeySetByCSPRNG(sec)
		setText('secretKey', Uint8ArrayToHexString(sheSecretKeySerialize(sec)))
		sheGetPublicKey(pub, sec)
		setText('publicKey', Uint8ArrayToHexString(shePublicKeySerialize(pub)))
		putPublicKey(pub)

		let m1 = getValue('msg1')
		let m2 = getValue('msg2')
		let m3 = getValue('msg3')
		let m4 = getValue('msg4')
		sheEnc32G1(c11, pub, m1)
		console.log('dec c11=' + sheDecG1(sec, c11))
		sheEnc32G1(c12, pub, m2)
		console.log('dec c12=' + sheDecG1(sec, c12))
		sheEnc32G2(c21, pub, m3)
		console.log('dec c21=' + sheDecG2(sec, c21))
		sheEnc32G2(c22, pub, m4)
		console.log('dec c22=' + sheDecG2(sec, c22))
		setText('encG11', Uint8ArrayToHexString(sheCipherTextG1Serialize(c11)))
		setText('encG12', Uint8ArrayToHexString(sheCipherTextG1Serialize(c12)))
		setText('encG21', Uint8ArrayToHexString(sheCipherTextG2Serialize(c21)))
		setText('encG22', Uint8ArrayToHexString(sheCipherTextG2Serialize(c22)))
		sheAddG1(c11, c11, c12)
		sheAddG2(c21, c21, c22)
		sheMul(ct, c11, c21)
		setText('encGT', Uint8ArrayToHexString(sheCipherTextGTSerialize(ct)))
		let d = sheDecGT(sec, ct)
		setText('decMsg', d)

		she_free(ct)
		she_free(c22)
		she_free(c21)
		she_free(c12)
		she_free(c11)
		she_free(pub)
		she_free(sec)
	} catch (e) {
		console.log('exception ' + e)
	}
}

function Uint8ArrayToHexString(a) {
	let s = ''
	for (let i = 0; i < a.length; i++) {
		s += ('0' + a[i].toString(16)).slice(-2)
	}
	return s
}

function HexStringToUint8Array(s) {
	let a = new Uint8Array(s.length / 2)
	for (let i = 0; i < s.length / 2; i++) {
		a[i] = parseInt(s.slice(i * 2, i * 2 + 2), 16)
	}
	return a
}

function reRandTest(sec, pub, c) {
	console.log('before ' + sec.dec(c))
	c.dump()
	pub.reRand(c)
	console.log('after ' + sec.dec(c))
	c.dump()
}
function onClickTestSHEclass() {
	try {
		let sec = new she.SecretKey()
		sec.setByCSPRNG()
		sec.dump()
		setText('sec2', sec.toHexStr())
		let pub = sec.getPublicKey()
		setText('pub2', pub.toHexStr())
		let m1 = 15
		let m2 = 17
		setText('m2', m1)
		let c11 = pub.encG1(m1)
		console.log('dec c11=' + sec.dec(c11))
		let c21 = pub.encG2(m1)
		let ct1 = pub.encGT(m1)
		setText('c2', c11.toHexStr())
		let d = sec.dec(c11)
		setText('d2', d)
		console.log('dec c21=' + sec.dec(c21))
		console.log('dec ct1=' + sec.dec(ct1))
		let c12 = pub.encG1(m2)
		let c22 = pub.encG2(m2)
		let ct2 = pub.encGT(m2)
		c11 = she.add(c11, c12)
		c21 = she.add(c21, c22)
		ct1 = she.add(ct1, ct2)
		console.log('expect ' + (m1 + m2))
		console.log('dec c11=' + sec.dec(c11))
		console.log('dec c21=' + sec.dec(c21))
		console.log('dec ct1=' + sec.dec(ct1))

		c12 = she.sub(c12, c11)
		c22 = she.sub(c22, c21)
		ct2 = she.sub(ct2, ct1)
		console.log('expect ' + (-m1))
		console.log('dec c11=' + sec.dec(c12))
		console.log('dec c21=' + sec.dec(c22))
		console.log('dec ct1=' + sec.dec(ct2))
		c12 = she.mulInt(c12, -3)
		c22 = she.mulInt(c22, -3)
		ct2 = she.mulInt(ct2, -3)
		console.log('expect ' + m1 * 3)
		console.log('dec c11=' + sec.dec(c12))
		console.log('dec c21=' + sec.dec(c22))
		console.log('dec ct1=' + sec.dec(ct2))
		c12 = pub.encG1(4)
		c22 = pub.encG2(5)
		ct2 = she.mul(c12, c22)
		console.log('dec ct2=' + sec.dec(ct2))

		reRandTest(sec, pub, c12)
		reRandTest(sec, pub, c22)
		reRandTest(sec, pub, ct2)
		console.log('ok')
	} catch (e) {
		console.log('err ' + e)
	}
}
