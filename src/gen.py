# Generate src/base{32,64}.ll (and base64m.ll for wasm) in LLVM-IR.
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license http://opensource.org/licenses/BSD-3-Clause
import argparse
from s_xbyak_llvm import *
import common

unit = 0
unit2 = 0
bit = 0
N = 0

g_wasm = False

# function handles referenced across generators
g_mulUU = None
g_extractHigh = None
g_mulPos = None
g_makeNIST_P192 = None
g_mod_NIST_P192 = None
g_mulPv = {}  # bit -> Function


# forward reference to a function defined later (call by name only)
class FuncRef:
  def __init__(self, name, ret):
    self.name = name
    self.ret = ret

  def getName(self):
    return f'{self.ret.getType()} @{self.name}'


# split x into (high, low) with low being sizeL bits
def split(x, sizeL):
  hi = lshr(x, sizeL)
  hi = trunc(hi, hi.bit - sizeL)
  lo = trunc(x, sizeL)
  return hi, lo


# return (x>>shift) % (2**size)
def extract(x, shift, size=0):
  if size == 0:
    size = unit
  t = lshr(x, shift)
  t = trunc(t, size)
  return t


def gen_makeNIST_P192():
  global g_makeNIST_P192
  resetGlobalIdx()
  p = Int(192)
  p0 = Int(64)
  p1 = Int(64)
  p2 = Int(64)
  _0 = Imm(0, 64)
  _1 = Imm(1, 64)
  _2 = Imm(2, 64)
  with Function('makeNIST_P192L', p, private=False) as f:
    p0 = sub(_0, _1)
    p1 = sub(_0, _2)
    p2 = sub(_0, _1)
    p0 = zext(p0, 192)
    p1 = zext(p1, 192)
    p2 = zext(p2, 192)
    p1 = shl(p1, 64)
    p2 = shl(p2, 128)
    p = add(p0, p1)
    p = add(p, p2)
    ret(p)
  g_makeNIST_P192 = f


def gen_mcl_fpDbl_mod_NIST_P192():
  global g_mod_NIST_P192
  resetGlobalIdx()
  out = IntPtr(unit)
  px = IntPtr(unit)
  dummy = IntPtr(unit)
  with Function('mcl_fpDbl_mod_NIST_P192L', Void, out, px, dummy, private=False) as f:
    n = 192 // unit
    L = loadN(px, n)
    L = zext(L, 256)
    H192 = loadN(px, n, n)
    H = zext(H192, 256)
    H10 = shl(H192, 64)
    H10 = zext(H10, 256)
    H2 = extract(H192, 128, 64)
    H2 = zext(H2, 256)
    H102 = or_(H10, H2)
    H2 = shl(H2, 64)
    t = add(L, H)
    t = add(t, H102)
    t = add(t, H2)
    e = lshr(t, 192)
    e = trunc(e, 64)
    e = zext(e, 256)
    e2 = shl(e, 64)
    e = or_(e, e2)
    t = trunc(t, 192)
    t = zext(t, 256)
    z = add(t, e)
    p = call(g_makeNIST_P192)
    p = zext(p, 256)
    zp = sub(z, p)
    c = trunc(lshr(zp, 192), 1)
    z = trunc(select(c, z, zp), 192)
    storeN(z, out)
    ret(Void)
  g_mod_NIST_P192 = f


def gen_mcl_fpDbl_mod_NIST_P521():
  resetGlobalIdx()
  length = 521
  n = length // unit
  rnd = unit * (n + 1)
  rem = length - n * unit
  mask = -(1 << rem)
  py = IntPtr(unit)
  px = IntPtr(unit)
  dummy = IntPtr(unit)
  with Function('mcl_fpDbl_mod_NIST_P521L', Void, py, px, dummy, private=False):
    x = loadN(px, n * 2 + 1)
    Lo = trunc(x, length)
    Lo = zext(Lo, rnd)
    H = lshr(x, length)
    H = trunc(H, rnd)
    t = add(Lo, H)
    t0 = lshr(t, length)
    t0 = and_(t0, Imm(1, rnd))
    t = add(t, t0)
    t = trunc(t, length)
    z0 = zext(t, rnd)
    t = extract(z0, n * unit)
    m = or_(t, Imm(mask, unit))
    for i in range(n):
      s = extract(z0, unit * i)
      m = and_(m, s)
    c = icmp(eq, m, Imm(-1, unit))
    zeroL = Label()
    nonzeroL = Label()
    br(c, zeroL, nonzeroL)
    L(zeroL)
    for i in range(n + 1):
      storeN(Imm(0, unit), py, i)
    ret(Void)
    L(nonzeroL)
    storeN(z0, py)
    ret(Void)


def gen_mcl_fp_sqr_NIST_P192():
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  dummy = IntPtr(unit)
  with Function('mcl_fp_sqr_NIST_P192L', Void, py, px, dummy, private=False):
    buf = alloca_(unit, 192 * 2 // unit)
    sqrPre = FuncRef(f'mcl_fpDbl_sqrPre{192 // unit}L', Void)
    call(sqrPre, buf, px)
    call(g_mod_NIST_P192, py, buf, buf)
    ret(Void)


def gen_mcl_fp_mulNIST_P192():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  dummy = IntPtr(unit)
  with Function('mcl_fp_mulNIST_P192L', Void, pz, px, py, dummy, private=False):
    buf = alloca_(unit, 192 * 2 // unit)
    mulPre = FuncRef(f'mcl_fpDbl_mulPre{192 // unit}L', Void)
    call(mulPre, buf, px, py)
    call(g_mod_NIST_P192, pz, buf, buf)
    ret(Void)


def gen_once():
  global g_mulUU, g_extractHigh, g_mulPos
  g_mulUU = common.gen_mulUU(unit, g_wasm)
  g_extractHigh = common.gen_extractHigh(unit)
  g_mulPos = common.gen_mulPos(unit, g_mulUU)
  gen_makeNIST_P192()
  gen_mcl_fpDbl_mod_NIST_P192()
  gen_mcl_fp_sqr_NIST_P192()
  gen_mcl_fp_mulNIST_P192()
  gen_mcl_fpDbl_mod_NIST_P521()


def gen_mcl_fp_addsubPre(isAdd):
  if isAdd:
    name = f'mcl_fp_addPre{N}L'
  else:
    name = f'mcl_fp_subPre{N}L'
  common.gen_addsub(name, unit, N, isAdd)


def gen_mcl_fp_shr1():
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  name = f'mcl_fp_shr1_{N}L'
  with Function(name, Void, py, px, private=False):
    x = loadN(px, N)
    x = lshr(x, 1)
    storeN(x, py)
    ret(Void)


def gen_mcl_fp_add(isFullBit=True):
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  pp = IntPtr(unit)
  name = 'mcl_fp_add'
  if not isFullBit:
    name += 'NF'
  name += f'{N}L'
  with Function(name, Void, pz, px, py, pp, private=False):
    x = loadN(px, N)
    y = loadN(py, N)
    if isFullBit:
      x = zext(x, bit + unit)
      y = zext(y, bit + unit)
      x = add(x, y)
      p = loadN(pp, N)
      p = zext(p, bit + unit)
      y = sub(x, p)
      c = trunc(lshr(y, bit), 1)
      x = select(c, x, y)
      x = trunc(x, bit)
      storeN(x, pz)
    else:
      x = add(x, y)
      p = loadN(pp, N)
      y = sub(x, p)
      c = trunc(lshr(y, bit - 1), 1)
      x = select(c, x, y)
      storeN(x, pz)
    ret(Void)


def gen_mcl_fp_sub(isFullBit=True):
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  pp = IntPtr(unit)
  name = 'mcl_fp_sub'
  if not isFullBit:
    name += 'NF'
  name += f'{N}L'
  with Function(name, Void, pz, px, py, pp, private=False):
    x = loadN(px, N)
    y = loadN(py, N)
    if isFullBit:
      x = zext(x, bit + 1)
      y = zext(y, bit + 1)
    v = sub(x, y)
    if isFullBit:
      c = trunc(lshr(v, bit), 1)
      v = trunc(v, bit)
    else:
      c = trunc(lshr(v, bit - 1), 1)
    p = loadN(pp, N)
    c = select(c, p, Imm(0, bit))
    v = add(v, c)
    storeN(v, pz)
    ret(Void)


def gen_mcl_fpDbl_add():
  bu = bit + unit
  b2 = bit * 2
  b2u = b2 + unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  pp = IntPtr(unit)
  name = f'mcl_fpDbl_add{N}L'
  with Function(name, Void, pz, px, py, pp, private=False):
    x = loadN(px, N * 2)
    y = loadN(py, N * 2)
    x = zext(x, b2u)
    y = zext(y, b2u)
    t = add(x, y)
    L = trunc(t, bit)
    storeN(L, pz)
    H = lshr(t, bit)
    H = trunc(H, bu)
    p = loadN(pp, N)
    p = zext(p, bu)
    Hp = sub(H, p)
    t = lshr(Hp, bit)
    t = trunc(t, 1)
    t = select(t, H, Hp)
    t = trunc(t, bit)
    storeN(t, pz, N)
    ret(Void)


def gen_mcl_fpDbl_sub():
  b2 = bit * 2
  b2u = b2 + unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  pp = IntPtr(unit)
  name = f'mcl_fpDbl_sub{N}L'
  with Function(name, Void, pz, px, py, pp, private=False):
    x = loadN(px, N * 2)
    y = loadN(py, N * 2)
    x = zext(x, b2u)
    y = zext(y, b2u)
    vc = sub(x, y)
    L = trunc(vc, bit)
    storeN(L, pz)
    H = lshr(vc, bit)
    H = trunc(H, bit)
    c = lshr(vc, b2)
    c = trunc(c, 1)
    p = loadN(pp, N)
    c = select(c, p, Imm(0, bit))
    t = add(H, c)
    storeN(t, pz, N)
    ret(Void)


def gen_mulPv():
  name = f'mulPv{bit}x{unit}'
  g_mulPv[bit] = common.gen_mulPv(name, unit, N, g_mulPos, g_extractHigh)


def generic_fpDbl_mul(pz, px, py):
  if N == 1:
    x = load(px)
    y = load(py)
    x = zext(x, unit * 2)
    y = zext(y, unit * 2)
    z = mul(x, y)
    storeN(z, pz)
    ret(Void)
  else:
    # Karatsuba (N > 8 and even) is intentionally omitted: it is slower and is
    # never reached here (mulPre/sqrPre are generated only for bit==192).
    y = load(py)
    xy = call(g_mulPv[bit], px, y)
    store(trunc(xy, unit), pz)
    t = lshr(xy, unit)
    for i in range(1, N):
      y = loadN(py, 1, i)
      xy = call(g_mulPv[bit], px, y)
      t = add(t, xy)
      if i < N - 1:
        storeN(trunc(t, unit), pz, i)
        t = lshr(t, unit)
    storeN(t, pz, N - 1)
    ret(Void)


def gen_mcl_fpDbl_mulPre():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  name = f'mcl_fpDbl_mulPre{N}L'
  with Function(name, Void, pz, px, py, private=False):
    generic_fpDbl_mul(pz, px, py)


def gen_mcl_fpDbl_sqrPre():
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  name = f'mcl_fpDbl_sqrPre{N}L'
  with Function(name, Void, py, px, private=False):
    generic_fpDbl_mul(py, px, px)


def gen_mcl_fp_mont(isFullBit=True):
  bu = bit + unit
  bu2 = bit + unit * 2
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  pp = IntPtr(unit)
  name = 'mcl_fp_mont'
  if not isFullBit:
    name += 'NF'
  name += f'{N}L'
  # setAlias() in gen.cpp -> emit pointer args without 'noalias'
  with Function(name, Void, pz, px, py, pp, private=False, noalias=False):
    rp = load(getelementptr(pp, -1))
    if isFullBit:
      s = None
      for i in range(N):
        y = load(getelementptr(py, i))
        xy = call(g_mulPv[bit], px, y)
        if i == 0:
          a = zext(xy, bu2)
          at = trunc(xy, unit)
        else:
          xy = zext(xy, bu2)
          a = add(s, xy)
          at = trunc(a, unit)
        q = mul(at, rp)
        pq = call(g_mulPv[bit], pp, q)
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
      xy = call(g_mulPv[bit], px, y)
      c0 = trunc(xy, unit)
      q = mul(c0, rp)
      pq = call(g_mulPv[bit], pp, q)
      t = add(xy, pq)
      t = lshr(t, unit)
      for i in range(1, N):
        y = load(getelementptr(py, i))
        xy = call(g_mulPv[bit], px, y)
        t = add(t, xy)
        c0 = trunc(t, unit)
        q = mul(c0, rp)
        pq = call(g_mulPv[bit], pp, q)
        t = add(t, pq)
        t = lshr(t, unit)
      t = trunc(t, bit)
      vc = sub(t, loadN(pp, N))
      c = trunc(lshr(vc, bit - 1), 1)
      z = select(c, t, vc)
      storeN(z, pz)
    ret(Void)


def gen_mcl_fp_montRed(isFullBit=True):
  resetGlobalIdx()
  pz = IntPtr(unit)
  pxy = IntPtr(unit)
  pp = IntPtr(unit)
  name = 'mcl_fp_montRed'
  if not isFullBit:
    name += 'NF'
  name += f'{N}L'
  with Function(name, Void, pz, pxy, pp, private=False):
    rp = load(getelementptr(pp, -1))
    p = loadN(pp, N)
    bu = bit + unit
    bu2 = bit + unit * 2
    t = loadN(pxy, N)
    H = None
    for i in range(N):
      if N == 1:
        q = mul(t, rp)
      else:
        q = mul(trunc(t, unit), rp)
      pq = call(g_mulPv[bit], pp, q)
      if i > 0:
        H = zext(H, bu)
        H = shl(H, bit)
        pq = add(pq, H)
      nxt = load(getelementptr(pxy, N + i))
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
    storeN(z, pz)
    ret(Void)


def gen_all():
  gen_mcl_fp_addsubPre(True)
  gen_mcl_fp_addsubPre(False)
  gen_mcl_fp_shr1()


def gen_addsub():
  gen_mcl_fp_add(True)
  gen_mcl_fp_add(False)
  gen_mcl_fp_sub(True)
  gen_mcl_fp_sub(False)
  gen_mcl_fpDbl_add()
  gen_mcl_fpDbl_sub()


def gen_mul():
  gen_mulPv()
  if bit == 192:
    gen_mcl_fpDbl_mulPre()
    gen_mcl_fpDbl_sqrPre()
  gen_mcl_fp_mont(True)
  gen_mcl_fp_mont(False)
  gen_mcl_fp_montRed(True)
  gen_mcl_fp_montRed(False)


def setBit(b):
  global bit, N
  bit = b
  N = b // unit


def setUnit(u):
  global unit, unit2
  unit = u
  unit2 = u * 2


def gen(maxBitSize):
  gen_once()
  bitTbl = [192, 224, 256, 384, 512]
  for b in bitTbl:
    if unit == 64 and b == 224:
      continue
    setBit(b)
    gen_mul()
    gen_all()
    gen_addsub()
  if unit == 64 and maxBitSize == 768:
    b = maxBitSize + unit * 2
    while b <= maxBitSize * 2:
      setBit(b)
      gen_all()
      b += unit * 2


def main():
  global g_wasm
  parser = argparse.ArgumentParser(description='generate base{32,64}.ll')
  parser.add_argument('-u', type=int, default=64, help='unit bit size (32 or 64)')
  parser.add_argument('-wasm', action='store_true', default=False, help='generate for wasm')
  opt = parser.parse_args()

  setUnit(opt.u)
  g_wasm = opt.wasm

  # MCL_FP_BIT default (see include/mcl/config.hpp). Only affects the
  # (currently unused) 768-bit add/sub extension.
  gen(384)
  term()


if __name__ == '__main__':
  main()
