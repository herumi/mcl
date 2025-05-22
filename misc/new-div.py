import math

'''
input : integer l, odd p, 0 <= x < 2^l
output : x//p

Theorem
N = 2**l
u=N // p
r0=N % p # => N = u p + r0.
s = (N//(p-r0)).bit_length() # => 2^s > N / (p-r0) => r0 + N/2^s = r0 + 2^(l-s) < p.
take s such that N + (M//2^d) r0 < 2^s p.

for 0 <= x < 2^l
xH=x>>(l-s)
q=(xH * u)>>s
then 0 <= (x//p) - q <= 1.

Proof.
x/p = (x/2^l)(2^l/p) >= (xH 2**(l-s)/2^l) u = (xH u) / 2^s >= (xH u)>>s = q.
xL = x % 2^(l-s), then x = xH 2^(l-s) + xL. 0 <= xL < 2^(l-s), xH < 2^s.
X = 2^s x - p xH u = 2^s(xH 2^(l-s) + xL) - xH (N - r0)
  = 2^s xL + r0 xH < 2^s 2^(l-s) + r0 (M//2^{l-s}) = N + r0 M//(N//2^s) = N + (r0 M 2^s) // N < 2^s p.
X/(2^s p) = x/p - (xH u)/2^s = X/(2^s p) = xL/p + r0/p (xH/2^s) < 1
'''

# Modified Barrett reduction.

def newparam(M, p):
  ret = []
  ds={}
  nMax = 1000
  sMax = 1000
  for n in range(p.bit_length(), 700):
    N = 2**n
    u = N // p
    r0 = N % p
    for d in range(n-1, -1, -1):
      s = n-d
      if N + (M>>d) * r0 < (p<<s):
        if d in ds and s >= ds[d]:
          continue
        ds[d] = s
        if n < nMax and s < sMax:
          nMax = n
          sMax = s
        if n > nMax and s > sMax:
          continue
        ret.append((n, d, s, u))
        print(f'{n=} {d=} {s=} {hex(u)=}')
        break
  return ret

# argmin(2**l + r0 * (M//(2**(l-s))) < 2**s * p)
def find_s(l, M, r0, p):
#  return (2**l//(p-r0 * M//2**l)).bit_length()
  for s in range(l):
    if 2**l + r0 * (M // 2**(l-s)) < 2**s * p:
      return s
  else:
    raise Exception('not found', l, M, r0, p)

class Mod():
  def __init__(self, p, M=2**512-1):
    '''
    p : modulus
    M : maximum value of x.
    '''
    self.p = p
    self.M = M
    self.l = M.bit_length()
    N = 2**self.l
    self.u = N // p
    r0 = N % p
    self.s = find_s(self.l, M, r0, p)
    self.d = self.l - self.s
    assert(2**self.d + r0 * (self.M // N) < p)
    ret = newparam(M, p)
    return
    if ret:
      (n, d, s, u) = ret
      self.u = u
      self.s = s
      self.d = d

  def divmod(self, x):
    '''
    x : integer to be divided.
    '''
    if x > self.M:
      raise ValueError(x, self.M)
    assert(0 <= x <= self.M)
    xH = x >> self.d # len(xH) = s
    q = (xH * self.u) >> self.s
    q += 1
    r = x - q * self.p
    if r < 0:
      r += self.p
      q -= 1
    return (q, r)

  def put(self, msg=None):
    '''
    Show parameters.
    '''
    if msg:
      print(f'{msg} ', end='')
    a = (self.M>>self.d).bit_length()
    if a != self.s:
      print(f'DIFF {a=} {self.s=}')
    print(f'p.len={self.p.bit_length()} l={self.l} d={self.d} u.len={self.u.bit_length()} xH.len=s={self.s}')
    print(f'p={hex(self.p)}')
    print(f'M={hex(self.M)}')
    print(f'u={hex(self.u)}')
    print()

  def check(self, x):
#    print('check', hex(x))
    (q, r) = self.divmod(x)
    (q0, r0) = divmod(x, self.p)
    if q != q0 or r != r0:
      raise Exception('check', x, q, r, q0, r0)
    assert(q == q0)
    assert(r == r0)



def main():
  for (p, name) in [
    (0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f, 'secp256k1'),
    (0x10000000000000000000000000000000000000000000000000000000000000129, 'p1'),
    (0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d, 'BN254-r'),
    (0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001, 'BN_SNARK1-r'),
    (0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001, 'BLS12_381-r'),
    (0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001, 'BLS12_377-r'),
    (0x240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d, 'BN381-r'),
    (0x2523648240000001ba344d80000000086121000000000013a700000000000013, 'BN254-p'),
    (0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47, 'BN_SNARK1-p'),
    (0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab, 'BLS12_381-p'),
    (0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001, 'BLS12_377-p'),
    (0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013, 'BN381-p'),
  ]:
    modp = Mod(p)
    modp.put(name)
    for x in [p-1, p, p+1, p*2-1, p*100-1, modp.M - p, modp.M]:
      modp.check(x)

  for (L, name) in [
    (0xac45a4010001a40200000000ffffffff, 'BLS12-381-L'),
    (0x452217cc900000010a11800000000000, 'BLS12-377-L'),
  ]:
    p = L * L + L + 1
    modp = Mod(L, p-1)
    modp.put(name)
    for x in [L-1, L, L+1, L*2-1, L*2, L*2+1, L*100-1, L*L-1, L*L, L*L+L-1, p-1]:
      modp.check(x)

if __name__ == '__main__':
  main()
