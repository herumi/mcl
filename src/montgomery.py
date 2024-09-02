class BLS12:
  def __init__(self, z=-0xd201000000010000):
    self.M = 1<<256
    self.H = 1<<128
    self.z = z
    self.L = self.z**2 - 1
    self.r = self.L*(self.L+1) + 1
    self.p = (z-1)**2*self.r//3 + z

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
  def __init__(self, p, W=52):
    N = (p.bit_length() + W-1)//W
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
  def montOrg(self, x, y):
    W = self.W
    MASK = 2**W - 1
    t = 0
    for i in range(self.N):
      t += x * ((y >> (W * i)) & MASK)
      q = ((t & MASK) * self.rp) & MASK
      t += q * self.p
      t >>= W
    if t >= self.p:
      print(f'over {x=} {y=} {t=} {self.p-x=} {self.p-y=}')
      t -= self.p
    return t
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

  def toArray(self, x):
    mask = getMask(self.W)
    a=[]
    for i in range(self.N):
      a.append(x & self.mask)
      x >>= self.W
    return a

def main():
  curve = BLS12()
  p = curve.p
  mont = Montgomery(p)
  mont.put()
  x = p-5
  for j in range(1, 100):
    print(f'{j=}')
    x = p-j
    for i in range(1, 1000000):
      y = p-i
      mont.montOrg(x, y)



  tbl = [0, 1, 2, 3, 4, p-6, p-5, p-4, p-3, p-2, p-1]
  for x in tbl:
    for y in tbl:
      a = mont.mont(x, y)
      b = mont.montOrg(x, y)
      if a != b:
        print(f'{x=} {y=} {a=} {b=} {p-x=} {p-y=}')

if __name__ == '__main__':
  main()
