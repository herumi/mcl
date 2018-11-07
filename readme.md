[![Build Status](https://travis-ci.org/herumi/mcl.png)](https://travis-ci.org/herumi/mcl)

# mcl

A portable and fast pairing-based cryptography library.

# Abstract

mcl is a library for pairing-based cryptography.
The current version supports the optimal Ate pairing over BN curves and BLS12-381 curves.

# News
* 2nd argument of `mclBn_init` is changed from `maxUnitSize` to `compiledTimeVar`, which must be `MCLBN_COMPILED_TIME_VAR`.
* break backward compatibility of mapToGi for BLS12. A map-to-function for BN is used.
If `MCL_USE_OLD_MAPTO_FOR_BLS12` is defined, then the old function is used, but this will be removed in the future.

# Support architecture

* x86-64 Windows + Visual Studio
* x86, x86-64 Linux + gcc/clang
* ARM Linux
* ARM64 Linux
* (maybe any platform to be supported by LLVM)
* WebAssembly

# Support curves

p(z) = 36z^4 + 36z^3 + 24z^2 + 6z + 1.

* BN254 ; a BN curve over the 254-bit prime p(z) where z = -(2^62 + 2^55 + 1).
* BN\_SNARK1 ; a BN curve over a 254-bit prime p such that n := p + 1 - t has high 2-adicity.
* BN381\_1 ; a BN curve over the 381-bit prime p(z) where z = -(2^94 + 2^76 + 2^72 + 1).
* BN462 ; a BN curve over the 462-bit prime p(z) where z = 2^114 + 2^101 - 2^14 - 1.
* BLS12\_381 ; [a BLS12-381 curve](https://blog.z.cash/new-snark-curve/)

# Benchmark

## The latest benchmark(2018/11/7)

### Intel Core i7-6700 3.4GHz(Skylake), Ubuntu 18.04.1 LTS

curveType |              binary|clang-6.0.0|gcc-7.3.0|
----------|--------------------|-----------|---------|
BN254     |    bin/bn\_test.exe|    882Kclk|  933Kclk|
BLS12-381 | bin/bls12\_test.exe|   2290Kclk| 2630Kclk|

### Intel Core i7-7700 3.6GHz(Kaby Lake), Ubuntu 18.04.1 LTS on Windows 10 Vmware

curveType |              binary|clang-6.0.0|gcc-7.3.0|
----------|--------------------|-----------|---------|
BN254     |    bin/bn\_test.exe|    900Kclk|  954Kclk|
BLS12-381 | bin/bls12\_test.exe|   2340Kclk| 2680Kclk|

* now investigating the reason why gcc is slower than clang.

## Higher-bit BN curve benchmark

For JavaScript(WebAssembly), see [ID based encryption demo](https://herumi.github.io/mcl-wasm/ibe-demo.html).

paramter   |  x64| Firefox on x64|Safari on iPhone7|
-----------|-----|---------------|-----------------|
BN254      | 0.25|           2.48|             4.78|
BN381\_1   | 0.95|           7.91|            11.74|
BN462      | 2.16|          14.73|            22.77|

* x64 : 'Kaby Lake Core i7-7700(3.6GHz)'.
* Firefox : 64-bit version 58.
* iPhone7 : iOS 11.2.1.
* BN254 is by `test/bn_test.cpp`.
* BN381\_1 and BN462 are  by `test/bn512_test.cpp`.
* All the timings  are given in ms(milliseconds).

The other benchmark results are [bench.txt](bench.txt).

## An old benchmark of a BN curve BN254(2016/12/25).

* x64, x86 ; Inte Core i7-6700 3.4GHz(Skylake) upto 4GHz on Ubuntu 16.04.
    * `sudo cpufreq-set -g performance`
* arm ; 900MHz quad-core ARM Cortex-A7 on Raspberry Pi2, Linux 4.4.11-v7+
* arm64 ; 1.2GHz ARM Cortex-A53 [HiKey](http://www.96boards.org/product/hikey/)

software                                                 |   x64|  x86| arm|arm64(msec)
---------------------------------------------------------|------|-----|----|-----
[ate-pairing](https://github.com/herumi/ate-pairing)     | 0.21 |   - |  - |    -
mcl                                                      | 0.31 | 1.6 |22.6|  3.9
[TEPLA](http://www.cipher.risk.tsukuba.ac.jp/tepla/)     | 1.76 | 3.7 | 37 | 17.9
[RELIC](https://github.com/relic-toolkit/relic) PRIME=254| 0.30 | 3.5 | 36 |    -
[MIRACL](https://github.com/miracl/MIRACL) ake12bnx      | 4.2  |   - | 78 |    -
[NEONabe](http://sandia.cs.cinvestav.mx/Site/NEONabe)    |   -  |   - | 16 |    -

* compile option for RELIC
```
cmake -DARITH=x64-asm-254 -DFP_PRIME=254 -DFPX_METHD="INTEG;INTEG;LAZYR" -DPP_METHD="LAZYR;OATEP"
```

# Installation Requirements

* [GMP](https://gmplib.org/) and OpenSSL
```
apt install libgmp-dev libssl-dev
```

Create a working directory (e.g., work) and clone the following repositories.
```
mkdir work
cd work
git clone git://github.com/herumi/mcl
git clone git://github.com/herumi/cybozulib_ext ; for only Windows
```
* Cybozulib\_ext is a prerequisite for running OpenSSL and GMP on VC (Visual C++).

# Build and test on x86-64 Linux, macOS, ARM and ARM64 Linux
To make lib/libmcl.a and test it:
```
cd work/mcl
make test
```
To benchmark a pairing:
```
bin/bn_test.exe
```
To make sample programs:
```
make sample
```

if you want to change compiler options for optimization, then set `CFLAGS_OPT_USER`.
```
make CLFAGS_OPT_USER="-O2"
```

## Build for 32-bit Linux
Build openssl and gmp for 32-bit mode and install `<lib32>`
```
make ARCH=x86 CFLAGS_USER="-I <lib32>/include" LDFLAGS_USER="-L <lib32>/lib -Wl,-rpath,<lib32>/lib"
```

## Build for 64-bit Windows
1) make static library and use it

```
mklib
mk -s test\bn_c256_test.cpp
bin\bn_c256_test.exe
```
2) make dynamic library and use it

```
mklib dll
mk -d test\bn_c256_test.cpp
bin\bn_c256_test.exe
```

open mcl.sln and build or if you have msbuild.exe
```
msbuild /p:Configuration=Release
```

## Build with cmake
For Linux,
```
mkdir build
cd build
cmake ..
make
```
For Visual Studio,
```
mkdir build
cd build
cmake .. -A x64
msbuild mcl.sln /p:Configuration=Release /m
```
## Build for wasm(WebAssembly)
mcl supports emcc (Emscripten) and `test/bn_test.cpp` runs on browers such as Firefox, Chrome and Edge.

* [IBE on browser](https://herumi.github.io/mcl-wasm/ibe-demo.html)
* [SHE on browser](https://herumi.github.io/she-wasm/she-demo.html)
* [BLS signature on brower](https://herumi.github.io/bls-wasm/bls-demo.html)

The timing of a pairing on `BN254` is 2.8msec on 64-bit Firefox with Skylake 3.4GHz.

### Node.js

* [mcl-wasm](https://www.npmjs.com/package/mcl-wasm) pairing library
* [bls-wasm](https://www.npmjs.com/package/bls-wasm) BLS signature library
* [she-wasm](https://www.npmjs.com/package/she-wasm) 2 Level Homomorphic Encryption library

### SELinux
mcl uses Xbyak JIT engine if it is available on x64 architecture,
otherwise mcl uses a little slower functions generated by LLVM.
The default mode enables SELinux security policy on CentOS, then JIT is disabled.
```
% sudo setenforce 1
% getenforce
Enforcing
% bin/bn_test.exe
JIT 0
pairing   1.496Mclk
finalExp 581.081Kclk

% sudo setenforce 0
% getenforce
Permissive
% bin/bn_test.exe
JIT 1
pairing   1.394Mclk
finalExp 546.259Kclk
```

# Libraries

* G1 and G2 is defined over Fp
* The order of G1 and G2 is r.
* Use `bn256.hpp` if only BN254 is used.

## C++ library

* libmcl.a ; static C++ library of mcl
* libmcl\_dy.so ; shared C++ library of mcl
* the default parameter of curveType is BN254

header        |support curveType        |sizeof Fr|sizeof Fp|
--------------|-------------------------|---------|---------|
bn256.hpp     |BN254                    |   32    |   32    |
bls12_381.hpp |BLS12_381, BN254         |   32    |   48    |
bn384.hpp     |BN381_1, BLS12_381, BN254|   48    |   48    |

## C library

* Define `MCLBN_FR_UNIT_SIZE` and `MCLBN_FP_UNIT_SIZE` and include bn.h
* set `MCLBN_FR_UNIT_SIZE = MCLBN_FP_UNIT_SIZE` unless `MCLBN_FR_UNIT_SIZE` is defined

library           |MCLBN_FR_UNIT_SIZE|MCLBN_FP_UNIT_SIZE|
                  | sizeof Fr        |  sizeof Fp       |
------------------|------------------|------------------|
libmclbn256.a     |          4       |         4        |
libmclbn384_256.a |          4       |         6        |
libmclbn384.a     |          6       |         6        |

* libmclbn*.a ; static C library
* libmclbn*\_dy.so ; shared C library

### 2nd argument of `mclBn_init`
Specify `MCLBN_COMPILED_TIME_VAR` to 2nd argument of `mclBn_init`, which
is defined as `MCLBN_FR_UNIT_SIZE * 10 + MCLBN_FP_UNIT_SIZE`.
This parameter is used to make sure that the values are the same when the library is built and used.

### shared library name
If you want to remove `_dy` of so files, then `makeSHARE_BASENAME\_SUF=`.

# How to initialize pairing library
Call `mcl::bn256::initPairing` before calling any operations.
```
#include <mcl/bn256.hpp>
mcl::bn::CurveParam cp = mcl::BN254; // or mcl::BN_SNARK1
mcl::bn256::initPairing(cp);
mcl::bn256::G1 P(...);
mcl::bn256::G2 Q(...);
mcl::bn256::Fp12 e;
mcl::bn256::pairing(e, P, Q);
```
1. (BN254) a BN curve over the 254-bit prime p = p(z) where z = -(2^62 + 2^55 + 1).
2. (BN_SNARK1) a BN curve over a 254-bit prime p such that n := p + 1 - t has high 2-adicity.
3. BN381_1 with `mcl/bn384.hpp`.
4. BN462 with `mcl/bn512.hpp`.

See [test/bn_test.cpp](https://github.com/herumi/mcl/blob/master/test/bn_test.cpp).

## Default constructor of Fp, Ec, etc.
A default constructor does not initialize the instance.
Set a valid value before reffering it.

## Definition of groups

The curve equation for a BN curve is:

	E/Fp: y^2 = x^3 + b .

* the cyclic group G1 is instantiated as E(Fp)[n] where n := p + 1 - t;
* the cyclic group G2 is instantiated as the inverse image of E'(Fp^2)[n] under a twisting isomorphism phi from E' to E; and
* the pairing e: G1 x G2 -> Fp12 is the optimal ate pairing.

The field Fp12 is constructed via the following tower:

* Fp2 = Fp[u] / (u^2 + 1)
* Fp6 = Fp2[v] / (v^3 - Xi) where Xi = u + 1
* Fp12 = Fp6[w] / (w^2 - v)
* GT = { x in Fp12 | x^r = 1 }


## Arithmetic operations

G1 and G2 is additive group and has the following operations:

* T::add(T& z, const T& x, const T& y); // z = x + y
* T::sub(T& z, const T& x, const T& y); // z = x - y
* T::neg(T& y, const T& x); // y = -x
* T::mul(T& z, const T& x, const INT& y); // z = y times scalar multiplication of x

Remark: &z == &x or &y are allowed. INT means integer type such as Fr, int and mpz_class.

`T::mul` uses GLV method then `G2::mul` returns wrong value if x is not in G2.
Use `T::mulGeneric(T& z, const T& x, const INT& y)` for x in phi^-1(E'(Fp^2)) - G2.

Fp, Fp2, Fp6 and Fp12 have the following operations:

* T::add(T& z, const T& x, const T& y); // z = x + y
* T::sub(T& z, const T& x, const T& y); // z = x - y
* T::mul(T& z, const T& x, const T& y); // z = x * y
* T::div(T& z, const T& x, const T& y); // z = x / y
* T::neg(T& y, const T& x); // y = -x
* T::inv(T& y, const T& x); // y = 1/x
* T::pow(T& z, const T& x, const INT& y); // z = x^y
* Fp12::unitaryInv(T& y, const T& x); // y = conjugate of x

Remark: `Fp12::mul` uses GLV method then returns wrong value if x is not in GT.
Use `Fp12::mulGeneric` for x in Fp12 - GT.

## Map To points

* mapToG1(G1& P, const Fp& x);
* mapToG2(G2& P, const Fp2& x);

These functions maps x into Gi according to [_Faster hashing to G2_].

## String format of G1 and G2
G1 and G2 have three elements of Fp (x, y, z) for Jacobi coordinate.
normalize() method normalizes it to affine coordinate (x, y, 1) or (0, 0, 0).

getStr() method gets

* `0` ; infinity
* `1 <x> <y>` ; not compressed format
* `2 <x>` ; compressed format for even y
* `3 <x>` ; compressed format for odd y

## Verify an element in G2
`G2::isValid()` checks that the element is in the curve of G2 and the order of it is r for subgroup attack.
`G2::set()`, `G2::setStr` and `operator<<` also check the order.
If you check it out of the library, then you can stop the verification by calling `G2::verifyOrderG2(false)`.

# How to make asm files (optional)
The asm files generated by this way are already put in `src/asm`, then it is not necessary to do this.

Install [LLVM](http://llvm.org/).
```
make MCL_USE_LLVM=1 LLVM_VER=<llvm-version> UPDATE_ASM=1
```
For example, specify `-3.8` for `<llvm-version>` if `opt-3.8` and `llc-3.8` are installed.

If you want to use Fp with 1024-bit prime on x86-64, then
```
make MCL_USE_LLVM=1 LLVM_VER=<llvm-version> UPDATE_ASM=1 MCL_MAX_BIT_SIZE=1024
```

# API for Two level homomorphic encryption
* [_Efficient Two-level Homomorphic Encryption in Prime-order Bilinear Groups and A Fast Implementation in WebAssembly_](https://dl.acm.org/citation.cfm?doid=3196494.3196552), N. Attrapadung, G. Hanaoka, S. Mitsunari, Y. Sakai,
K. Shimizu, and T. Teruya. ASIACCS 2018
* [she-api](https://github.com/herumi/mcl/blob/master/misc/she/she-api.md)
* [she-api(Japanese)](https://github.com/herumi/mcl/blob/master/misc/she/she-api-ja.md)

# Java API
See [java.md](https://github.com/herumi/mcl/blob/master/java/java.md)

# License

modified new BSD License
http://opensource.org/licenses/BSD-3-Clause

This library contains some part of the followings software licensed by BSD-3-Clause.
* [xbyak](https://github.com/heurmi/xbyak)
* [cybozulib](https://github.com/heurmi/cybozulib)
* [Lifted-ElGamal](https://github.com/aistcrypt/Lifted-ElGamal)

# References
* [ate-pairing](https://github.com/herumi/ate-pairing/)
* [_Faster Explicit Formulas for Computing Pairings over Ordinary Curves_](http://dx.doi.org/10.1007/978-3-642-20465-4_5),
 D.F. Aranha, K. Karabina, P. Longa, C.H. Gebotys, J. Lopez,
 EUROCRYPTO 2011, ([preprint](http://eprint.iacr.org/2010/526))
* [_High-Speed Software Implementation of the Optimal Ate Pairing over Barreto-Naehrig Curves_](http://dx.doi.org/10.1007/978-3-642-17455-1_2),
   Jean-Luc Beuchat, Jorge Enrique González Díaz, Shigeo Mitsunari, Eiji Okamoto, Francisco Rodríguez-Henríquez, Tadanori Teruya,
  Pairing 2010, ([preprint](http://eprint.iacr.org/2010/354))
* [_Faster hashing to G2_](http://dx.doi.org/10.1007/978-3-642-28496-0_25),Laura Fuentes-Castañeda,  Edward Knapp,  Francisco Rodríguez-Henríquez,
  SAC 2011, ([preprint](https://eprint.iacr.org/2008/530))
* [_Skew Frobenius Map and Efficient Scalar Multiplication for Pairing–Based Cryptography_](https://www.researchgate.net/publication/221282560_Skew_Frobenius_Map_and_Efficient_Scalar_Multiplication_for_Pairing-Based_Cryptography),
Y. Sakemi, Y. Nogami, K. Okeya, Y. Morikawa, CANS 2008.

# Author

光成滋生 MITSUNARI Shigeo(herumi@nifty.com)
