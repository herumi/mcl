# The table of the curves (and the bench primes) shared by mcl and mcl-ff:
#   mcl: src/gen.py and src/gen_llvm_proto.py generate the p-fixed LLVM
#        functions mcl_c{c}_* of the exported curves into src/base{32,64}.ll
#   mcl-ff: src/gen_ff.py and src/gen_ff_x64.py take -type name-p / name-r
#        (getPrime; imported from $MCL_DIR/src)
from dataclasses import dataclass

@dataclass(frozen=True)
class Curve:
  name: str  # the key of curveTbl ('BLS12-381'); the -type of mcl-ff is name + '-p' / '-r'
  c: int  # the curve type of include/mcl/curve_type.h (the prefix of the fixed functions is mcl_c{c}_); 511 for p511 (no enum)
  p: int  # characteristic
  r: int = 0  # order (0: none)
  u: int = 0  # Fp2 = Fp[i]/(i^2 + u) (0: no Fp2)
  xi_a: int = 0  # xi = xi_a + i (Fp6 / Fp12)
  exported: bool = False  # generate mcl_c{c}_fp_* / _fr_* (and the Fp2 functions if u == 1 and xi_a == 1) in src/base{32,64}.ll

curveTbl = {cv.name: cv for cv in [
  Curve('BN254', 0,
    p=0x2523648240000001ba344d80000000086121000000000013a700000000000013,
    r=0x2523648240000001ba344d8000000007ff9f800000000010a10000000000000d,
    u=1, xi_a=1, exported=True),
  Curve('BN-SNARK', 4,
    p=0x30644e72e131a029b85045b68181585d97816a916871ca8d3c208c16d87cfd47,
    r=0x30644e72e131a029b85045b68181585d2833e84879b9709143e1f593f0000001,
    u=1, xi_a=9),
  Curve('BLS12-381', 5,
    p=0x1a0111ea397fe69a4b1ba7b6434bacd764774b84f38512bf6730d2a0f6b0f6241eabfffeb153ffffb9feffffffffaaab,
    r=0x73eda753299d7d483339d80809a1d80553bda402fffe5bfeffffffff00000001,
    u=1, xi_a=1, exported=True),
  Curve('BLS12-377', 8,
    p=0x1ae3a4617c510eac63b05c06ca1493b1a22d9f300f5138f1ef3622fba094800170b5d44300000008508c00000000001,
    r=0x12ab655e9a2ca55660b44d1e5c37b00159aa76fed00000010a11800000000001,
    u=5, xi_a=0),
  Curve('secp256k1', 102,
    p=0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f,
    r=0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141),
  Curve('p511', 511,
    p=0x65b48e8f740f89bffc8ab0d15e3e4c4ab42d083aedc88c425afbfcc69322c9cda7aac6c567f35507516730cc1f0b4f25c2721bf457aca8351b81b90533c6c87b),
]}

# the curves of the p-fixed functions of src/base{32,64}.ll
def exportedCurves():
  return [cv for cv in curveTbl.values() if cv.exported]

# mcl-ff: -type 'BLS12-381-p' -> (p, 'c5p'), 'BN254-r' -> (r, 'c0r'), 'p511' -> (p, 'c511p')
def getPrime(typeName):
  if typeName in curveTbl:
    name, field = typeName, 'p'
  else:
    name, field = typeName.rsplit('-', 1)
  cv = curveTbl[name]
  assert field in ('p', 'r'), typeName
  x = cv.p if field == 'p' else cv.r
  assert x, typeName
  return (x, f'c{cv.c}{field}')
