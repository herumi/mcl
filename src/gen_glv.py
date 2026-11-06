# Generate src/glv_param.hpp : the precomputed parameters of the GLV method for G1
# (used by GLV1T::init and GLV1T::splitRaw in src/glv.hpp).
#   python3 src/gen_glv.py > src/glv_param.hpp
# The parameters are verified here (rw matches lambda on a point of G1,
# the split is exact and |a|, |b| < 2^128 for all x in [0, r)),
# so the C++ code only asserts.
# Author : MITSUNARI Shigeo(@herumi)
# License : modified new BSD license http://opensource.org/licenses/BSD-3-Clause
import sys
import random
from primetbl import curveTbl

# (name, kind, z, b of y^2 = x^3 + b) : the same values as include/mcl/curve_type.hpp
# kind : 'BN' / 'BLS12' (the basis from z) or 'generic' (a cube root of unity mod r and the basis by the extended Euclidean algorithm)
glvCurves = [
  ('BN254', 'BN', -0x4080000000000001, 2),
  ('BN-SNARK', 'BN', 4965661367192848881, 3),
  ('BLS12-381', 'BLS12', -0xd201000000010000, 4),
  ('BLS12-377', 'BLS12', 0x8508c00000000001, 1),
  ('secp256k1', 'generic', None, 7),
  ('Grumpkin', 'generic', None, -17),
]

def sqrtMod(a, p):
  # Tonelli-Shanks, return None if a is not a square
  a %= p
  if a == 0:
    return 0
  if pow(a, (p - 1) // 2, p) != 1:
    return None
  if p % 4 == 3:
    return pow(a, (p + 1) // 4, p)
  q, s = p - 1, 0
  while q % 2 == 0:
    q //= 2
    s += 1
  z = 2
  while pow(z, (p - 1) // 2, p) != p - 1:
    z += 1
  m, c, t, r = s, pow(z, q, p), pow(a, q, p), pow(a, (q + 1) // 2, p)
  while t != 1:
    i, t2 = 0, t
    while t2 != 1:
      t2 = t2 * t2 % p
      i += 1
    b = pow(c, 1 << (m - i - 1), p)
    m, c, t, r = i, b * b % p, t * b * b % p, r * b % p
  return r

# affine arithmetic on y^2 = x^3 + b over Fp (None is the zero point)
class Ec:
  def __init__(self, p, b):
    self.p = p
    self.b = b
  def add(self, P, Q):
    p = self.p
    if P is None:
      return Q
    if Q is None:
      return P
    (x1, y1), (x2, y2) = P, Q
    if x1 == x2:
      if (y1 + y2) % p == 0:
        return None
      l = 3 * x1 * x1 * pow(2 * y1, -1, p) % p
    else:
      l = (y2 - y1) * pow(x2 - x1, -1, p) % p
    x3 = (l * l - x1 - x2) % p
    y3 = (l * (x1 - x3) - y1) % p
    return (x3, y3)
  def mul(self, P, n):
    R = None
    for i in reversed(range(n.bit_length())):
      R = self.add(R, R)
      if (n >> i) & 1:
        R = self.add(R, P)
    return R
  def findPoint(self):
    for x in range(1, 1000):
      y = sqrtMod(x**3 + self.b, self.p)
      if y is not None:
        return (x, y)
    raise Exception('no point')

def toArray(x, n):
  # little endian uint64_t array of size n
  assert 0 <= x < (1 << (64 * n)), f'{hex(x)} does not fit in {n} words'
  return [(x >> (64 * i)) & ((1 << 64) - 1) for i in range(n)]

def hexArray(v):
  return '{ ' + ', '.join(f'0x{e:016x}' for e in v) + ' }'

class Param:
  pass

def glvBasis(r, lam):
  # a basis of the lattice { (a, b) : a + b lam = 0 mod r } with short vectors
  # by the extended Euclidean algorithm (Hankerson-Menezes-Vanstone, Algorithm 3.74)
  # r_i = s_i r + t_i lam, so (r_i, -t_i) is in the lattice
  rs = [r, lam]
  ts = [0, 1]
  while rs[-1] != 0:
    q = rs[-2] // rs[-1]
    rs.append(rs[-2] - q * rs[-1])
    ts.append(ts[-2] - q * ts[-1])
  l = max(i for i in range(len(rs)) if rs[i] * rs[i] >= r)
  v1 = (rs[l + 1], -ts[l + 1])
  v2a = (rs[l], -ts[l])
  v2b = (rs[l + 2], -ts[l + 2])
  v2 = v2a if v2a[0]**2 + v2a[1]**2 <= v2b[0]**2 + v2b[1]**2 else v2b
  return [list(v1), list(v2)]

def makeParam(name, kind, z, b):
  cv = curveTbl[name]
  p, r = cv.p, cv.r
  prm = Param()
  prm.name = name
  prm.curveType = cv.c
  prm.isBLS12 = kind == 'BLS12'
  isBLS12 = prm.isBLS12
  if isBLS12:
    assert r == z**4 - z**2 + 1
    assert p == (z - 1)**2 * r // 3 + z
    L = z * z - 1
    lam = L % r
    # x = a + b L : B = [[L, -1], [0, 0]], v1 = 0
    # t = b = ((x >> (s - 128)) v0) >> 128 with v0 = floor(2^s / L) (see GLV1T::splitRawBLS12)
    B = [[L, -1], [0, 0]]
    s = r.bit_length()
    v0 = (1 << s) // L
    v1 = 0
    cofactor = (z - 1)**2 // 3
  else:
    if kind == 'BN':
      assert p == 36 * z**4 + 36 * z**3 + 24 * z**2 + 6 * z + 1
      assert r == 36 * z**4 + 36 * z**3 + 18 * z**2 + 6 * z + 1
      # (6z^2+2z) - (2z+1) L = 0, (-2z-1) - (6z^2+4z+1) L = 0 (see GLV1T::init)
      B = [[6 * z * z + 2 * z, -2 * z - 1], [-2 * z - 1, -6 * z * z - 4 * z - 1]]
      lam = B[0][0] * pow(-B[0][1], -1, r) % r
    else:
      # lam = a primitive cube root of unity mod r, B by the extended Euclidean algorithm
      # the two roots lam, lam^2 give different lattices : take the one with c0, c1 < 2^128 (see below)
      assert (r - 1) % 3 == 0
      g = 2
      while True:
        lam = pow(g, (r - 1) // 3, r)
        if lam != 1:
          break
        g += 1
      for lam in [lam, lam * lam % r]:
        B = glvBasis(r, lam)
        det = B[0][0] * B[1][1] - B[0][1] * B[1][0]
        sgn = 1 if det > 0 else -1
        if abs(B[1][1]) < (1 << 128) and abs(B[0][1]) < (1 << 128):
          break
      else:
        raise Exception(f'{name}: no basis with c0, c1 < 2^128')
    det = B[0][0] * B[1][1] - B[0][1] * B[1][0]
    assert abs(det) == r
    # (t, b0) = x (1, 0) B^{-1} = x (B11, -B01) / det : t = (x c0) / r, b0 = (x c1) / r
    sgn = 1 if det > 0 else -1
    c0, c1 = B[1][1] * sgn, -B[0][1] * sgn
    # the fixed-width split uses c0, c1 >= 0 : negating row 0 flips both c0 and c1, negating row 1 flips c1
    if c0 < 0:
      B[0] = [-B[0][0], -B[0][1]]
      c0, c1 = -c0, -c1
    if c1 < 0:
      B[1] = [-B[1][0], -B[1][1]]
      c1 = -c1
    assert abs(B[0][0] * B[1][1] - B[0][1] * B[1][0]) == r
    # t = (x v0 + 2^(s-1)) >> s with v0 = floor(c0 2^s / r) : s = 256 + 64 (the error of the rounding < 2^-64, aligned to the Unit)
    s = 256 + 64
    v0 = (c0 << s) // r
    v1 = (c1 << s) // r
    cofactor = 1
  assert (lam * lam + lam + 1) % r == 0
  for i in range(2):
    assert (B[i][0] + B[i][1] * lam) % r == 0
  assert v0 >= 0 and v1 >= 0
  # rw : (x, y) -> (rw x, y) is the multiplication by lam on G1
  ec = Ec(p, b)
  P = ec.mul(ec.findPoint(), cofactor)
  assert P is not None and ec.mul(P, r) is None
  Q = ec.mul(P, lam)
  sq = sqrtMod(-3, p)
  rw = None
  for sgn in [sq, p - sq]:
    w = (-1 - sgn) * pow(2, -1, p) % p
    if (w * P[0] % p, P[1]) == Q:
      rw = w
  assert rw is not None
  assert (rw * rw + rw + 1) % p == 0
  prm.rw = rw
  prm.s = s
  prm.v0, prm.v1, prm.B, prm.lam, prm.r = v0, v1, B, lam, r
  return prm

def split(prm, x):
  # the same formula as GLV1T::splitRawTbl (BN) / GLV1T::splitRawBLS12 (BLS12)
  if prm.isBLS12:
    t = ((x >> (prm.s - 128)) * prm.v0) >> 128
    b0 = 0
  else:
    half = 1 << (prm.s - 1)
    t = (x * prm.v0 + half) >> prm.s
    b0 = (x * prm.v1 + half) >> prm.s
  B = prm.B
  a = x - (t * B[0][0] + b0 * B[1][0])
  b = -(t * B[0][1] + b0 * B[1][1])
  if prm.isBLS12:
    # a >= 0 (v0 <= 2^s / L) and a < 2L (verified in verify()), so one correction suffices
    assert 0 <= a < 2 * B[0][0]
    if a >= B[0][0]:
      a -= B[0][0]
      b += 1
  return (a, b)

def verify(prm):
  r = prm.r
  H = 1 << 128
  # rigorous bounds : t and b0 are within 2 of the exact solution, so
  # |a| <= 2 (|B00| + |B10|), |b| <= 2 (|B01| + |B11|)
  B = prm.B
  if prm.isBLS12:
    # xH = x >> (s - 128) < 2^128, b = floor(xH v0 / 2^128) <= x / L, so a = x - bL >= 0
    # a <= xH (2^s - v0 L) / 2^128 + xL + L (1 - 1 / 2^128) with xL < 2^(s - 128)
    # must be < 2L for one correction, and b + 1 <= x / L + 1 < 2^128
    L, s, v0 = B[0][0], prm.s, prm.v0
    assert L < H and 2**(s - 1) <= r < 2**s, prm.name
    xHmax = (r - 1) >> (s - 128)
    assert xHmax < H, prm.name
    aMax = xHmax * ((1 << s) - v0 * L) + ((1 << (s - 128)) - 1) * H + L * H - L # a 2^128 <= aMax
    assert aMax < 2 * L * H, prm.name
    assert r // L + 2 < H, prm.name
  else:
    # t = t* - e0, b0 = b0* - e1 with the exact t* = x c0 / r, b0* = x c1 / r and the errors
    # e0, e1 in [-1/2, 1/2 + d), d = (r - 1) / 2^s, so a = e0 B00 + e1 B10, b = -(e0 B01 + e1 B11)
    # (the computation is mod 2^256 and only the final a, b must fit in 255-bit two's complement)
    s = prm.s
    assert r < (1 << (s - 64)), prm.name
    assert prm.v0 < (1 << 256) and prm.v1 < (1 << 256), prm.name
    # |B| < 2^(128 + 32) : the top (bits >= 128) of B is one Unit (see GLV1T::splitRawTbl)
    for i in range(2):
      for j in range(2):
        assert abs(B[i][j]) < (1 << 160), prm.name
    e = (1 << (s - 1)) + r - 1 # 2^s (1/2 + d)
    assert (abs(B[0][0]) + abs(B[1][0])) * e < (H << s), prm.name
    assert (abs(B[0][1]) + abs(B[1][1])) * e < (H << s), prm.name
    # t <= t* + 1/2 < c0 + 1/2, so t, b0 < 2^128
    tMax = (((r - 1) * prm.v0 + (1 << (s - 1))) >> s)
    b0Max = (((r - 1) * prm.v1 + (1 << (s - 1))) >> s)
    assert tMax < H and b0Max < H, prm.name
  xs = [0, 1, 2, r - 1, r - 2] + [1 << k for k in range(1, 254)] + [(r - 1) >> k for k in range(1, 254)]
  rng = random.Random(1)
  xs += [rng.randrange(r) for _ in range(100000)]
  for x in xs:
    if x >= r:
      continue
    (a, b) = split(prm, x)
    assert (a + b * prm.lam - x) % r == 0, (prm.name, hex(x))
    if prm.isBLS12:
      assert 0 <= a < B[0][0] and 0 <= b, (prm.name, hex(x))
    assert abs(a) < H and abs(b) < H, (prm.name, hex(x))

def putParamBN(prm):
  B = prm.B
  neg = 0
  for i in range(2):
    for j in range(2):
      if B[i][j] < 0:
        neg |= 1 << (i * 2 + j)
  print('\t{')
  print(f'\t\t// {prm.name}')
  print(f'\t\t{prm.curveType}, "{prm.rw:x}", {prm.s},')
  print(f'\t\t{hexArray(toArray(prm.v0, 4))},')
  print(f'\t\t{hexArray(toArray(prm.v1, 4))},')
  print('\t\t{')
  for i in range(2):
    print(f'\t\t\t{{ {hexArray(toArray(abs(B[i][0]), 3))}, {hexArray(toArray(abs(B[i][1]), 3))} }},')
  print('\t\t},')
  print(f'\t\t{neg},')
  print('\t},')

def putParamBLS12(prm):
  print('\t{')
  print(f'\t\t// {prm.name}')
  print(f'\t\t{prm.curveType}, "{prm.rw:x}", {prm.s},')
  print(f'\t\t{hexArray(toArray(prm.B[0][0], 2))},')
  print(f'\t\t{hexArray(toArray(prm.v0, 2))},')
  print('\t},')

def main():
  prms = [makeParam(*e) for e in glvCurves]
  for prm in prms:
    verify(prm)
  print('''// generated by src/gen_glv.py (do not edit)
/*
	the parameters of the GLV method for G1 : x = a + b lambda mod r, (x, y) -> (rw x, y) = lambda (x, y)
	BN, secp256k1 (GLV1T::splitRawTbl) : t = (x v0 + 2^(shift-1)) >> shift, b0 = (x v1 + 2^(shift-1)) >> shift (rounding, shift = 256 + 64)
	a = x - (t B00 + b0 B10), b = -(t B01 + b0 B11) (mod 2^256)
	B[i][j] is the absolute value (< 2^160) and the bit (i * 2 + j) of Bneg is set if B[i][j] < 0
	|a|, |b| < 2^128 for all x in [0, r)
*/
struct GLV1ParamBN {
	int curveType;
	const char *rw; // hex
	uint32_t shift;
	uint64_t v0[4];
	uint64_t v1[4];
	uint64_t B[2][2][3];
	uint32_t Bneg;
};
static const GLV1ParamBN glv1ParamBNTbl[] = {''')
  for prm in prms:
    if not prm.isBLS12:
      putParamBN(prm)
  print('''};
/*
	BLS12 (GLV1T::splitRawBLS12) : L = z^2 - 1 (r = L^2 + L + 1), rBitSize = the bit size of r, q = floor(2^rBitSize / L)
	b = ((x >> (rBitSize - 128)) q) >> 128, a = x - bL
	0 <= a < 2L for all x in [0, r), so one correction (a -= L, b += 1 if a >= L) gives 0 <= a < L, 0 <= b <= L + 1
*/
struct GLV1ParamBLS12 {
	int curveType;
	const char *rw; // hex
	uint32_t rBitSize;
	uint64_t L[2];
	uint64_t q[2];
};
static const GLV1ParamBLS12 glv1ParamBLS12Tbl[] = {''')
  for prm in prms:
    if prm.isBLS12:
      putParamBLS12(prm)
  print('};')

if __name__ == '__main__':
  main()
