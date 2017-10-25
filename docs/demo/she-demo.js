function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

(function() {
	const range = 2048
	const tryNum = 100
	she.init(range, tryNum, function() { setText('status', 'ok')})
}())

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
		let sec = new she.SecretKey()
		sec.setByCSPRNG()
		setText('secretKey', sec.toHexStr())
		let pub = sec.getPublicKey()
		setText('publicKey', pub.toHexStr())

		let m1 = getValue('msg1')
		let m2 = getValue('msg2')
		let m3 = getValue('msg3')
		let m4 = getValue('msg4')
		let c11 = pub.encG1(m1)
		console.log('dec c11=' + sec.dec(c11))
		let c12 = pub.encG1(m2)
		console.log('dec c12=' + sec.dec(c12))
		let c21 = pub.encG2(m3)
		console.log('dec c21=' + sec.dec(c21))
		let c22 = pub.encG2(m4)
		console.log('dec c22=' + sec.dec(c22))
		setText('encG11', c11.toHexStr())
		setText('encG12', c12.toHexStr())
		setText('encG21', c21.toHexStr())
		setText('encG22', c22.toHexStr())
		c11 = she.add(c11, c12)
		c21 = she.add(c21, c22)
		let ct = she.mul(c11, c21)
		setText('encGT', ct.toHexStr())
		let d = sec.dec(ct)
		setText('decMsg', d)
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
		let expect = m1 * 3
		console.log('dec c11=' + (sec.dec(c12) == expect))
		console.log('dec c21=' + (sec.dec(c22) == expect))
		console.log('dec ct1=' + (sec.dec(ct2) == expect))
		c12 = pub.encG1(4)
		c22 = pub.encG2(5)
		ct2 = she.mul(c12, c22)
		console.log('dec ct2=' + sec.dec(ct2))
		ct2 = pub.convertToCipherTextGT(c12)
		console.log('convertToCipherTextGT(G1)=' + (sec.dec(ct2) == 4))
		ct2 = pub.convertToCipherTextGT(c22)
		console.log('convertToCipherTextGT(G2)=' + (sec.dec(ct2) == 5))

		reRandTest(sec, pub, c12)
		reRandTest(sec, pub, c22)
		reRandTest(sec, pub, ct2)
		console.log('ok')
	} catch (e) {
		console.log('err ' + e)
	}
}
