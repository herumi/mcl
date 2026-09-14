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
# Used by mcl_fpDbl_add{N}L / mcl_fpDbl_sub{N}L of gen.py (pp is an argument)
# and by the p-fixed functions of gen_fixed (pp points to the global p).
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
# p-fixed functions (moved from mcl-ff/src/gen_ff.py on 2026-09-14; the
# generators there call these).
# p is a global variable of the module ({pre}p) instead of a function
# argument, so the functions have the same ABI as the Xbyak-generated ones
# (fp_addA_ etc. of struct Op, no p argument) and are registered to the A_
# slots by fp.cpp (setLLVMFixedCode). The global is non-const and external so
# that LLVM does not fold p into immediates (that made the code slower).

# The Montgomery parameters of a prime p for the given unit size:
# N = the number of units, bit = N unit, ip = -p^-1 mod 2^unit,
# isFullBit = p uses the top bit of the top unit.
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


def gen_fixed_fp_add(name, mont, dataVar):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    pp = bitcast(dataVar, unit)
    # volatile: keep the operand loads unfused so store-forwarded inputs
    # (common in dependency chains) do not pay the folded-load latency.
    x = loadN(px, N, volatile=True)
    y = loadN(py, N, volatile=True)
    p = loadN(pp, N)
    x = emit_fp_add(unit, x, y, p, mont.isFullBit)
    storeN(x, pz)
    ret(Void)


# Fp2 add: both components (the second at offset units) with one load of p
def gen_fixed_fp2_add(name, mont, dataVar, offset):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    pp = bitcast(dataVar, unit)
    p = loadN(pp, N)
    for i in range(2):
      x = loadN(px, N, offset=i*offset, volatile=True)
      y = loadN(py, N, offset=i*offset, volatile=True)
      x = emit_fp_add(unit, x, y, p, mont.isFullBit)
      storeN(x, pz, offset=i*offset)
    ret(Void)


# Writable {zero, p} table for the sub reduction. Layout is
# [Npad x i64] zero, then p, padded to 2*Npad limbs (Npad = N rounded up to a
# power of two so the borrow-scaled offset is a single shift and each entry is
# cache-line aligned). It must be a non-constant global with external linkage:
# if the optimizer can prove the contents (constant, or internal + never
# stored), it folds the conditional +p back into an and-mask/cmov sequence.
def makeSubTbl(name, mont):
  unit = mont.unit
  N = mont.N
  Npad = 1 << (N - 1).bit_length()
  mask = (1 << unit) - 1
  limbs = [(mont.p >> (unit * i)) & mask for i in range(N)]
  v = [0] * Npad + limbs + [0] * (Npad - N)
  tbl = makeVar(name, unit, v, static=False, const=False, align=64)
  return (tbl, Npad)


# Reduction via the {zero, p} table indexed by the borrow. The variable-index
# GEP cannot be rewritten into a select of the loaded values (the table is
# writable memory), so the conditional +p lowers to an add/adc chain with
# folded memory operands: the same idiom as the hand-written x64 asm.
def gen_sub_raw_tbl(unit, x, y, ptbl, Npad, isFullBit):
  bit = x.bit
  v, c = emit_fp_sub_raw(unit, x, y, isFullBit)
  off = shl(zext(c, unit), Npad.bit_length() - 1)
  addr = getelementptr(ptbl, off)
  p = load(bitcast(addr, bit))
  v = add(v, p)
  return v


# Reduction via an and-mask: p is loaded from a fixed address known at
# function entry, so the load runs in parallel with the subtraction and only
# sext -> and -> add follow the borrow. The table variant instead derives the
# load address from the borrow, which puts the L1 load-use latency (~4 cycles)
# on the dependency chain when the borrow pattern defeats address prediction;
# on aarch64 this made sub latency 1.23x of mcl. On x64 the table still wins
# because it lowers to add/adc with folded memory operands. base{32,64}.ll
# is architecture independent and x64 uses Xbyak, so mcl uses this variant.
def gen_sub_raw_mask(unit, x, y, p, isFullBit):
  bit = x.bit
  v, c = emit_fp_sub_raw(unit, x, y, isFullBit)
  v = add(v, and_(p, sext(c, bit)))
  return v


# subTbl = (tbl, Npad) of makeSubTbl is used when useMask is False
def gen_fixed_fp_sub(name, mont, dataVar, useMask=True, subTbl=None):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    if useMask:
      p = loadN(bitcast(dataVar, unit), N)
    else:
      tbl, Npad = subTbl
      ptbl = bitcast(tbl, unit)
    x = loadN(px, N, volatile=True)
    y = loadN(py, N, volatile=True)
    if useMask:
      v = gen_sub_raw_mask(unit, x, y, p, mont.isFullBit)
    else:
      v = gen_sub_raw_tbl(unit, x, y, ptbl, Npad, mont.isFullBit)
    storeN(v, pz)
    ret(Void)


def gen_fixed_fp2_sub(name, mont, dataVar, offset, useMask=True, subTbl=None):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    if useMask:
      p = loadN(bitcast(dataVar, unit), N)
    else:
      tbl, Npad = subTbl
      ptbl = bitcast(tbl, unit)
    for i in range(2):
      x = loadN(px, N, offset=i*offset, volatile=True)
      y = loadN(py, N, offset=i*offset, volatile=True)
      if useMask:
        v = gen_sub_raw_mask(unit, x, y, p, mont.isFullBit)
      else:
        v = gen_sub_raw_tbl(unit, x, y, ptbl, Npad, mont.isFullBit)
      storeN(v, pz, offset=i*offset)
    ret(Void)


# y = -x mod p = (x == 0) ? 0 : p - x (the same as negT of fp.cpp and
# gen_fp_neg of fp_generator.hpp); the components at offset i*offset
def emit_fixed_neg(mont, py, px, p, offset, n):
  unit = mont.unit
  N = mont.N
  for i in range(n):
    x = loadN(px, N, offset=i*offset)
    c = icmp(eq, x, Imm(0, mont.bit))
    v = sub(p, x)
    v = select(c, x, v)
    storeN(v, py, offset=i*offset)


def gen_fixed_fp_neg(name, mont, dataVar):
  unit = mont.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, py, px, private=False):
    p = loadN(bitcast(dataVar, unit), mont.N)
    emit_fixed_neg(mont, py, px, p, 0, 1)
    ret(Void)


def gen_fixed_fp2_neg(name, mont, dataVar, offset):
  unit = mont.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, py, px, private=False):
    p = loadN(bitcast(dataVar, unit), mont.N)
    emit_fixed_neg(mont, py, px, p, offset, 2)
    ret(Void)


# y = 2x mod p (= add(x, x)); the components at offset i*offset
def emit_fixed_mul2(mont, py, px, p, offset, n):
  N = mont.N
  for i in range(n):
    x = loadN(px, N, offset=i*offset)
    v = emit_fp_add(mont.unit, x, x, p, mont.isFullBit)
    storeN(v, py, offset=i*offset)


def gen_fixed_fp_mul2(name, mont, dataVar):
  unit = mont.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, py, px, private=False):
    p = loadN(bitcast(dataVar, unit), mont.N)
    emit_fixed_mul2(mont, py, px, p, 0, 1)
    ret(Void)


def gen_fixed_fp2_mul2(name, mont, dataVar, offset):
  unit = mont.unit
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, py, px, private=False):
    p = loadN(bitcast(dataVar, unit), mont.N)
    emit_fixed_mul2(mont, py, px, p, offset, 2)
    ret(Void)


# Fp2 mul_xi for xi = 1 + i (xi_a == 1, u == 1 as BLS12-381):
# y = x xi = (a + b i)(1 + i) = (a - b) + (a + b) i
# Both components are loaded before the stores, so y may be x.
def gen_fixed_fp2_mul_xi(name, mont, dataVar, offset):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  py = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, py, px, private=False):
    p = loadN(bitcast(dataVar, unit), N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    ya = gen_sub_raw_mask(unit, a, b, p, mont.isFullBit)
    yb = emit_fp_add(unit, a, b, p, mont.isFullBit)
    storeN(ya, py)
    storeN(yb, py, offset=offset)
    ret(Void)


def gen_fixed_fpDbl_add(name, mont, dataVar):
  unit = mont.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    pp = bitcast(dataVar, unit)
    emit_fpDbl_add(unit, mont.N, pz, px, py, pp)
    ret(Void)


def gen_fixed_fpDbl_sub(name, mont, dataVar):
  unit = mont.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    pp = bitcast(dataVar, unit)
    emit_fpDbl_sub(unit, mont.N, pz, px, py, pp)
    ret(Void)


# Fused Montgomery mul: z = x y R^-1 mod p; the body is emit_mont (shared
# with mcl_fp_mont of gen.py). rp = -p^-1 mod 2^unit is loaded from the
# global rpVar (see gen_fixed) instead of being an immediate.
def gen_fixed_mul(name, mont, dataVar, rpVar, mulUnit):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False) as f:
    pp = bitcast(dataVar, unit)
    rp = load(bitcast(rpVar, unit))
    emit_mont(unit, N, pz, px, py, pp, rp, mulUnit, mont.isFullBit)
    ret(Void)
  return f


# Montgomery reduction: z = xy R^-1 mod p where xy has 2N units; the body is
# emit_montRed (shared with mcl_fp_montRed of gen.py). The high units
# are fetched from memory via the getHi callback.
def gen_fixed_mod(name, mont, dataVar, rpVar, mulUnit):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  pxy = IntPtr(unit)
  with Function(name, Void, pz, pxy, private=False) as f:
    pp = bitcast(dataVar, unit)
    rp = load(bitcast(rpVar, unit))
    lo = loadN(pxy, N)
    p = loadN(pp, N)
    z = emit_montRed(unit, N, lo, lambda i: load(getelementptr(pxy, N + i)), pp, p, rp, mulUnit, mont.isFullBit)
    storeN(z, pz)
    ret(Void)
  return f


# mulPre: pz[2N] = px[N] * py[N] (no reduction); the schoolbook body is
# emit_mulPre (shared with mclb_mul of gen_bint.py).
def gen_fixed_mulPre(name, mont, mulUnit):
  unit = mont.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False) as f:
    emit_mulPre(unit, mont.N, pz, px, py, mulUnit)
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


def gen_fixed_sqrPre(name, mont):
  unit = mont.unit
  N = mont.N
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, pz, px, private=False) as f:
    x = [load(getelementptr(px, i)) for i in range(N)]
    storeN(sqrPre_raw(unit, x, N), pz)
    ret(Void)
  return f


# sqr: z = x^2 R^-1 mod p as a call to mul(z, x, x). The fused variant
# (sqrPre_raw + emit_montRed in one function) needs fewer muls
# (N(N+1)/2 + N^2 + N = 63 vs 2N^2 + N = 78 for N=6) but loses to mul(x, x)
# on both Xeon w9-3495X and Apple M4 : sqrPre_raw keeps the whole 2N-limb
# product live when the serial reduction starts, which the register file
# cannot hold, and the saved muls are eaten by spills (mcl-ff memo.md 2026-07-27).
def gen_fixed_sqr(name, mont, mulF):
  unit = mont.unit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, pz, px, private=False) as f:
    call(mulF, pz, px, px)
    ret(Void)
  return f


# Fp2 mul: (z.a, z.b) = (a c - b d, a d + b c) where x = (a, b), y = (c, d),
# each component N limbs in Montgomery form, b at offset limbs from a.
# Same Karatsuba structure as gen_fp2_mul of fp_generator.hpp:
#   s = a + b, t = c + d (no carry out since p is not full bit)
#   d1 = s t, d0 = a c, d2 = b d (3 mulPre calls on alloca buffers)
#   d1 -= d0; d1 -= d2 (= a d + b c; no borrow since s t >= a c + b d)
#   d0 -= d2 (mod p 2^bit: on borrow, add p to the high half; the +p comes
#     from the writable {zero, p} table like gen_sub_raw_tbl, so it lowers
#     to an add chain with memory operands instead of a 2N-limb select)
#   z.a = mod(d0), z.b = mod(d1)
# Requires u == 1 (i^2 = -1) and p not full bit.
def gen_fixed_fp2_mul(name, mont, mulPreF, modF, subTbl, offset):
  unit = mont.unit
  N = mont.N
  bit = unit * N
  bit2 = bit * 2
  assert not mont.isFullBit
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  py = IntPtr(unit)
  with Function(name, Void, pz, px, py, private=False):
    tbl, Npad = subTbl
    ptbl = bitcast(tbl, unit)
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
    v = sub(d0, d2)
    # borrow flag: d0, d2 < p^2 < 2^(bit2-2), so the top bit is set iff
    # the sub wrapped around
    c = trunc(lshr(v, bit2 - 1), 1)
    off = shl(zext(c, unit), Npad.bit_length() - 1)
    addr = getelementptr(ptbl, off)
    pc = load(bitcast(addr, bit)) # p if borrow else 0
    hi = add(trunc(lshr(v, bit), bit), pc)
    storeN(trunc(v, bit), pd0)
    storeN(hi, pd0, offset=N)
    call(modF, pz, pd0)
    call(modF, getelementptr(pz, offset), pd1)
    ret(Void)


# Fp2 sqr: (z.a, z.b) = (a^2 - b^2, 2 a b) where x = (a, b), b at offset
# limbs from a. Same structure as gen_fp2_sqr of fp_generator.hpp: two
# calls of the fused Montgomery mul on alloca buffers, no sqrPre (both
# products are cross products, so squaring symmetry cannot be exploited):
#   t1 = 2b, z.b = mul(t1, a) = 2 a b R^(-1)
#   t2 = a + b, t3 = a + p - b (adding p unconditionally avoids a borrow
#     check; p (a + b) vanishes mod p)
#   z.a = mul(t2, t3) = (a^2 - b^2) R^(-1)
# The mul operands are < 2p, so the products are < 4p^2 < p R, which
# requires p < R/4 (mont.nocarry). sqr(x, x) works in place: when the first
# mul writes z.b it only reads x.a, which does not overlap x.b, and the
# second mul reads only the t2/t3 copies. Requires u == 1.
def gen_fixed_fp2_sqr(name, mont, mulF, dataVar, offset):
  unit = mont.unit
  N = mont.N
  assert not mont.isFullBit and mont.nocarry
  resetGlobalIdx()
  pz = IntPtr(unit)
  px = IntPtr(unit)
  with Function(name, Void, pz, px, private=False):
    pp = bitcast(dataVar, unit)
    pt1 = alloca_(unit, N)
    pt2 = alloca_(unit, N)
    pt3 = alloca_(unit, N)
    a = loadN(px, N)
    b = loadN(px, N, offset=offset)
    p = loadN(pp, N)
    storeN(add(b, b), pt1)
    storeN(add(a, b), pt2)
    storeN(sub(add(a, p), b), pt3)
    call(mulF, getelementptr(pz, offset), pt1, px)
    call(mulF, pz, pt2, pt3)
    ret(Void)


# Generate all the p-fixed functions of a prime p with the prefix pre
# (e.g. 'mcl_c5_fp_'): the globals {pre}p and {pre}rp (= -p^-1 mod 2^unit),
# {pre}mulUnit (private) and
#   {pre}add, {pre}sub, {pre}neg, {pre}mul2, {pre}mul, {pre}sqr,
#   {preDbl}mod, {preDbl}mulPre, {preDbl}sqrPre
# and if hasFp2 (the Fp of a pairing curve with Fp2 = Fp[i]/(i^2 + 1) and
# xi = 1 + i, sizeof(Fp) = offset units):
#   {pre}sub_tbl, {preDbl}add, {preDbl}sub,
#   {pre2}add, {pre2}sub, {pre2}neg, {pre2}mul2, {pre2}mul, {pre2}sqr, {pre2}mul_xi
# where preDbl = pre[:-1] + 'Dbl_' and pre2 = pre[:-1] + '2_'
# (mcl_c5_fpDbl_mod, mcl_c5_fp2_mul, ... : the names of the Op slots).
# mulPos / extractHigh are the module-wide helpers of gen.py (gen_once).
# The list of the functions is also in src/gen_llvm_proto.py (prototypes and
# the registration to Op); update both.
def gen_fixed(pre, unit, p, offset, hasFp2, mulPos, extractHigh):
  mont = Montgomery(p, unit)
  N = mont.N
  preDbl = pre[:-1] + 'Dbl_'
  pre2 = pre[:-1] + '2_'
  dataVar = makeVar(f'{pre}p', mont.bit, p, const=False, static=False)
  # rp is also a non-const global, not an immediate of mul/mod: LLVM
  # strength-reduces t * rp for rp = 0xfffffffeffffffff (BLS12-381 r) into
  # shl/add/neg, and that made the fixed mul 35% slower than mcl_fp_montNF4L
  # on x64 (Xeon w9-3495X); loaded from memory it is the same speed.
  rpVar = makeVar(f'{pre}rp', unit, mont.ip, const=False, static=False)
  # alwaysinline: for N >= 8 clang stops inlining mulUnit into mulPre and the
  # 2N call round-trips cost ~1.7x in throughput (mcl-ff memo.md 2026-08-31)
  mulUnit = gen_mulPv(f'{pre}mulUnit', unit, N, mulPos, extractHigh, private=True, alwaysinline=True)
  gen_fixed_fp_add(f'{pre}add', mont, dataVar)
  gen_fixed_fp_sub(f'{pre}sub', mont, dataVar)
  gen_fixed_fp_neg(f'{pre}neg', mont, dataVar)
  gen_fixed_fp_mul2(f'{pre}mul2', mont, dataVar)
  mulF = gen_fixed_mul(f'{pre}mul', mont, dataVar, rpVar, mulUnit)
  gen_fixed_sqr(f'{pre}sqr', mont, mulF)
  modF = gen_fixed_mod(f'{preDbl}mod', mont, dataVar, rpVar, mulUnit)
  mulPreF = gen_fixed_mulPre(f'{preDbl}mulPre', mont, mulUnit)
  gen_fixed_sqrPre(f'{preDbl}sqrPre', mont)
  if not hasFp2:
    return
  assert not mont.isFullBit and mont.nocarry
  subTbl = makeSubTbl(f'{pre}sub_tbl', mont)
  gen_fixed_fpDbl_add(f'{preDbl}add', mont, dataVar)
  gen_fixed_fpDbl_sub(f'{preDbl}sub', mont, dataVar)
  gen_fixed_fp2_add(f'{pre2}add', mont, dataVar, offset)
  gen_fixed_fp2_sub(f'{pre2}sub', mont, dataVar, offset)
  gen_fixed_fp2_neg(f'{pre2}neg', mont, dataVar, offset)
  gen_fixed_fp2_mul2(f'{pre2}mul2', mont, dataVar, offset)
  gen_fixed_fp2_mul(f'{pre2}mul', mont, mulPreF, modF, subTbl, offset)
  gen_fixed_fp2_sqr(f'{pre2}sqr', mont, mulF, dataVar, offset)
  gen_fixed_fp2_mul_xi(f'{pre2}mul_xi', mont, dataVar, offset)
