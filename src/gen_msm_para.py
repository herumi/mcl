g_W = 52 # use 52-bit integer multiplication
g_N = 8 # store 381-bit integer in 8 bytes N arrays

def getMontgomeryCoeff(pLow, W):
  pp = 0
  t = 0
  x = 1
  for i in range(W):
    if t % 2 == 0:
      t += pLow
      pp += x
    t >>= 1
    x <<= 1
  return pp

def getMask(w):
  return (1<<w)-1

# return w-bit array of size N
def toArray(x, W=g_W, N=g_N):
  mask = getMask(W)
  a=[]
  for i in range(N):
    a.append(x & mask)
    x >>= W
  return a

class Montgomery:
  def __init__(self, p, W=52, N=8):
    self.p = p
    self.W = W
    self.N = N
    self.M = 2**W
    self.mask = getMask(W)
    self.R = 2**(W*N) % p
    self.R2 = self.R**2 % p
    self.rp = getMontgomeryCoeff(p & self.mask, W)
    self.Z = pow(self.M, self.N, p)
    t = (p * self.rp + 1) // self.M
    self.iZ = pow(t, self.N, p)
  def mont(self, x, y):
    return (x * y * self.iZ) % self.p
  def toMont(self, x):
    return (x * self.Z) % self.p
  def fromMont(self, x):
    return (x * self.iZ) % self.p
  def put(self):
    print(f'''p={hex(self.p)}
W={self.W}
N={self.N}
mask={hex(self.mask)}
R={hex(self.R)}
R2={hex(self.R2)}
rp={hex(self.rp)}''')

class BLS12:
  def __init__(self, z=-0xd201000000010000):
    self.M = 1<<256
    self.H = 1<<128
    self.z = z
    self.L = self.z**2 - 1
    self.r = self.L*(self.L+1) + 1
    self.p = (z-1)**2*self.r//3 + z

def expand(name, v):
  if type(v) == int:
    s = f'{hex(v)}, '*8
  elif type(v) == list:
    s = ', '.join(map(hex, v)) + ' '
  print(f'static const CYBOZU_ALIGN(64) uint64_t {name}[] = {{ {s}}};')

def expandN(name, v):
  print(f'static const CYBOZU_ALIGN(64) uint64_t {name}[] = {{')
  for i in range(len(v)):
    print(('\t' + f'{hex(v[i])}, '*8).strip())
  print('};')

def expandN3(name, vx, vy, vz):
  print(f'static const CYBOZU_ALIGN(64) uint64_t {name}[] = {{')
  for i in range(len(vx)):
    print(('\t' + f'{hex(vx[i])}, '*8).strip())
  for i in range(len(vy)):
    print(('\t' + f'{hex(vy[i])}, '*8).strip())
  for i in range(len(vz)):
    print(('\t' + f'{hex(vz[i])}, '*8).strip())
  print('};')

def putCode(curve, mont):
  print('// generated by src/gen_msm_para.py')
  print(f'static const uint64_t g_mask = {hex(mont.mask)};')
  # for FpM
  expand("g_mask_", mont.mask)
  expand("g_rp_", mont.rp)
  expandN('g_ap_', toArray(curve.p)) # array of p
  expandN('g_R_', toArray(mont.R)) # FpM::one()
  expandN('g_R2_', toArray(mont.R2)) # FpM::R2()
  expandN('g_m64to52_', toArray(mont.toMont(2**32)))
  expandN('g_m52to64_', toArray(mont.toMont(pow(2**32, -1, curve.p))))
  expandN('g_zero_', toArray(0)) # FpM::zero()
  expandN('g_rawOne_', toArray(1)) # FpM::rawOne()
  expand('g_offset_', [0, 1, 2, 3, 4, 5, 6, 7, 8])
  p = curve.p
  rw = pow(-3, (p+1)//4, p)
  rw = p-(rw+1)//2
  if (rw*rw+rw+1)%p != 0:
    print(f'ERR rw {rw=}')
    return
  print(f'// rw={hex(rw)}')
  expandN('g_rw_', toArray(mont.toMont(rw)))
  # for EcM
  b = 4
  expandN('g_b3_', toArray(mont.toMont(b*3)))
  expandN3('g_zeroJacobi_', toArray(0), toArray(0), toArray(0))
  expandN3('g_zeroProj_', toArray(0), toArray(1), toArray(0))

  print(f'''
struct G {{
	static const Vec& mask() {{ return *(const Vec*)g_mask_; }}
	static const Vec& rp() {{ return *(const Vec*)g_rp_; }}
	static const Vec* ap() {{ return (const Vec*)g_ap_; }}
	static const Vec& offset() {{ return *(const Vec*)g_offset_; }}
}};
''')

def main():
  curve = BLS12()

  mont = Montgomery(curve.p)
  print('#if 0')
  mont.put()
  print('#endif')
  putCode(curve, mont)

if __name__ == '__main__':
  main()

