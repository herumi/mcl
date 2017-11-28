function getValue(name) { return document.getElementsByName(name)[0].value }
function setValue(name, val) { document.getElementsByName(name)[0].value = val }
function getText(name) { return document.getElementsByName(name)[0].innerText }
function setText(name, val) { document.getElementsByName(name)[0].innerText = val }

mcl.init()
  .then(() => {
    setText('status', 'ok')
  })

function IDenc(id, P, mpk, m) {
  const r = new mcl.Fr()
  r.setByCSPRNG()
  const Q = mcl.hashAndMapToG2(id)
  const e = mcl.pairing(mcl.mul(mpk, r), Q)
  return [mcl.mul(P, r), mcl.add(m, mcl.hashToFr(e.serialize()))]
}

// Dec([U, v]) = v - h(e(U, sk))
function IDdec(c, sk) {
  const [U, v] = c
  const e = mcl.pairing(U, sk)
  return mcl.sub(v, mcl.hashToFr(e.serialize()))
}

function onClickIBE() {
  const P = mcl.hashAndMapToG1('1')
  // keyGen
  const msk = new mcl.Fr()
  msk.setByCSPRNG()
  setText('msk', msk.toHexStr())
  const mpk = mcl.mul(P, msk)
  setText('mpk', mpk.toHexStr())

  const id = getText('id')
  const sk = mcl.mul(mcl.hashAndMapToG2(id), msk)
  setText('sk', sk.toHexStr())

  const m = new mcl.Fr()
  const msg = getValue('msg')
  console.log('msg', msg)
  m.setStr(msg)

  // encrypt
  const c = IDenc(id, P, mpk, m)
  setText('enc', c[0].toHexStr() + ' ' + c[1].toHexStr())
  // decrypt
  const d = IDdec(c, sk)
  setText('dec', d.getStr())
}
