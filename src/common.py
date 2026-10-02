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


# ---------------------------------------------------------------------------
# modp: y = x mod p for a fixed prime p by word-serial Barrett reduction with
# a two-unit reciprocal and a single conditional subtraction per step.
#
# Let L = bitlen(p), N = number of units of p, u = unit and s = N u - L (the
# leading zero bits of p in N units). The invariant is r < p. One step folds
# the next unit w of x into xx = r * 2^u + w < p 2^u, estimates the quotient
# from the top two units of xx,
#   W  = xx >> ((N-1) u)  (< 2^(2u)),
#   Q  = floor(2^(u+1+L) / p) (< 2^(u+2)),  Qt = Q 2^s (< 2^(2u)),
#   y  = floor(W * Qt / 2^(2u+1)),
# and sets r = xx - y p, then r -= p once if r >= p. The estimate never
# exceeds the true quotient q = floor(xx / p): W Qt / 2^(2u+1) = (xx - xl) Q /
# 2^(L+u+1) <= xx / p with xl = xx mod 2^((N-1) u). Its error is less than
# xl / p + xx / 2^(L+u+1) < 2^((N-1) u) / 2^(L-1) + p / 2^(L+1) < 1/2 + 1/2
# (the first term is <= 2^(-1-t) with t = L - 2 - (N-1) u >= 0), so it is at
# most 1 and one conditional subtraction suffices. Using the top two units
# as they are (instead of xx >> (L-2), which needs a variable shift by t per
# step) makes the code independent of L; the shift is folded into Qt.
# Qt < 2^(2u) requires s <= u - 2, i.e. L >= (N-1) u + 2, which also makes the
# initial r = top N-1 units of x < p.
#
# The subtraction r = xx - y p is done with additions only (LLVM turns a
# wide sub of a product into a negation and an add chain otherwise):
# with np = 2^bit - p (N units), y (2^(bit+unit) - p) = y np - y 2^bit
# (mod 2^(bit+unit)), so r = xx + y np - (y << bit). Likewise the final
# r - p >= 0 test is the carry of r + np into bit `bit`.
#
# The p-dependent values are passed as a parameter block of units (struct
# Modp on the C side), laid out as
#   param[MODP_Q0]    = Qt mod 2^u
#   param[MODP_Q1]    = Qt >> u
#   param[MODP_NP + i] = np[i]  (i < N), np = 2^(N unit) - p
# so that one function per N (not per p) suffices.
MODP_Q0 = 0
MODP_Q1 = 1
MODP_NP = 2


# returns the parameter block (list of ints) of modp for p
def modp_param(p, unit, N):
  L = p.bit_length()
  assert (N - 1) * unit + 2 <= L <= N * unit
  s = N * unit - L
  Q = (1 << (unit + 1 + L)) // p
  Qt = Q << s
  mask = (1 << unit) - 1
  assert Qt < (1 << (2 * unit))
  param = [Qt & mask, Qt >> unit]
  np = (1 << (N * unit)) - p
  for i in range(N):
    param.append((np >> (unit * i)) & mask)
  return param


# load the constants of modp from the parameter block pparam (see
# modp_param) and return (Qt, np, pnp) as used by modp_step:
#   Qt    : Q 2^s in i{2 unit}
#   np    : 2^bit - p zero-extended to i{bit+unit}
#   pnp   : pointer to np in the parameter block (for mulPv)
def modp_consts(unit, N, pparam):
  bit = N * unit
  bu = bit + unit
  Qt = loadN(pparam, 2, MODP_Q0)
  pnp = getelementptr(pparam, MODP_NP)
  np = zext(loadN(pnp, N), bu)
  return (Qt, np, pnp)


# one step of modp: returns r = xx mod p (i{bit}) for xx = r 2^unit + w
# (i{bit+unit}, < p 2^unit). consts is the tuple of modp_consts.
# mulPv(pnp, y) returns i{N*unit+unit} = pnp[0..N] * y.
def modp_step(unit, N, xx, consts, mulPv):
  bit = N * unit
  bu = bit + unit
  (Qt, np, pnp) = consts
  # y = floor(W Qt / 2^(2 unit + 1)) with W = the top two units of xx
  W = trunc(lshr(xx, (N - 1) * unit), unit * 2)
  P = mul(zext(W, unit * 4), zext(Qt, unit * 4))
  y = trunc(lshr(P, unit * 2 + 1), unit)
  # r = xx - y p = xx + y np - (y << bit)  (mod 2^bu)
  ynp = call(mulPv, pnp, y)
  r = add(xx, ynp)
  r = sub(r, shl(zext(y, bu), bit))
  # r -= p if r >= p : r + np >= 2^bit
  v = add(r, np)
  c = trunc(lshr(v, bit), 1)
  return select(c, trunc(v, bit), trunc(r, bit))




# int name(Unit *dst, const Unit *src, size_t srcN, const Unit *para) (para is
# struct Modp on the C side, the layout of modp_param):
# returns 0 if srcN * sizeof(Unit) > 64 (src wider than 512 bits); otherwise
# dst[N] = src[srcN] mod p and returns 1 (the units of dst above src are
# zero when srcN < N). xN is the maximum srcN (512/unit for mcl).
# The xN - N + 1 steps of modp_step are unrolled (as in the fixed-length
# emit_modp2 of mcl-ff/src/gen_ff.py, from which this is derived), each
# followed by an exit test (srcN == N + j), so srcN - N + 1 steps run and
# the results of the exits meet in a phi; the input pointer is the same
# run-time src + (srcN - N - j) instead of constant offsets.
# srcN < N means src < p (since (N-1) unit + 2 <= L), so dst is src zero-extended:
# a compare/store chain copies src[i] for i < srcN, then zero-fills the rest.
# srcN is i{unit} (size_t of the target where the unit is used).
def emit_modp(unit, N, xN, pz, px, srcN, pparam, mulPv):
  bu = N * unit + unit
  ret0L = Label()
  okL = Label()
  bigL = Label()
  smallL = Label()
  doneL = Label()
  br(icmp(ugt, srcN, xN), ret0L, okL)
  L(ret0L)
  ret(Imm(0, 32))
  L(okL)
  br(icmp(ult, srcN, N), smallL, bigL)
  L(bigL)
  consts = modp_consts(unit, N, pparam)
  # r = top N-1 units of src (< p), k = srcN - N = index of the next unit
  if N == 1:
    r = None
  else:
    r = loadN(getelementptr(px, sub(srcN, N - 1)), N - 1)
  pk = getelementptr(px, sub(srcN, N))
  curL = bigL
  exits = []
  for j in range(xN - N + 1):
    w = load(pk)
    if r is None:
      xx = zext(w, bu)
    else:
      xx = pack([w, r])
      if xx.bit < bu:  # first step: r has N-1 units
        xx = zext(xx, bu)
    r = modp_step(unit, N, xx, consts, mulPv)
    exits.append((r, curL))
    if j < xN - N:
      nextL = Label()
      br(icmp(eq, srcN, N + j), doneL, nextL)
      L(nextL)
      curL = nextL
      pk = getelementptr(pk, Imm(-1, unit))
  br(doneL)
  L(doneL)
  storeN(phi(*exits), pz)
  ret(Imm(1, 32))
  # dst = src zero-extended
  L(smallL)
  zeroL = [Label() for i in range(N)]
  for i in range(N - 1):
    nextL = Label()
    br(icmp(eq, srcN, i), zeroL[i], nextL)
    L(nextL)
    store(load(getelementptr(px, i)), getelementptr(pz, i))
  br(zeroL[N - 1])
  for i in range(N):
    L(zeroL[i])
    store(Imm(0, unit), getelementptr(pz, i))
    if i < N - 1:
      br(zeroL[i + 1])
  ret(Imm(1, 32))


# int name(Unit *dst, const Unit *src, size_t srcN, const Unit *para) : see emit_modp
def gen_modp(name, unit, N, xN, mulPv, private=False):
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  srcN = Int(unit)
  pparam = IntPtr(unit, const=True)
  with Function(name, Int(32), pz, px, srcN, pparam, private=private) as f:
    emit_modp(unit, N, xN, pz, px, srcN, pparam, mulPv)
  return f


# ---------------------------------------------------------------------------
# fpDbl add/sub: z[2N] = x[2N] +- y[2N] mod (p 2^bit); the low N units are
# added (subtracted) as they are and the carry (borrow) goes into the high
# half, which is reduced mod p like emit_fp_add / emit_fp_sub_raw.
# Used by mcl_fpDbl_add{N}L / mcl_fpDbl_sub{N}L of gen.py and gen_fpDbl_add / gen_fpDbl_sub.
def emit_fpDbl_add(unit, N, pz, px, py, pp):
  bit = N * unit
  bu = bit + unit
  b2u = bit * 2 + unit
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


def emit_fpDbl_sub(unit, N, pz, px, py, pp):
  bit = N * unit
  b2 = bit * 2
  b2u = b2 + unit
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


# ---------------------------------------------------------------------------
# The p-generic Fp / Fp2 functions for the A_ slots of struct Op (fp.hpp /
# fp_tower.hpp) in the LLVM configurations without the x64 asm: one function
# per shape (the number of units N, isFullBit, nocarry: FieldShape) that
# takes p as its last argument pp (rp = -p^-1 mod 2^unit at pp[-1]) like
# mcl_fp_montNF{N}L of gen.py, e.g. mcl_fp2_mul_u1_6L(z, x, y, p); fp.cpp
# registers them by N / isFullBit / u / xi_a (setLLVMCode).
# History: they started as the p-fixed functions of mcl-ff/src/gen_ff.py
# (2026-09-14, mcl_c0_* / mcl_c5_* with p in a non-const global and the Xbyak
# ABI without p). Measured against them (memo.md 2026-09-28), the p argument
# costs nothing on Apple M4 and a few % on x64 (one register for pp), so the
# p-fixed variant was removed; the {0, p} table for the +p correction of sub
# (gen_sub_raw_tbl of gen_ff.py) is not usable with a p argument.

# The Montgomery parameters of a prime p for the given unit size:
# N = the number of units, bit = N unit, ip = -p^-1 mod 2^unit,
# isFullBit = p uses the top bit of the top unit. Used by mcl-ff.
class Montgomery:
  def __init__(self, p, unit):
    self.p = p
    self.unit = unit
    self.pbit = p.bit_length()
    self.N = (self.pbit + unit - 1) // unit
    self.bit = self.N * unit
    self.isFullBit = self.pbit == self.bit
    M = 1 << unit
    self.ip = (-pow(p, -1, M)) % M
    assert (self.p * self.ip + 1) % M == 0
    # p < R/4 : the fused Montgomery mul accepts operands < 2p (used by fp2_sqr)
    self.nocarry = (p >> (self.bit - 2)) == 0


# The shape of the field of the generators below: unit, N (units), isFullBit
# (p may use the top bit of the top unit) and nocarry (p < R/4). p itself is
# the last argument pp of every generated function (extraArgs / getPP).
class FieldShape:
  def __init__(self, unit, N, isFullBit, nocarry):
    self.unit = unit
    self.N = N
    self.bit = N * unit
    self.isFullBit = isFullBit
    self.nocarry = nocarry

  # the extra arguments of a Function: [pp]
  def extraArgs(self):
    return [IntPtr(self.unit)]

  # the pointer to p (i{unit}*) in a function with the arguments args
  def getPP(self, args):
    return args[-1]

  # rp = -p^-1 mod 2^unit as an i{unit} value
  def getRp(self, pp):
    return load(getelementptr(pp, -1))

  # the arguments that pass p to a callee of the same shape (mul2 -> add, sqr -> mul)
  def passArgs(self, args):
    return [args[-1]]


def gen_fp_add(name, fs):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False) as f:
    pp = fs.getPP(args)
    # volatile: keep the operand loads unfused so store-forwarded inputs
    # (common in dependency chains) do not pay the folded-load latency.
    x = loadN(px, N, volatile=True)
    y = loadN(py, N, volatile=True)
    p = loadN(pp, N)
    x = emit_fp_add(unit, x, y, p, fs.isFullBit)
    storeN(x, pz)
    ret(Void)
  return f


# Fp2 add: both components (the second at offset units) with one load of p
def gen_fp2_add(name, fs, offset):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False) as f:
    pp = fs.getPP(args)
    p = loadN(pp, N)
    for i in range(2):
      x = loadN(px, N, offset=i*offset, volatile=True)
      y = loadN(py, N, offset=i*offset, volatile=True)
      x = emit_fp_add(unit, x, y, p, fs.isFullBit)
      storeN(x, pz, offset=i*offset)
    ret(Void)
  return f


# The sub reduction via an and-mask: p is loaded from pp at function entry,
# so the load runs in parallel with the subtraction and only
# sext -> and -> add follow the borrow. The alternative (gen_sub_raw_tbl of
# mcl-ff/src/gen_ff.py) indexes a writable {zero, p} table by the borrow: on
# x64 that lowers to add/adc with folded memory operands and wins, but the
# load address depends on the borrow and on aarch64 the L1 load-use latency
# (~4 cycles) made sub 1.23x slower; it also needs p at a fixed address.
def gen_sub_raw_mask(unit, x, y, p, isFullBit):
  bit = x.bit
  v, c = emit_fp_sub_raw(unit, x, y, isFullBit)
  v = add(v, and_(p, sext(c, bit)))
  return v


def gen_fp_sub(name, fs):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    p = loadN(fs.getPP(args), N)
    x = loadN(px, N, volatile=True)
    y = loadN(py, N, volatile=True)
    v = gen_sub_raw_mask(unit, x, y, p, fs.isFullBit)
    storeN(v, pz)
    ret(Void)


def gen_fp2_sub(name, fs, offset):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    p = loadN(fs.getPP(args), N)
    for i in range(2):
      x = loadN(px, N, offset=i*offset, volatile=True)
      y = loadN(py, N, offset=i*offset, volatile=True)
      v = gen_sub_raw_mask(unit, x, y, p, fs.isFullBit)
      storeN(v, pz, offset=i*offset)
    ret(Void)


# y = -x mod p = (x == 0) ? 0 : p - x (the same as negT of low_func.hpp and
# gen_fp_neg of fp_generator.hpp); the components at offset i*offset.
# A branch, not a select: the select version always ran the sub chain and
# 6 csel and was 1.56x slower than negT on Apple M4 (the operand is almost
# never zero, so the branch is predicted). p is loaded inside the nonzero
# block so that LLVM does not speculate the block back into a select.
def emit_neg(fs, py, px, pp, offset, n):
  N = fs.N
  for i in range(n):
    zeroL = Label()
    negL = Label()
    doneL = Label()
    x = loadN(px, N, offset=i*offset)
    c = icmp(eq, x, Imm(0, fs.bit))
    br(c, zeroL, negL)
    L(negL)
    p = loadN(pp, N)
    storeN(sub(p, x), py, offset=i*offset)
    br(doneL)
    L(zeroL)
    storeN(x, py, offset=i*offset)
    br(doneL)
    L(doneL)


def gen_fp_neg(name, fs):
  unit = fs.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    emit_neg(fs, py, px, fs.getPP(args), 0, 1)
    ret(Void)


def gen_fp2_neg(name, fs, offset):
  unit = fs.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    emit_neg(fs, py, px, fs.getPP(args), offset, 2)
    ret(Void)


# y = 2x mod p as a call to add(y, x, x) (a tail call after clang), like
# gen_fp_sqr. An inline `add x, x` is canonicalized by LLVM to `shl 1`
# and lowered on aarch64 to extr/lsl instead of the adds chain of add, and
# that was 13% (Fp) / 30% (Fp2) slower on Apple M4 (mcl-ff memo.md 2026-09-14).
# addF is the add of Fp (gen_fp_add) or Fp2 (gen_fp2_add) of the same shape.
def gen_mul2(name, fs, addF):
  unit = fs.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    call(addF, py, px, px, *fs.passArgs(args))
    ret(Void)


# k x mod p for a reduced x (i{bit}) and a small constant k >= 1 by an add
# chain (double and add; the same chain as mulSmallUnit of util.hpp for
# k = 5 and 9). p is i{bit}.
def emit_fp_mulSmall(unit, x, k, p, isFullBit):
  assert k >= 1
  t = x
  for i in range(k.bit_length() - 2, -1, -1):
    t = emit_fp_add(unit, t, t, p, isFullBit)
    if (k >> i) & 1:
      t = emit_fp_add(unit, t, x, p, isFullBit)
  return t


# Fp2 mul_xi: y = x xi for x = a + b i, i^2 = -u and xi = xi_a + i:
#   y = (a xi_a - u b) + (a + b xi_a) i
# The supported (u, xi_a) are those of fp_tower.hpp (fp2_mul_xi_1_iA,
# fp2_mul_xi_a_iA, fp2u_mul_xi_0_iA):
#   (1, 1)    : y = (a - b) + (a + b) i        (BN254, BLS12-381)
#   (1, xi_a) : y = (xi_a a - b) + (a + xi_a b) i   (BN_SNARK1, xi_a = 9)
#   (u, 0)    : y = -u b + a i                 (BLS12-377, u = 5)
# k x is an add chain (emit_fp_mulSmall). Both components are loaded before
# the stores, so y may be x; noalias=False because the store of the copied
# component (y.b = a of (u, 0)) has no data dependence on the other stores
# and LLVM sank the load of a below the store of y.a with noalias (in-place
# mul_xi(x, x) then read the overwritten a).
def gen_fp2_mul_xi(name, fs, offset, u=1, xi_a=1):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False, noalias=False):
    p = loadN(fs.getPP(args), N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    if u == 1:
      if xi_a == 1:
        ya = gen_sub_raw_mask(unit, a, b, p, fs.isFullBit)
        yb = emit_fp_add(unit, a, b, p, fs.isFullBit)
      else:
        ya = gen_sub_raw_mask(unit, emit_fp_mulSmall(unit, a, xi_a, p, fs.isFullBit), b, p, fs.isFullBit)
        yb = emit_fp_add(unit, emit_fp_mulSmall(unit, b, xi_a, p, fs.isFullBit), a, p, fs.isFullBit)
    else:
      assert xi_a == 0
      ub = emit_fp_mulSmall(unit, b, u, p, fs.isFullBit)
      ya = gen_sub_raw_mask(unit, Imm(0, fs.bit), ub, p, fs.isFullBit) # -u b
      yb = a
    storeN(ya, py)
    storeN(yb, py, offset=offset)
    ret(Void)


def gen_fpDbl_add(name, fs):
  unit = fs.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    pp = fs.getPP(args)
    emit_fpDbl_add(unit, fs.N, pz, px, py, pp)
    ret(Void)


def gen_fpDbl_sub(name, fs):
  unit = fs.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    pp = fs.getPP(args)
    emit_fpDbl_sub(unit, fs.N, pz, px, py, pp)
    ret(Void)


# Fused Montgomery mul: z = x y R^-1 mod p; the body is emit_mont (shared
# with mcl_fp_mont of gen.py). rp = -p^-1 mod 2^unit is loaded from pp[-1]
# instead of being an immediate: LLVM strength-reduces t * rp for
# rp = 0xfffffffeffffffff (BLS12-381 r) into shl/add/neg, and that made the
# mul 35% slower on x64 (Xeon w9-3495X); loaded from memory it is the same speed.
def gen_fp_mul(name, fs, mulUnit):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False) as f:
    pp = fs.getPP(args)
    rp = fs.getRp(pp)
    emit_mont(unit, N, pz, px, py, pp, rp, mulUnit, fs.isFullBit)
    ret(Void)
  return f


# Montgomery reduction: z = xy R^-1 mod p where xy has 2N units; the body is
# emit_montRed (shared with mcl_fp_montRed of gen.py). The high units
# are fetched from memory via the getHi callback.
def gen_fpDbl_mod(name, fs, mulUnit):
  unit = fs.unit
  N = fs.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  pxy = IntPtr(unit)
  args = [pz, pxy] + fs.extraArgs()
  with Function(name, Void, *args, private=False) as f:
    pp = fs.getPP(args)
    rp = fs.getRp(pp)
    lo = loadN(pxy, N)
    p = loadN(pp, N)
    z = emit_montRed(unit, N, lo, lambda i: load(getelementptr(pxy, N + i)), pp, p, rp, mulUnit, fs.isFullBit)
    storeN(z, pz)
    ret(Void)
  return f


# mulPre: pz[2N] = px[N] * py[N] (no reduction); the schoolbook body is
# emit_mulPre (shared with mclb_mul of gen_bint.py), so the generated code is
# the same as mclb_mul{N} of bint{unit}.ll. It is private: Op keeps
# fpDbl_mulPre = bint::get_mul(N) (mclb_mul{N}, or the mulx asm on x64) and
# this one is only called from the fp2 functions.
def gen_fpDbl_mulPre(name, fs, mulUnit):
  unit = fs.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=True) as f:
    emit_mulPre(unit, fs.N, pz, px, py, mulUnit)
    ret(Void)
  return f


# sqrPre: z[2N] = x[N]^2 (no reduction) for x = [x[0], ..., x[N-1]] (i{unit}
# values), returns i{2N unit}.
# Same schedule as the handwritten x64 sqrPre6 of fp_generator.hpp: the cross
# products on the anti-diagonal d = j - i, x[i]*x[i+d], sit at limbs
# d, d+2, ... and tile without overlap, so a row is a plain concat (pack).
# Rows are accumulated bottom-up (d = N-1 .. 1); each row extends the
# accumulator by one limb at both ends, so a row add is one short carry chain
# absorbed in the row's own top limb. Keeping the accumulator at its minimal
# width (grow by 2 limbs per row, no early zext to 2N limbs) matters: with
# full-width adds clang keeps 2N-limb values live and spills heavily.
# Finally double the accumulator (each cross term appears twice by symmetry)
# and add the diagonal squares x[i]^2, which tile the full 2N limbs exactly.
# Used by mclb_sqr{N} (gen_bint.py, N <= 6) and the fixed sqr experiments of mcl-ff.
def sqrPre_raw(unit, x, N):
  unit2 = unit * 2
  bit2 = unit * N * 2
  if N == 1:
    return mul(zext(x[0], unit2), zext(x[0], unit2))
  acc = None
  for d in range(N - 1, 0, -1):
    row = pack([mul(zext(x[i], unit2), zext(x[i + d], unit2)) for i in range(N - d)])
    if acc is None:
      acc = row
    else:
      acc = add(shl(zext(acc, row.bit), unit), row)
  acc = zext(acc, acc.bit + unit)
  acc = add(acc, acc)
  z = shl(zext(acc, bit2), unit)
  # emit the diagonal mulx last, close to their only use: hoisting them to
  # the top lengthens their live ranges and costs ~1 cycle in practice
  diag = pack([mul(zext(x[i], unit2), zext(x[i], unit2)) for i in range(N)])
  z = add(z, diag)
  return z


# sqr: z = x^2 R^-1 mod p as a call to mul(z, x, x). The fused variant
# (sqrPre_raw + emit_montRed in one function) needs fewer muls
# (N(N+1)/2 + N^2 + N = 63 vs 2N^2 + N = 78 for N=6) but loses to mul(x, x)
# on both Xeon w9-3495X and Apple M4 : sqrPre_raw keeps the whole 2N-limb
# product live when the serial reduction starts, which the register file
# cannot hold, and the saved muls are eaten by spills (mcl-ff memo.md 2026-07-27).
# mulF is the mul of the same shape.
def gen_fp_sqr(name, fs, mulF):
  unit = fs.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  args = [pz, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False) as f:
    call(mulF, pz, px, px, *fs.passArgs(args))
    ret(Void)
  return f


# FpDbl add / sub on 2N-unit values x, y < p R (i{2 bit}; p is i{bit}) with
# the high half reduced mod p (x + y - p R if the high half >= p, x - y + p R
# on borrow) like emit_fpDbl_add / emit_fpDbl_sub; the result is < p R.
# They return (lo, hi) as two i{bit} values (stored separately or packed).
def fpDbl_add_val(unit, N, x, y, p):
  bit = N * unit
  bu = bit + unit
  b2u = bit * 2 + unit
  t = add(zext(x, b2u), zext(y, b2u))
  L = trunc(t, bit)
  H = trunc(lshr(t, bit), bu)
  Hp = sub(H, zext(p, bu))
  c = trunc(lshr(Hp, bit), 1)
  H = trunc(select(c, H, Hp), bit)
  return L, H


def fpDbl_sub_val(unit, N, x, y, p):
  bit = N * unit
  b2 = bit * 2
  b2u = b2 + unit
  vc = sub(zext(x, b2u), zext(y, b2u))
  L = trunc(vc, bit)
  c = trunc(lshr(vc, b2), 1)
  H = add(trunc(lshr(vc, bit), bit), select(c, p, Imm(0, bit)))
  return L, H


# k x mod p R for an FpDbl value x < p R (i{2 bit}) and a small constant
# k >= 1 by an add chain of fpDbl_add_val (the same chain as mulSmallUnit of
# util.hpp for k = 5 and 9). Returns i{2 bit}.
def emit_fpDbl_mulSmall(unit, N, x, k, p):
  assert k >= 1
  t = x
  for i in range(k.bit_length() - 2, -1, -1):
    t = pack(fpDbl_add_val(unit, N, t, t, p))
    if (k >> i) & 1:
      t = pack(fpDbl_add_val(unit, N, t, x, p))
  return t


# k x mod p R for x < p^2 (the product of two reduced values, i{2 bit}) and
# 2 <= k <= 8 with p < R/4 (nocarry): k x < 2 p R fits in 2N units and its
# high half is < 2p, so one conditional -p reduces it (cheaper than
# emit_fpDbl_mulSmall). Returns i{2 bit} < p R.
def emit_fpDbl_mulSmallP2(unit, N, x, k, p):
  bit = N * unit
  assert 2 <= k <= 8
  t = None
  for i in range(k.bit_length()):
    if (k >> i) & 1:
      s = shl(x, i) if i > 0 else x
      t = s if t is None else add(t, s)
  L = trunc(t, bit)
  H = trunc(lshr(t, bit), bit)
  Hp = sub(H, p)
  c = trunc(lshr(Hp, bit - 1), 1) # borrow (H < 2p < 2^(bit-1))
  H = select(c, H, Hp)
  return pack([L, H])


# Fp2 mul: (z.a, z.b) = (a c - u b d, a d + b c) where x = (a, b), y = (c, d),
# each component N limbs in Montgomery form, b at offset limbs from a, and
# i^2 = -u. Same Karatsuba structure as gen_fp2_mul of fp_generator.hpp:
#   s = a + b, t = c + d (no carry out since p is not full bit)
#   d1 = s t, d0 = a c, d2 = b d (3 mulPre calls on alloca buffers)
#   d1 -= d0; d1 -= d2 (= a d + b c; no borrow since s t >= a c + b d)
#   d2 = u d2 mod p R if u != 1 (emit_fpDbl_mulSmallP2, u <= 8)
#   d0 -= d2 (mod p R: on borrow, add p to the high half by a select of p / 0;
#     the Xbyak version uses a {zero, p} table so that x64 lowers it to an
#     add chain with memory operands, which needs p at a fixed address)
#   z.a = mod(d0), z.b = mod(d1)
# Requires p not full bit and p < R/4 (nocarry).
def gen_fp2_mul(name, fs, mulPreF, modF, offset, u=1):
  unit = fs.unit
  N = fs.N
  bit = unit * N
  bit2 = bit * 2
  assert not fs.isFullBit and fs.nocarry
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    ps = alloca_(unit, N)
    pt = alloca_(unit, N)
    pd0 = alloca_(unit, 2*N)
    pd1 = alloca_(unit, 2*N)
    pd2 = alloca_(unit, 2*N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    c = loadN(py, N)
    d = loadN(py, N, offset=offset)
    storeN(add(a, b), ps)
    storeN(add(c, d), pt)
    call(mulPreF, pd1, ps, pt)
    call(mulPreF, pd0, px, py)
    call(mulPreF, pd2, getelementptr(px, offset), getelementptr(py, offset))
    d0 = loadN(pd0, 2*N)
    d1 = loadN(pd1, 2*N)
    d2 = loadN(pd2, 2*N)
    d1 = sub(sub(d1, d0), d2)
    storeN(d1, pd1)
    p = loadN(fs.getPP(args), N)
    if u != 1:
      d2 = emit_fpDbl_mulSmallP2(unit, N, d2, u, p)
    v = sub(d0, d2)
    # borrow flag: d0, d2 < p R < 2^(bit2-2), so the top bit is set iff
    # the sub wrapped around
    c = trunc(lshr(v, bit2 - 1), 1)
    pc = select(c, p, Imm(0, bit))
    hi = add(trunc(lshr(v, bit), bit), pc)
    storeN(trunc(v, bit), pd0)
    storeN(hi, pd0, offset=N)
    call(modF, pz, pd0, *fs.passArgs(args))
    call(modF, getelementptr(pz, offset), pd1, *fs.passArgs(args))
    ret(Void)


# Fp2 sqr: (z.a, z.b) = (a^2 - u b^2, 2 a b) where x = (a, b), b at offset
# limbs from a. Same structure as gen_fp2_sqr of fp_generator.hpp: two
# calls of the fused Montgomery mul on alloca buffers, no sqrPre (both
# products are cross products, so squaring symmetry cannot be exploited).
# u = 1:
#   t1 = 2b, z.b = mul(t1, a) = 2 a b R^(-1)
#   t2 = a + b, t3 = a + p - b (adding p unconditionally avoids a borrow
#     check; p (a + b) vanishes mod p)
#   z.a = mul(t2, t3) = (a^2 - b^2) R^(-1)
# u != 1 (odd; u = 5 of BLS12-377), the same as sqrAu5 of fp_tower.hpp:
#   a^2 - u b^2 = (a - b)(a + u b) - (u - 1) a b = mul(t2, t3) - k z.b
#   with t2 = a + (u b mod p) (an add chain), t3 = a + p - b and k = (u - 1) / 2.
# The mul operands are < 2p, so the products are < 4p^2 < p R, which
# requires p < R/4 (nocarry). sqr(x, x) works in place: when the first
# mul writes z.b it only reads x.a, which does not overlap x.b, and the
# second mul reads only the t2/t3 copies.
def gen_fp2_sqr(name, fs, mulF, offset, u=1):
  unit = fs.unit
  N = fs.N
  assert not fs.isFullBit and fs.nocarry
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  args = [pz, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    pp = fs.getPP(args)
    pt1 = alloca_(unit, N)
    pt2 = alloca_(unit, N)
    pt3 = alloca_(unit, N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    p = loadN(pp, N)
    storeN(add(b, b), pt1)
    if u == 1:
      storeN(add(a, b), pt2)
    else:
      assert u % 2 == 1
      storeN(add(emit_fp_mulSmall(unit, b, u, p, False), a), pt2)
    storeN(sub(add(a, p), b), pt3)
    call(mulF, getelementptr(pz, offset), pt1, px, *fs.passArgs(args))
    call(mulF, pz, pt2, pt3, *fs.passArgs(args))
    if u != 1:
      zb = loadN(pz, N, offset=offset)
      za = loadN(pz, N)
      t = emit_fp_mulSmall(unit, zb, (u - 1) // 2, p, False)
      storeN(gen_sub_raw_mask(unit, za, t, p, False), pz)
    ret(Void)


# Fp2Dbl (lazy reduction, used by Fp6/Fp12 mul and sqr): each component is
# 2N limbs, b at offsetDbl (= 2 offset) limbs from a. The inputs (Fp2) have
# b at offset limbs. Same as mulPreA / sqrPreA / mul_xi_1_iA of
# Fp2DblT (fp_tower.hpp) and gen_fp2Dbl_* of fp_generator.hpp.

# Fp2Dbl mulPre: (z.a, z.b) = (a c - u b d, a d + b c) (no reduction), i.e.
# gen_fp2_mul without the two mods. d1 = (a + b)(c + d) - a c - b d
# has no borrow; d0 = a c - u b d adds p to the high half on borrow (the
# select of p / 0). z never aliases x or y (Fp2Dbl vs Fp2), so d1 and d0 are
# computed in place.
def gen_fp2Dbl_mulPre(name, fs, mulPreF, offset, offsetDbl, u=1):
  unit = fs.unit
  N = fs.N
  bit = unit * N
  bit2 = bit * 2
  assert not fs.isFullBit and fs.nocarry
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  args = [pz, px, py] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    ps = alloca_(unit, N)
    pt = alloca_(unit, N)
    pd2 = alloca_(unit, 2*N)
    pd1 = getelementptr(pz, offsetDbl)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    c = loadN(py, N)
    d = loadN(py, N, offset=offset)
    storeN(add(a, b), ps)
    storeN(add(c, d), pt)
    call(mulPreF, pd1, ps, pt)
    call(mulPreF, pz, px, py)
    call(mulPreF, pd2, getelementptr(px, offset), getelementptr(py, offset))
    d0 = loadN(pz, 2*N)
    d1 = loadN(pd1, 2*N)
    d2 = loadN(pd2, 2*N)
    d1 = sub(sub(d1, d0), d2)
    storeN(d1, pd1)
    p = loadN(fs.getPP(args), N)
    if u != 1:
      d2 = emit_fpDbl_mulSmallP2(unit, N, d2, u, p)
    v = sub(d0, d2)
    c = trunc(lshr(v, bit2 - 1), 1)
    pc = select(c, p, Imm(0, bit))
    hi = add(trunc(lshr(v, bit), bit), pc)
    storeN(trunc(v, bit), pz)
    storeN(hi, pz, offset=N)
    ret(Void)


# Fp2Dbl sqrPre: (y.a, y.b) = ((a + b)(a - b), 2 a b) (no reduction) for
# u = 1. t1 = 2b and t2 = a + b are < 2p (no carry since p is not full bit),
# a - b is reduced mod p; the products are < 2p^2 < p R.
# u != 1 (odd; u = 5 of BLS12-377), the same as sqrPreAu5 of fp_tower.hpp:
#   y.a = a^2 - u b^2 = (a - b)(a + u b) - k (2 a b), k = (u - 1) / 2
# with a + (u b mod p) < 2p; k (2 a b) < 4 p^2 < p R for k <= 2, so the
# single FpDbl sub (+p R on borrow) gives y.a < p R.
def gen_fp2Dbl_sqrPre(name, fs, mulPreF, offset, offsetDbl, u=1):
  unit = fs.unit
  N = fs.N
  assert not fs.isFullBit and fs.nocarry
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False):
    pt1 = alloca_(unit, N)
    pt2 = alloca_(unit, N)
    p = loadN(fs.getPP(args), N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    storeN(add(b, b), pt1)
    if u == 1:
      storeN(add(a, b), pt2)
      call(mulPreF, getelementptr(py, offsetDbl), pt1, px) # 2 a b
      storeN(gen_sub_raw_mask(unit, a, b, p, False), pt1) # a - b mod p
      call(mulPreF, py, pt1, pt2) # (a + b)(a - b)
    else:
      assert u % 2 == 1
      k = (u - 1) // 2
      assert k <= 2
      call(mulPreF, getelementptr(py, offsetDbl), pt1, px) # 2 a b
      storeN(add(emit_fp_mulSmall(unit, b, u, p, False), a), pt1) # a + u b
      storeN(gen_sub_raw_mask(unit, a, b, p, False), pt2) # a - b mod p
      call(mulPreF, py, pt1, pt2) # (a + u b)(a - b)
      ya = loadN(py, 2*N)
      yb = loadN(py, 2*N, offset=offsetDbl)
      t = yb if k == 1 else add(yb, yb)
      L, H = fpDbl_sub_val(unit, N, ya, t, p)
      storeN(L, py)
      storeN(H, py, offset=N)
    ret(Void)


# Fp2Dbl mul_xi: y = x xi on 2N-limb values (x.b at offsetDbl) with the
# FpDbl add/sub reduction of the high half (fpDbl_add_val / fpDbl_sub_val)
# for the same (u, xi_a) as gen_fp2_mul_xi (mul_xi_1_iA, mul_xi_a_iA,
# mulu_xi_0_iA of Fp2Dbl); k x is an add chain (emit_fpDbl_mulSmall).
# Both inputs are loaded before the stores, so y may be x (noalias=False,
# see gen_fp2_mul_xi).
def gen_fp2Dbl_mul_xi(name, fs, offsetDbl, u=1, xi_a=1):
  unit = fs.unit
  N = fs.N
  bit = N * unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  args = [py, px] + fs.extraArgs()
  with Function(name, Void, *args, private=False, noalias=False):
    p = loadN(fs.getPP(args), N)
    xa = loadN(px, 2*N)
    xb = loadN(px, 2*N, offset=offsetDbl)
    if u == 1:
      # y.a = xi_a x.a - x.b, y.b = xi_a x.b + x.a
      if xi_a == 1:
        ta, tb = xa, xb
      else:
        ta = emit_fpDbl_mulSmall(unit, N, xa, xi_a, p)
        tb = emit_fpDbl_mulSmall(unit, N, xb, xi_a, p)
      yaL, yaH = fpDbl_sub_val(unit, N, ta, xb, p)
      ybL, ybH = fpDbl_add_val(unit, N, tb, xa, p)
      storeN(yaL, py)
      storeN(yaH, py, offset=N)
      storeN(ybL, py, offset=offsetDbl)
      storeN(ybH, py, offset=offsetDbl + N)
    else:
      assert xi_a == 0
      # y.a = -u x.b, y.b = x.a
      t = emit_fpDbl_mulSmall(unit, N, xb, u, p)
      yaL, yaH = fpDbl_sub_val(unit, N, Imm(0, bit * 2), t, p)
      storeN(yaL, py)
      storeN(yaH, py, offset=N)
      storeN(xa, py, offset=offsetDbl)
    ret(Void)


# The generic Fp functions of N units for the A_ slots that gen.py does not
# have yet (mcl_fp_add{NF}{N}L, mcl_fp_mont{NF}{N}L, mcl_fp_montRed{NF}{N}L
# and mcl_fpDbl_{add,sub}{N}L serve fp_addA_, fp_mulA_, fpDbl_modA_, ...):
#   mcl_fp_neg{N}L(y, x, p) and, for isFullBit in (True, False) with the
#   suffix '_' / 'NF' (mul2) or '' / 'NF' (sqr), mcl_fp_mul2_{N}L /
#   mcl_fp_mul2NF{N}L(y, x, p) = add(y, x, x, p) and mcl_fp_sqr{N}L /
#   mcl_fp_sqrNF{N}L(y, x, p) = mont(y, x, x, p).
# addF[isFullBit] / montF[isFullBit] : the Functions of mcl_fp_add{NF}{N}L / mcl_fp_mont{NF}{N}L
# The list of the functions is also in src/gen_llvm_proto.py (prototypes and
# the registration to Op); update both.
def gen_generic_fp(unit, N, addF, montF):
  gen_fp_neg(f'mcl_fp_neg{N}L', FieldShape(unit, N, False, False))
  for isFullBit in (True, False):
    fs = FieldShape(unit, N, isFullBit, False)
    nf = '' if isFullBit else 'NF'
    gen_mul2(f'mcl_fp_mul2{"_" if isFullBit else "NF"}{N}L', fs, addF[isFullBit])
    gen_fp_sqr(f'mcl_fp_sqr{nf}{N}L', fs, montF[isFullBit])


# The generic Fp2 functions of an N-unit p that is not full bit and p < R/4
# (nocarry) for Fp2 = Fp[i]/(i^2 + u) with xi = xi_a + i and sizeof(Fp) =
# offset units (MCL_FP_BIT / unit, the position of the second component):
#   mcl_fp2_mulUnit{N}L, mcl_fp2_mulPre{N}L (private; Op keeps fpDbl_mulPre = mclb_mul{N}),
#   mcl_fp2_{add,sub,neg}{N}L, mcl_fp2_mul2_{N}L (independent of u / xi_a),
#   mcl_fp2_{mul,sqr}_u{u}_{N}L, mcl_fp2Dbl_{mulPre,sqrPre}_u{u}_{N}L (per u),
#   mcl_fp2_mul_xi_u{u}x{xi_a}_{N}L, mcl_fp2Dbl_mul_xi_u{u}x{xi_a}_{N}L (per (u, xi_a))
# for the (u, xi_a) of params (a list of pairs, e.g. those of primetbl.py).
# montF / montRedF : the Functions of mcl_fp_montNF{N}L / mcl_fp_montRedNF{N}L.
# mulPos / extractHigh are the module-wide helpers of gen.py (gen_once).
# alwaysinline of mulUnit: for N >= 8 clang stops inlining it into mulPre and
# the 2N call round-trips cost ~1.7x in throughput (mcl-ff memo.md 2026-08-31).
# The list of the functions is also in src/gen_llvm_proto.py (prototypes and
# the registration to Op); update both.
def gen_generic_fp2(unit, N, offset, params, montF, montRedF, mulPos, extractHigh):
  fs = FieldShape(unit, N, False, True)
  assert offset >= N
  suf = f'{N}L'
  mulUnit = gen_mulPv(f'mcl_fp2_mulUnit{suf}', unit, N, mulPos, extractHigh, private=True, alwaysinline=True)
  mulPreF = gen_fpDbl_mulPre(f'mcl_fp2_mulPre{suf}', fs, mulUnit)
  add2F = gen_fp2_add(f'mcl_fp2_add{suf}', fs, offset)
  gen_fp2_sub(f'mcl_fp2_sub{suf}', fs, offset)
  gen_fp2_neg(f'mcl_fp2_neg{suf}', fs, offset)
  gen_mul2(f'mcl_fp2_mul2_{suf}', fs, add2F)
  offsetDbl = offset * 2 # sizeof(FpDbl) = 2 sizeof(Fp)
  for u in sorted({u for (u, _) in params}):
    gen_fp2_mul(f'mcl_fp2_mul_u{u}_{suf}', fs, mulPreF, montRedF, offset, u=u)
    gen_fp2_sqr(f'mcl_fp2_sqr_u{u}_{suf}', fs, montF, offset, u=u)
    gen_fp2Dbl_mulPre(f'mcl_fp2Dbl_mulPre_u{u}_{suf}', fs, mulPreF, offset, offsetDbl, u=u)
    gen_fp2Dbl_sqrPre(f'mcl_fp2Dbl_sqrPre_u{u}_{suf}', fs, mulPreF, offset, offsetDbl, u=u)
  for (u, xi_a) in sorted(params):
    gen_fp2_mul_xi(f'mcl_fp2_mul_xi_u{u}x{xi_a}_{suf}', fs, offset, u, xi_a)
    gen_fp2Dbl_mul_xi(f'mcl_fp2Dbl_mul_xi_u{u}x{xi_a}_{suf}', fs, offsetDbl, u, xi_a)
