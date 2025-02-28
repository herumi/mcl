m = 128 # fix
H = 1<<m

class SP:
  def __init__(self, z):
    L = z*z - 1
    r = L*L + L + 1
    m2 = L.bit_length() - 1
    s = m2 + m
    S = 1 << s
    q = S // L
    self.L = L
    self.r = r
    self.S = S
    self.q = q
    self.m2 = m2
    self.H2 = 2**m2
    print(f'{L.bit_length()=} {hex(L)=}')
    print(f'{r.bit_length()=} {hex(r)=}')
    print(f'{q.bit_length()=} {hex(q)=}')
    print(f'S=2**{S.bit_length()-1}')
    print(f'{m2=}')
    assert(q.bit_length() == m)
    assert(S == H * self.H2)
    r0 = S % L
    print(f'(r-1)r0 / S ~ {(r-1)*r0/S/L:0.4f} L')
    print(f'H2 ~ {self.H2/L:0.4f} L')
    print(f'(r-1)r0 / S + H2 + L = {(r-1)*r0/S/L + self.H2/L + 1:0.3f} L')

  def split(self, x):
    # xH = x // self.H2
    xH = x >> self.m2
    assert(xH.bit_length() <= m)
    # b = (xH * self.q) // H
    b = (xH * self.q) >> m
    a = x - b * self.L
    if a >= self.L:
      a -= self.L
      b += 1
    return (a, b)

def test(sp, x):
  L = sp.L
  (a, b) = sp.split(x)
  assert(0 <= a < L)
  assert(0 <= b <= L+1)
  assert(a + b * L == x)

def main():
  for z in [-0xd201000000010000, 0x8508c00000000001]:
    print(f'{hex(z)=}')
    sp = SP(z)

    r = sp.r
    L = sp.L
    for x in [0, 1, 2, L-1, L, L+1, L*3+L, L*123+456, L*L, r-L, r-1, r-2]:
      test(sp, x)

    x = 0x1234567
    for i in range(100):
      x = (x * x + 0x12345) % r
      test(sp, x)
    print('test end')
main()
