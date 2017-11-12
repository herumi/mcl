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

function appendXY(x, y) {
	console.log('x = ' + x + ', y = ' + y)
	let c1 = pub.encG1(x)
	let c2 = pub.encG2(y)
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
	let v = getValue('append')
	let vs = v.split(',')
	let x = parseInt(vs[0])
	let y = parseInt(vs[1])
	appendXY(x, y)
}

function appendRand() {
	const tbl = [
		[1,2], [-2,1], [4,3], [5,-2], [6,1]
	]
	tbl.forEach(p => appendXY(p[0], p[1]))
}


function send() {
	let ct1 = []
	$('.encG1x').each(function() {
		ct1.push($(this).text())
	})
	let ct2 = []
	$('.encG2y').each(function() {
		ct2.push($(this).text())
	})
	let obj = $('#server_table')
	obj.html('')
	{
		let header = [
			'Enc(x)', 'Enc(y)', 'Enc(x * y)'
		]
		let t = $('<tr>').attr('id', 'header')
		for (let i = 0; i < header.length; i++) {
			t.append(
				$('<th>').append(header[i])
			)
		}
		obj.append(t)
	}
	for (let i = 0; i < ct1.length; i++) {
		let t = $('<tr>')
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
		let o = $(this)
		let c1 = she.getCipherTextG1FromHexStr(o.text())
		let c2 = she.getCipherTextG2FromHexStr(o.next().text())
		let ct = she.mul(c1, c2)
		o.next().next().text(ct.toHexStr())
	})
}

function sum() {
	let csum = pub.encGT(0)
	$('.encGTxyS').each(function() {
		let s = $(this).text()
		let ct = she.getCipherTextGTFromHexStr(s)
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
	let s = getText('encSumC')
	let ct = she.getCipherTextGTFromHexStr(s)
	let v = sec.dec(ct)
	setText('ret', v)
}
