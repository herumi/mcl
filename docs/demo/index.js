function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

let sec = null
let pub = null

she.init(256)
  .then(() => {
    setText('status', 'OK')
    sec = new she.SecretKey()
    sec.setByCSPRNG()
    setText('sec', sec.toHexStr())
    pub = sec.getPublicKey()
    setText('pub', pub.toHexStr())
  })

function bench(label, count, func) {
	const start = Date.now()
	for (let i = 0; i < count; i++) {
		func()
	}
	const end = Date.now()
	const t = (end - start) / count
	setText(label, t)
}

function benchAll() {
	const C = 50
	bench('EncG1T', C, () => { pub.encG1(100) })
	bench('EncG2T', C, () => { pub.encG2(100) })
	const c11 = pub.encG1(1)
	const c12 = pub.encG1(2)
	bench('AddG1T', C, () => { she.add(c11, c12) })
	const c21 = pub.encG2(1)
	const c22 = pub.encG2(2)
	bench('AddG2T', C, () => { she.add(c21, c22) })
	const ct1 = pub.encGT(123)
	const ct2 = pub.encGT(2)
	bench('AddGTT', C, () => { she.add(ct1, ct2) })
	bench('MulT', 10, () => { she.mul(c11, c21) })
	bench('DecGTT', 10, () => { sec.dec(ct1) })
}

function appendXY(x, y) {
	console.log('x = ' + x + ', y = ' + y)
	const c1 = pub.encG1(x)
	const c2 = pub.encG2(y)
	$('#client_table').append(
		$('<tr>').append(
			$('<td>').text(x)
		).append(
			$('<td>').text(y)
		).append(
			$('<td class="encG1x">').text(c1.toHexStr())
		).append(
			$('<td class="encG2y">').text(c2.toHexStr())
		)
	)
}

function append() {
	const v = getValue('append')
	const vs = v.split(',')
	const x = parseInt(vs[0])
	const y = parseInt(vs[1])
	appendXY(x, y)
}

function appendRand() {
	const tbl = [
		[1,2], [-2,1], [4,3], [5,-2], [6,1]
	]
	tbl.forEach(p => appendXY(p[0], p[1]))
}


function send() {
	const ct1 = []
	$('.encG1x').each(function() {
		ct1.push($(this).text())
	})
	const ct2 = []
	$('.encG2y').each(function() {
		ct2.push($(this).text())
	})
	const obj = $('#server_table')
	obj.html('')
	{
		const header = [
			'Enc(x)', 'Enc(y)', 'Enc(x * y)'
		]
		const t = $('<tr>').attr('id', 'header')
		for (let i = 0; i < header.length; i++) {
			t.append(
				$('<th>').append(header[i])
			)
		}
		obj.append(t)
	}
	for (let i = 0; i < ct1.length; i++) {
		const t = $('<tr>')
		t.append(
			$('<td class="encG1xS">').append(ct1[i])
		).append(
			$('<td class="encG2yS">').append(ct2[i])
		).append(
			$('<td class="encGTxyS">').append('')
		)
		obj.append(t)
	}
}

function mul() {
	$('.encG1xS').each(function() {
		const o = $(this)
		const c1 = she.getCipherTextG1FromHexStr(o.text())
		const c2 = she.getCipherTextG2FromHexStr(o.next().text())
		const ct = she.mul(c1, c2)
		o.next().next().text(ct.toHexStr())
	})
}

function sum() {
	let csum = pub.encGT(0)
	$('.encGTxyS').each(function() {
		const s = $(this).text()
		const ct = she.getCipherTextGTFromHexStr(s)
		csum = she.add(csum, ct)
	})
	setText('encSumS', csum.toHexStr())
}

function mul_sum() {
	mul()
	sum()
}

function recv() {
	setText('encSumC', getText('encSumS'))
}

function dec() {
	const s = getText('encSumC')
	const ct = she.getCipherTextGTFromHexStr(s)
	const v = sec.dec(ct)
	setText('ret', v)
}
