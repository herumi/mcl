# Generate src/bint{32,64}.ll in LLVM-IR.
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license http://opensource.org/licenses/BSD-3-Clause
import argparse
from s_xbyak_llvm import *
import common

unit = 0
unit2 = 0
bit = 0
N = 0

# function handles referenced across generators
g_mulUU = None
g_extractHigh = None
g_mulPos = None
g_mulUnit_inner = {}  # bit -> Function
g_mclb_mul = {}       # N -> Function
g_mclb_sqr = {}       # N -> Function


def gen_once():
  global g_mulUU, g_extractHigh, g_mulPos
  g_mulUU = common.gen_mulUU(unit)
  g_extractHigh = common.gen_extractHigh(unit)
  g_mulPos = common.gen_mulPos(unit, g_mulUU)


def gen_mclb_addsub(isAdd):
  if isAdd:
    name = f'mclb_add{N}'
  else:
    name = f'mclb_sub{N}'
  common.gen_addsub(name, unit, N, isAdd)


def gen_mclb_addNF():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  name = f'mclb_addNF{N}'
  with Function(name, Void, pz, px, py, private=False):
    x = loadN(px, N)
    y = loadN(py, N)
    z = add(x, y)
    storeN(z, pz)
    ret(Void)


def gen_mclb_subNF():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  name = f'mclb_subNF{N}'
  with Function(name, Int(unit), pz, px, py, private=False):
    x = loadN(px, N)
    y = loadN(py, N)
    z = sub(x, y)
    storeN(z, pz)
    r = lshr(z, bit - 1)
    if bit != unit:
      r = trunc(r, unit)
    r = and_(r, Imm(1, unit))
    ret(r)


# z = px[0..N] * y, returns i{bit+unit}
def gen_mulUnit_inner():
  name = f'mulUnit_inner{bit}'
  g_mulUnit_inner[bit] = common.gen_mulPv(name, unit, N, g_mulPos, g_extractHigh)


# [r:z[]] = x[] * y
def gen_mclb_mulUnit():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  y = Int(unit)
  name = f'mclb_mulUnit{N}'
  with Function(name, Int(unit), pz, px, y, private=False):
    z = call(g_mulUnit_inner[bit], px, y)
    storeN(trunc(z, bit), pz)
    r = trunc(lshr(z, bit), unit)
    ret(r)


# [r:z[]] = z[] + x[] * y
def gen_mclb_mulUnitAdd():
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  y = Int(unit)
  name = f'mclb_mulUnitAdd{N}'
  with Function(name, Int(unit), pz, px, y, private=False):
    z = common.emit_mulUnit(unit, N, g_mulPos, g_extractHigh, px, y)
    z = add(z, zext(loadN(pz, N), bit + unit))
    storeN(trunc(z, bit), pz)
    r = trunc(lshr(z, bit), unit)
    ret(r)


def gen_mul_inner(pz, px, py):
  if N == 1:
    x = load(px)
    y = load(py)
    x = zext(x, unit * 2)
    y = zext(y, unit * 2)
    z = mul(x, y)
    storeN(z, pz)
    ret(Void)
  elif N > 8 and (N % 2) == 0:
    # W = 1 << half
    # (aW + b)(cW + d) = acW^2 + (ad + bc)W + bd
    # ad + bc = (a + b)(c + d) - ac - bd
    H = N // 2
    half = bit // 2
    pxW = getelementptr(px, H)
    pyW = getelementptr(py, H)
    pzWW = getelementptr(pz, N)
    call(g_mclb_mul[H], pz, px, py)    # bd
    call(g_mclb_mul[H], pzWW, pxW, pyW)  # ac

    a = zext(loadN(pxW, H), half + unit)
    b = zext(loadN(px, H), half + unit)
    c = zext(loadN(pyW, H), half + unit)
    d = zext(loadN(py, H), half + unit)
    t1 = add(a, b)
    t2 = add(c, d)
    buf = alloca_(unit, N)
    t1L = trunc(t1, half)
    t2L = trunc(t2, half)
    c1 = trunc(lshr(t1, half), 1)
    c2 = trunc(lshr(t2, half), 1)
    c0 = and_(c1, c2)
    c1 = select(c1, t2L, Imm(0, half))
    c2 = select(c2, t1L, Imm(0, half))
    buf1 = alloca_(unit, half // unit)
    buf2 = alloca_(unit, half // unit)
    storeN(t1L, buf1)
    storeN(t2L, buf2)
    call(g_mclb_mul[N // 2], buf, buf1, buf2)
    t = loadN(buf, N)
    t = zext(t, bit + unit)
    c0 = zext(c0, bit + unit)
    c0 = shl(c0, bit)
    t = or_(t, c0)
    c1 = zext(c1, bit + unit)
    c2 = zext(c2, bit + unit)
    c1 = shl(c1, half)
    c2 = shl(c2, half)
    t = add(t, c1)
    t = add(t, c2)
    t = sub(t, zext(loadN(pz, N), bit + unit))
    t = sub(t, zext(loadN(pz, N, N), bit + unit))
    if bit + half > t.bit:
      t = zext(t, bit + half)
    t = add(t, loadN(pz, N + H, H))
    storeN(t, pz, H)
    ret(Void)
  else:
    y = load(py)
    xy = call(g_mulUnit_inner[bit], px, y)
    store(trunc(xy, unit), pz)
    t = lshr(xy, unit)
    for i in range(1, N):
      y = loadN(py, 1, i)
      xy = call(g_mulUnit_inner[bit], px, y)
      t = add(t, xy)
      if i < N - 1:
        storeN(trunc(t, unit), pz, i)
        t = lshr(t, unit)
    storeN(t, pz, N - 1)
    ret(Void)


def gen_sqr_inner(py, px):
  if N == 1:
    x = load(px)
    x = zext(x, unit * 2)
    y = mul(x, x)
    storeN(y, py)
    ret(Void)
  elif N > 8 and (N % 2) == 0:
    # W = 1 << half
    # (aW + b)^2 = a^2W^2 + 2abW + b^2
    H = N // 2
    half = bit // 2
    pxW = getelementptr(px, H)
    pyWW = getelementptr(py, N)
    abBuf = alloca_(unit, N)
    call(g_mclb_mul[H], abBuf, px, pxW)
    call(g_mclb_sqr[H], py, px)     # b^2
    call(g_mclb_sqr[H], pyWW, pxW)  # a^2

    ab = loadN(abBuf, N)
    ab = zext(ab, ab.bit + unit)
    ab = add(ab, ab)
    ab = zext(ab, bit + half)
    pyH = getelementptr(py, H)
    t = loadN(pyH, N + H)
    t = add(t, ab)
    storeN(t, pyH)
    ret(Void)
  else:
    t1 = load(px)
    tt = call(g_mulUU, t1, t1)
    store(trunc(tt, unit), py)
    tt = lshr(tt, unit)
    t2 = load(getelementptr(px, N - 1))
    sum = call(g_mulUU, t1, t2)
    for i in range(2, N):
      t1 = load(px)
      t2 = load(getelementptr(px, N - i))
      line = call(g_mulUU, t1, t2)
      for j in range(1, i):
        t1 = load(getelementptr(px, j))
        t2 = load(getelementptr(px, N - i + j))
        t1 = call(g_mulUU, t1, t2)
        line = zext(line, line.bit + unit * 2)
        t1 = zext(t1, line.bit)
        t1 = shl(t1, unit * 2 * j)
        line = or_(line, t1)
      # line = ...[N-1+i 1][N-i 0]
      if sum.bit < line.bit:
        sum = zext(sum, line.bit)
      sum = shl(sum, unit)
      sum = add(sum, line)
    bit2 = unit * (N * 2 - 1)
    tt = zext(tt, bit2)
    for i in range(1, N):
      t1 = load(getelementptr(px, i))
      t1 = call(g_mulUU, t1, t1)
      t1 = zext(t1, bit2)
      t1 = shl(t1, unit * (i * 2 - 1))
      tt = or_(tt, t1)
    sum = zext(sum, bit2)
    sum = add(sum, sum)
    tt = add(tt, sum)
    storeN(tt, py, 1)
    ret(Void)


def gen_mclb_mul():
  global g_mclb_mul
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  name = f'mclb_mul{N}'
  with Function(name, Void, pz, px, py, private=False) as f:
    gen_mul_inner(pz, px, py)
  g_mclb_mul[N] = f


def gen_mclb_sqr():
  global g_mclb_sqr
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  name = f'mclb_sqr{N}'
  with Function(name, Void, py, px, private=False) as f:
    # on M1, mul is faster than sqr for N <= 6
    # on A64FX, mul is faster than sqr for N <= 4
    if N <= 6:
      gen_mul_inner(py, px, px)
    else:
      gen_sqr_inner(py, px)
  g_mclb_sqr[N] = f


def setBit(b):
  global bit, N
  bit = b
  N = b // unit


def setUnit(u):
  global unit, unit2
  unit = u
  unit2 = u * 2


def gen(maxN, addN):
  gen_once()
  for n in range(1, addN + 1):
    setBit(n * unit)
    gen_mclb_addsub(True)
    gen_mclb_addsub(False)
    gen_mclb_addNF()
    gen_mclb_subNF()
  for n in range(1, maxN + 1):
    setBit(n * unit)
    gen_mulUnit_inner()
    gen_mclb_mulUnit()
    gen_mclb_mulUnitAdd()
    gen_mclb_mul()
    gen_mclb_sqr()


def main():
  parser = argparse.ArgumentParser(description='generate bint{32,64}.ll')
  parser.add_argument('-u', type=int, default=64, help='unit bit size (32 or 64)')
  parser.add_argument('-n', type=int, default=0, help='max size of Unit')
  parser.add_argument('-addn', type=int, default=0, help='max size of add/sub')
  opt = parser.parse_args()

  setUnit(opt.u)
  maxN = opt.n
  addN = opt.addn
  if maxN == 0:
    maxN = 9 if unit == 64 else 17
    addN = 16 if unit == 64 else 32
  import sys
  print(f'unit={unit} N={maxN} addN={addN}', file=sys.stderr)
  gen(maxN, addN)
  term()


if __name__ == '__main__':
  main()
