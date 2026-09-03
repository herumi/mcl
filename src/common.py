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
