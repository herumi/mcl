# Internal Algorithm

# GLV method

## Split function for BLS12-381

### Definition of parameters

```python
z = -0xd201000000010000
L = z*z - 1
r = L*L + L + 1
s = r.bit_length()
S = 1<<s
v = (L+1)*S // r
r0 = (L+1)*S % r
```

variables|z|L|r|S|v
-|-|-|-|-|-
bit_length|64|128|255|255|128


### Split function
```python
def split(x):
    b = (x * v) >> s
    a = x - b * L
    return (a, b)
```

- x in [0, r-1].
- a + b L = x for (a, b) = split(x).

### Theorem
a, b < 2^128 for all x in [0, r-1].

### Proof

```
Let r0 := (L+1)S % r, then (L+1)S=v r + r0 and r0 in [0, r-1].
Let r1 := x v % S, then x v = b S + r1 and r1 in [0, S-1].
```

```
b = floor((xv)/S) <= (xv)/S = (xvr)/(Sr) = x((L+1)S - r0) / (Sr) = (x/r)(L+1) - (r0/Sr)
  <= (L+1) < 2^128.
```

```
arS = (x - bL)rS = xrS - bSrL = xrS - (xv - r1)rL = xrS - x(vr)L + r1 rL
    = xrS - xL((L+1)S - r0) + r1 rL = xrS - xL(L+1)S + x r0 L + r1 rL
    = xS(r - L^2-L) + (x r0 + r1 r)L
    = x(S + r0 L) + r1 r L.
```
Then,
```
a = (x/r)(1 + (r0/S)L) + (r1/r)L
  < 1 + (r0/S)L + L.
```
r0/S < 0.10017, then a < 2^128.