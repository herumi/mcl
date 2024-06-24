"""
how to find the quotient of p/x.

# Notation
d = 26 # half of the double-precision bit length (52)
l = p.bit_length(),  then 2**(l-1) <= p < 2**l
a = x.bit_length(),  then 2**(a-1) <= x < 2**a

assume d < l <= a <= l + d - 3
e = a - l + 1, then e <= d - 2
assume max(e) = 9

# Preparation
(p0, p1) = divmod(2**(d+l-1), p)
# 2**(d+l-1) = p0 * p + p1, p1 < p

# Quotient
input : x < 2**(l+e-1)
a = x.bit_length()
(x0, x1) = divmod(x, 2**(a-d))
# x = x0 * 2**(a-d) + x1, x1 < 2**(a-d)

s = 2 * d - e
S = 2**s

Q'=(x0 * p0) >> s
# (Q', R') = divmod(x0 * p0, S), x0 * p0 = Q' S + R', R' < S

(Q, R) = divmod(x, p), x = Q * p + R, R < p

# Theorem
0 <= Q - Q' <= 1

S p (Q - Q') = S (p Q) - p (S Q') = S(x - R) - p(x0 p0 - R')
  = S(x0 * 2**(a-d) + x1 - R) - x0 p p0 + p R'
  = 2**(2 d - e + a - d) x0 + S x1 - S R - x0 (2**(d+l-1) - p1)) + p R'
  = 2**(d + l -1) x0 + S x1 - S R - x0 2**(d+l-1) + x0 p1 + p R'
  = S x1 + p1 x0 + p R' - S R

Q - Q' = (x1/p) + (p1/p)(x0/S) + (R'/S) - (R/p)

0 <= x1/p < 2**(a-d)/2**(l-1) = 1/2**(d-(a-l+1))=1/2**(d-e) <= 1/4
0 <= p1/p < 1
0 <= x0/S < 2**d / 2**(2d-e) = 1/2**(d-e) <= 1/4
0 <= R'/S < 1
0 <= R/p < 1

-1 < Q - Q' < 1+1/2
"""
class ApproxMul:
  def __init__(self, p, d):
    self.p = p
    self.d = d
    self.l = p.bit_length()
    t = 1<<(d+self.l-1)
    (q, r) = divmod(t, self.p)
    self.p0 = q
    self.p1 = r

  def __str__(self):
    return f'''p={self.p}
d={self.d}
l={self.l}
p0={self.p0}
p1={self.p1}'''

  def getTop(self, x):
    """
      return (x0, x1) such that x = x0 * 2**(a-d) + x1 where a = x.bit_length()
    """
    if x < self.p:
      return (0, x)
    a = x.bit_length()
    t = 1<<(a-self.d)
    return divmod(x, t)

  def quot(self, x):
    (x0, x1) = self.getTop(x)
    a = x.bit_length()
    s= 2*self.d -(a - self.l + 1)
    return (x0 * self.p0) >> s

  def check(self, x):
    (x0, x1) = self.getTop(x)
    a = x.bit_length()
    (Q, R) = divmod(x, self.p)
    S = 1<<(2*self.d - (a - self.l + 1))
    (Q2, R2) = divmod(x0 * self.p0, S)
    lhs = S * self.p * (Q - Q2)
    rhs = S * x1 + self.p1 * x0 - S * R + self.p * R2
    if Q == Q2 or Q == Q2 + 1:
      return
    if Q != Q2:
      print('rare case')
      print(f'{x=}')
      print(f'{x0=}')
      print(f'{x1=}')
      print(f'{Q=}')
      print(f'{R=}')
      print(f'{Q2=}')
      print(f'{R2=}')
    if lhs != rhs:
      print(f'check err {x=}')
      print(f'{Q=} {R=}')
      print(f'{Q2=} {R2=}')
      print(f'{lhs=} {rhs=} {lhs==rhs=}')
      ERR



def test(p):
  print(f'test {p=}')
  import random
  app = ApproxMul(p, 26)
  print(app)

  MAX = p * 256
  random.seed(a=12345)

  app.check(715409340372908097786544094000490505679080949411292527675476747206857849744375764344129765863746114129605942739419060)
  ERR
  for i in range(0, 100):
    x = p * i
    app.check(x)
    x = p * i + p-1
    app.check(x)

  for i in range(1000000):
    x = random.randint(p, p*2) *random.randint(1, 256)
    app.check(x)

def __main__():
  r = 0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001
  p = 0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab
  test(p)
  test(r)


__main__()
