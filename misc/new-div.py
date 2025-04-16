
'''
input : integer l, odd p, 0 <= x < 2^l
output : x//p

Theorem
N = 2**l
u=N // p
r0=N % p # => N = u p + r0.
s = (N//(p-r0)).bit_length() # => 2^s > N / (p-r0) => r0 + N/2^s < p.
d=max(xH)/2^s

for 0 <= x < 2^l
xH=x>>(l-s)
q=(xH * u)>>s
then 0 <= (x//p) - q < 1.

Proof.
x/p = (x/2^l)(2^l/p) >= (xH 2**(l-s)/2^l) u = (xH u) / 2^s >= (xH u)>>s = q.
xL = x % 2^(l-s), then x = xH 2^(l-s) + xL. 0 <= xL < 2^(l-s).
X = 2^s x - p xH u = 2^s(xH 2^(l-s) + xL) - xH (N - r0)
  = 2^s xL + r0 xH.
x/p - (xH q)/2^s = X/(2^s p) = xL/p + r0/p (xH/2^s) < (xL + d r0)/p < (2^(l-s)+d r0)/p < 1.
'''

# Modified Barret reduction.
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
    self.s = (N // (p - (r0 * M) // N)).bit_length()
    self.ls = self.l - self.s
    assert(N + r0 * self.M / 2**(self.ls) <= 2**self.s * p)

  def divmod(self, x):
    '''
    x : integer to be divided.
    '''
    if x > self.M:
      raise ValueError(x, self.M)
    assert(0 <= x <= self.M)
    xH = x >> self.ls
    q = (xH * self.u) >> self.s
    q += 1
    r = x - q * self.p
    if r < 0:
      r += self.p
      q -= 1
    return (q, r)

  def put(self):
    '''
    Show parameters.
    '''
    print(f'p={hex(self.p)}')
    print(f'M={hex(self.M)}')
    print(f'l={self.l} s={self.s}, ls={self.ls}')
    print(f'u={hex(self.u)} length={self.u.bit_length()}')

  def check(self, x):
#    print('check', hex(x))
    (q, r) = self.divmod(x)
    (q0, r0) = divmod(x, self.p)
    if q != q0 or r != r0:
      raise Exception('check', x, q, r, q0, r0)
    assert(q == q0)
    assert(r == r0)



def main():
  for p in [
    0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f,
    0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d,
    0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001,
    0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001,
    0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001,
    0x240026400f3d82b2e42de125b00158405b710818ac000007e0042f008e3e00000000001080046200000000000000000d,
    0x2523648240000001ba344d80000000086121000000000013a700000000000013,
    0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47,
    0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab,
    0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001,
    0x240026400f3d82b2e42de125b00158405b710818ac00000840046200950400000000001380052e000000000000000013,
  ]:
    modp = Mod(p)
    modp.put()
    for x in [p-1, p, p+1, p*2-1, p*100-1, modp.M - p, modp.M]:
      modp.check(x)

  for L in [0xac45a4010001a40200000000ffffffff, 0x452217cc900000010a11800000000000]:
    p = L * L + L + 1
    modp = Mod(L, p-1)
    modp.put()
    for x in [L-1, L, L+1, L*2-1, L*2, L*2+1, L*100-1, L*L-1, L*L, L*L+L-1, p-1]:
      modp.check(x)

if __name__ == '__main__':
  main()
