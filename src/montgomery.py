
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
