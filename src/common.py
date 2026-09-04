# Common LLVM-IR generators shared by gen.py and gen_bint.py.
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license http://opensource.org/licenses/BSD-3-Clause
from s_xbyak_llvm import *

g_mul32x32 = None


# split x into (high, low) with low being sizeL bits
def split(x, sizeL):
  hi = lshr(x, sizeL)
  hi = trunc(hi, hi.bit - sizeL)
  lo = trunc(x, sizeL)
  return hi, lo


def gen_mul32x32():
  global g_mul32x32
  u = 32
  resetGlobalIdx()
  z = Int(u * 2)
  x = Int(u)
  y = Int(u)
  name = 'mul32x32L'
  with Function(name, z, x, y, private=True) as f:
    x = zext(x, u * 2)
    y = zext(y, u * 2)
    z = mul(x, y)
    ret(z)
  g_mul32x32 = f


def gen_mul64x64(x, y):
  a = trunc(lshr(x, 32), 32)
  b = trunc(x, 32)
  c = trunc(lshr(y, 32), 32)
  d = trunc(y, 32)
  ad = call(g_mul32x32, a, d)
  bd = call(g_mul32x32, b, d)
  bd = zext(bd, 96)
  ad = shl(zext(ad, 96), 32)
  ad = add(ad, bd)
  ac = call(g_mul32x32, a, c)
  bc = call(g_mul32x32, b, c)
  bc = zext(bc, 96)
  ac = shl(zext(ac, 96), 32)
  ac = add(ac, bc)
  ad = zext(ad, 128)
  ac = shl(zext(ac, 128), 32)
  z = add(ac, ad)
  return z


def gen_multi3(unit):
  resetGlobalIdx()
  z = Int(unit * 2)
  x = Int(unit)
  y = Int(unit)
  name = '__multi3'
  with Function(name, z, x, y, private=False):
    z = gen_mul64x64(x, y)
    ret(z)


def gen_mulUU(unit, wasm=False):
  if wasm:
    gen_mul32x32()
    gen_multi3(unit)
  resetGlobalIdx()
  z = Int(unit * 2)
  x = Int(unit)
  y = Int(unit)
  name = f'mul{unit}x{unit}L'
  with Function(name, z, x, y, private=True) as f:
    if wasm:
      z = gen_mul64x64(x, y)
    else:
      x = zext(x, unit * 2)
      y = zext(y, unit * 2)
      z = mul(x, y)
    ret(z)
  return f


def gen_extractHigh(unit):
  resetGlobalIdx()
  z = Int(unit)
  x = Int(unit * 2)
  name = f'extractHigh{unit}'
  with Function(name, z, x, private=True) as f:
    x = lshr(x, unit)
    z = trunc(x, unit)
    ret(z)
  return f


# emit z = px[0..N] * y and return z (i{N*unit+unit})
def emit_mulUnit(unit, N, mulPos, extractHigh, px, y):
  bu = N * unit + unit
  L = []
  H = []
  for i in range(N):
    xy = call(mulPos, px, y, Imm(i, unit))
    L.append(trunc(xy, unit))
    H.append(call(extractHigh, xy))
  LL = pack(L)
  HH = pack(H)
  LL = zext(LL, bu)
  HH = zext(HH, bu)
  HH = shl(HH, unit)
  return add(LL, HH)


# z = px[0..N] * y, returns i{N*unit+unit}
def gen_mulPv(name, unit, N, mulPos, extractHigh, private=False, alwaysinline=False):
  bu = N * unit + unit
  resetGlobalIdx()
  z = Int(bu)
  px = IntPtr(unit)
  y = Int(unit)
  with Function(name, z, px, y, private=private, alwaysinline=alwaysinline) as f:
    z = emit_mulUnit(unit, N, mulPos, extractHigh, px, y)
    ret(z)
  return f


# emit pz[2N] = px[N] * py[N] (no reduction) into the current function.
# mulUnit(px, y) returns i{N*unit+unit} = px[0..N] * y.
# Schoolbook: the rows x * y[i] are accumulated in the N+1 unit accumulator t,
# whose bottom unit is final after each row and is stored immediately.
def emit_mulPre(unit, N, pz, px, py, mulUnit):
  if N == 1:
    x = load(px)
    y = load(py)
    x = zext(x, unit * 2)
    y = zext(y, unit * 2)
    z = mul(x, y)
    storeN(z, pz)
    return
  y = load(py)
  xy = call(mulUnit, px, y)
  store(trunc(xy, unit), pz)
  t = lshr(xy, unit)
  for i in range(1, N):
    y = load(getelementptr(py, i))
    xy = call(mulUnit, px, y)
    t = add(t, xy)
    if i < N - 1:
      storeN(trunc(t, unit), pz, i)
      t = lshr(t, unit)
  storeN(t, pz, N - 1)


# [r:z[]] = x[] + y[] (isAdd) or x[] - y[]
def gen_addsub(name, unit, N, isAdd):
  bit = N * unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Int(unit), pz, px, py, private=False):
    x = zext(loadN(px, N), bit + unit)
    y = zext(loadN(py, N), bit + unit)
    if isAdd:
      z = add(x, y)
      storeN(trunc(z, bit), pz)
      r = trunc(lshr(z, bit), unit)
    else:
      z = sub(x, y)
      storeN(trunc(z, bit), pz)
      z = trunc(lshr(z, bit), unit)
      r = and_(z, Imm(1, unit))
    ret(r)


def gen_mulPos(unit, mulUU):
  resetGlobalIdx()
  xy = Int(unit * 2)
  px = IntPtr(unit)
  y = Int(unit)
  i = Int(unit)
  name = f'mulPos{unit}x{unit}'
  with Function(name, xy, px, y, i, private=True) as f:
    x = load(getelementptr(px, i))
    xy = call(mulUU, x, y)
    ret(xy)
  return f


# z = (x + y) mod p; x, y, p are i{bit} values and z is i{bit}.
# isFullBit: p may use the top bit of the top unit, so x + y is computed in
# bit + unit bits and the borrow of the following - p decides the result.
def emit_fp_add(unit, x, y, p, isFullBit):
  bit = x.bit
  if isFullBit:
    x = zext(x, bit + unit)
    y = zext(y, bit + unit)
    x = add(x, y)
    p = zext(p, bit + unit)
    y = sub(x, p)
    c = trunc(lshr(y, bit), 1)
    x = select(c, x, y)
    x = trunc(x, bit)
  else:
    x = add(x, y)
    y = sub(x, p)
    c = trunc(lshr(y, bit - 1), 1)
    x = select(c, x, y)
  return x


# returns (v, c) with v = (x - y) mod 2^bit (i{bit}) and c = borrow (i1).
# The caller adds p back when c is set (select / and-mask / table lookup).
def emit_fp_sub_raw(unit, x, y, isFullBit):
  bit = x.bit
  if isFullBit:
    x = zext(x, bit + unit)
    y = zext(y, bit + unit)
    v = sub(x, y)
    c = trunc(lshr(v, bit), 1)
    v = trunc(v, bit)
  else:
    v = sub(x, y)
    c = trunc(lshr(v, bit - 1), 1)
  return v, c


# emit pz[N] = px[N] * py[N] R^-1 mod p (fused Montgomery multiplication)
# into the current function. rp = -p^-1 mod 2^unit is an i{unit} value or a
# Python int. mulPv(px, y) returns i{N*unit+unit} = px[0..N] * y.
def emit_mont(unit, N, pz, px, py, pp, rp, mulPv, isFullBit):
  bit = N * unit
  bu = bit + unit
  bu2 = bit + unit * 2
  if isFullBit:
    s = None
    for i in range(N):
      y = load(getelementptr(py, i))
      xy = call(mulPv, px, y)
      if i == 0:
        a = zext(xy, bu2)
        at = trunc(xy, unit)
      else:
        xy = zext(xy, bu2)
        a = add(s, xy)
        at = trunc(a, unit)
      q = mul(at, rp)
      pq = call(mulPv, pp, q)
      pq = zext(pq, bu2)
      t = add(a, pq)
      s = lshr(t, unit)
    s = trunc(s, bu)
    p = zext(loadN(pp, N), bu)
    vc = sub(s, p)
    c = trunc(lshr(vc, bit), 1)
    z = select(c, s, vc)
    z = trunc(z, bit)
    storeN(z, pz)
  else:
    y = load(py)
    xy = call(mulPv, px, y)
    c0 = trunc(xy, unit)
    q = mul(c0, rp)
    pq = call(mulPv, pp, q)
    t = add(xy, pq)
    t = lshr(t, unit)
    for i in range(1, N):
      y = load(getelementptr(py, i))
      xy = call(mulPv, px, y)
      t = add(t, xy)
      c0 = trunc(t, unit)
      q = mul(c0, rp)
      pq = call(mulPv, pp, q)
      t = add(t, pq)
      t = lshr(t, unit)
    t = trunc(t, bit)
    vc = sub(t, loadN(pp, N))
    c = trunc(lshr(vc, bit - 1), 1)
    z = select(c, t, vc)
    storeN(z, pz)


# Montgomery reduction core: reduce a 2N-unit value xy to z = xy R^-1 mod p
# and return it (i{bit}). The low N units come packed in lo; the high units
# are fetched one per iteration via getHi(i) -> i{unit} = unit N+i, so the
# caller chooses the source (memory, or an SSA value). p is the loaded
# modulus (i{bit}), rp = -p^-1 mod 2^unit (i{unit} value or Python int).
def emit_montRed(unit, N, lo, getHi, pp, p, rp, mulPv, isFullBit):
  bit = N * unit
  bu = bit + unit
  bu2 = bit + unit * 2
  t = lo
  H = None
  for i in range(N):
    if N == 1:
      q = mul(t, rp)
    else:
      q = mul(trunc(t, unit), rp)
    pq = call(mulPv, pp, q)
    if i > 0:
      H = zext(H, bu)
      H = shl(H, bit)
      pq = add(pq, H)
    nxt = getHi(i)
    t = pack([t, nxt])
    t = zext(t, bu2)
    pq = zext(pq, bu2)
    t = add(t, pq)
    t = lshr(t, unit)
    t = trunc(t, bu)
    H, t = split(t, bit)
  if isFullBit:
    p = zext(p, bu)
    t = pack([t, H])
    vc = sub(t, p)
    c = trunc(lshr(vc, bit), 1)
    z = select(c, t, vc)
    z = trunc(z, bit)
  else:
    vc = sub(t, p)
    c = trunc(lshr(vc, bit - 1), 1)
    z = select(c, t, vc)
  return z
