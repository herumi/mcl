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
g_mclb_mul3 = None  # mclb_mul{N}
g_mclb_sqr3 = None  # mclb_sqr{N}


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
    call(g_mclb_sqr3, buf, px)
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
    call(g_mclb_mul3, buf, px, py)
    call(g_mod_NIST_P192, pz, buf, buf)
    ret(Void)


# declare mclb_mul{N}/mclb_sqr{N} (N = 192/unit) provided by bint{unit}.ll (or bint-x64 asm)
def declare_mclb_mul3():
  global g_mclb_mul3, g_mclb_sqr3
  N = 192 // unit
  p = IntPtr(unit)
  g_mclb_mul3 = Function(f'mclb_mul{N}', Void, p, p, p)
  declare(g_mclb_mul3)
  g_mclb_sqr3 = Function(f'mclb_sqr{N}', Void, p, p)
  declare(g_mclb_sqr3)


def gen_once():
  global g_mulUU, g_extractHigh, g_mulPos
  g_mulUU = common.gen_mulUU(unit, g_wasm)
  g_extractHigh = common.gen_extractHigh(unit)
  g_mulPos = common.gen_mulPos(unit, g_mulUU)
  declare_mclb_mul3()
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
    p = loadN(pp, N)
    z = common.emit_fp_add(unit, x, y, p, isFullBit)
    storeN(z, pz)
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
    v, c = common.emit_fp_sub_raw(unit, x, y, isFullBit)
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


def gen_mcl_fp_mont(isFullBit=True):
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
    common.emit_mont(unit, N, pz, px, py, pp, rp, g_mulPv[bit], isFullBit)
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
    lo = loadN(pxy, N)
    z = common.emit_montRed(unit, N, lo, lambda i: load(getelementptr(pxy, N + i)), pp, p, rp, g_mulPv[bit], isFullBit)
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
