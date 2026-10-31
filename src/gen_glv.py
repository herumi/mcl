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

# z, b of y^2 = x^3 + b, isBLS12 : the same values as include/mcl/curve_type.hpp
glvCurves = [
  ('BN254', -0x4080000000000001, 2, False),
  ('BN-SNARK', 4965661367192848881, 3, False),
  ('BLS12-381', -0xd201000000010000, 4, True),
  ('BLS12-377', 0x8508c00000000001, 1, True),
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

def makeParam(name, z, b, isBLS12):
  cv = curveTbl[name]
  p, r = cv.p, cv.r
  prm = Param()
  prm.name = name
  prm.curveType = cv.c
  prm.isBLS12 = isBLS12
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
    assert p == 36 * z**4 + 36 * z**3 + 24 * z**2 + 6 * z + 1
    assert r == 36 * z**4 + 36 * z**3 + 18 * z**2 + 6 * z + 1
    # (6z^2+2z) - (2z+1) L = 0, (-2z-1) - (6z^2+4z+1) L = 0 (see GLV1T::init)
    B = [[6 * z * z + 2 * z, -2 * z - 1], [-2 * z - 1, -6 * z * z - 4 * z - 1]]
    lam = B[0][0] * pow(-B[0][1], -1, r) % r
    s = 256
    v0 = ((-B[1][1]) << s) // r
    v1 = (B[1][0] << s) // r
    cofactor = 1
  assert (lam * lam + lam + 1) % r == 0
  for i in range(2):
    assert (B[i][0] + B[i][1] * lam) % r == 0
  # the fixed-width split uses v1 >= 0 : negate the second row if v1 < 0
  if v1 < 0:
    v1 = -v1
    B[1] = [-B[1][0], -B[1][1]]
  assert v0 >= 0
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
  else:
    t = (x * prm.v0) >> prm.s
  b0 = (x * prm.v1) >> prm.s
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
    assert 2 * (abs(B[0][0]) + abs(B[1][0])) < H, prm.name
    assert 2 * (abs(B[0][1]) + abs(B[1][1])) < H, prm.name
    # the intermediate values fit in 256-bit two's complement
    tMax = ((r - 1) * prm.v0) >> prm.s
    b0Max = ((r - 1) * prm.v1) >> prm.s
    assert tMax < H and b0Max < H, prm.name
    assert r + tMax * abs(B[0][0]) + b0Max * abs(B[1][0]) < (1 << 255), prm.name
    assert tMax * abs(B[0][1]) + b0Max * abs(B[1][1]) < (1 << 255), prm.name
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
  print(f'\t\t{prm.curveType}, "{prm.rw:x}",')
  print(f'\t\t{hexArray(toArray(prm.v0, 3))},')
  print(f'\t\t{hexArray(toArray(prm.v1, 2))},')
  print('\t\t{')
  for i in range(2):
    print(f'\t\t\t{{ {hexArray(toArray(abs(B[i][0]), 2))}, {hexArray(toArray(abs(B[i][1]), 2))} }},')
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
	BN (GLV1T::splitRawTbl) : t = (x v0) >> 256, b0 = (x v1) >> 256
	a = x - (t B00 + b0 B10), b = -(t B01 + b0 B11)
	B[i][j] is the absolute value and the bit (i * 2 + j) of Bneg is set if B[i][j] < 0
	|a|, |b| < 2^128 for all x in [0, r)
*/
struct GLV1ParamBN {
	int curveType;
	const char *rw; // hex
	uint64_t v0[3];
	uint64_t v1[2];
	uint64_t B[2][2][2];
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
