function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

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

function bin2hex(s) {
	var o = ''
	for (var i = 0; i < s.length; i++) {
		n = s.charCodeAt(i).toString(16)
		o += (n.length < 2 ? '0' + n : n) + ' '
	}
	return o
}

function strip(s) {
	s = s.trim()
	var begin = 0
	var end = s.length
	if (end == 0) {
		return s
	}
	if (s[0] == '"') {
		begin++
	}
	if (begin < end && s[end - 1] == '"') {
		end--
	}
	return s.substr(begin, end - begin)
}


(function() {
	const range = 2048
	const tryNum = 100
	she.init(range, tryNum, function() {
		setText('status', 'ok')
		sec = new she.SecretKey()
		sec.setByCSPRNG()
		setText('sec', sec.toHexStr())
		pub = sec.getPublicKey()
		setText('pub', pub.toHexStr())
	})
}())

function append() {
	let v = getValue('append')
	let vs = v.split(',')
	let x = parseInt(vs[0])
	let y = parseInt(vs[1])
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

function send() {
	let ct1 = []
	$('.encG1x').each(function() {
		ct1.push($(this).text())
	})
	let ct2 = []
	$('.encG2y').each(function() {
		ct2.push($(this).text())
	})
	var obj = $('#server_table')
	obj.html('')
	{
		var header = [
			'EncG1(x)', 'EncG2(y)', 'EncGT(x * y)'
		]
		var t = $('<tr>').attr('id', 'header')
		for (var i = 0; i < header.length; i++) {
			t.append(
				$('<th>').append(header[i])
			)
		}
		obj.append(t)
	}
	for (var i = 0; i < ct1.length; i++) {
		var t = $('<tr>')
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
	let c1 = new she.CipherTextG1()
	let c2 = new she.CipherTextG2()
	$('.encG1xS').each(function() {
		let o = $(this)
		c1.fromHexStr(o.text())
		c2.fromHexStr(o.next().text())
		let ct = she.mul(c1, c2)
		o.next().next().text(ct.toHexStr())
	})
}

function sum() {
	let ct = new she.CipherTextGT()
	let csum = pub.encGT(0)
	$('.encGTxyS').each(function() {
		ct.fromHexStr($(this).text())
		csum = she.add(csum, ct)
	})
	setText('encSumS', csum.toHexStr())
}

function recv() {
	setText('encSumC', getText('encSumS'))
}

function dec() {
	let s = getText('encSumC')
	let ct = new she.CipherTextGT()
	ct.fromHexStr(s)
	let v = sec.dec(ct)
	setText('ret', v)
}
