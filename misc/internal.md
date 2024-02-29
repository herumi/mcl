# Internal Algorithm

# GLV method

## Split function for BLS12-381

### Definition of parameters

```python
M = 1<<256
H = 1<<128
z = -0xd201000000010000
L = z*z - 1
r = L*L + L + 1
s = r.bit_length()
S = 1<<s
v = S // L
r0 = S % L
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
- a + b L = x for (a, b) = split(x).

### Theorem
0 <= a, b < H for all x in [0, M-r].

### Proof

```
Let r0 := L S % r, then S=v L + r0 and r0 in [0, L-1].
Let r1 := x v % S, then x v = b S + r1 and r1 in [0, S-1].
```

```
b <=  xv / S < (M-r) (S/L)/S = (M-r)/L < H.
```

```
aS = (x - bL)S = xS - bSL = xS - (xv - r1)L = x(S - vL) + r1 L = r0 x + r1 L
     <= r0 (M-r) + (S-1)L < S H.
```
Then, a < H.
So for x in [0, M-1], set x = x - r if x >= H and apply split() to x.
