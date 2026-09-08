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
