[![Build Status](https://github.com/herumi/mcl/actions/workflows/main.yml/badge.svg)](https://github.com/herumi/mcl/actions/workflows/main.yml)

# mcl

A portable and fast pairing-based cryptography library.

# Abstract

mcl is a library for pairing-based cryptography,
which supports the optimal Ate pairing over BN curves and BLS12-381 curves.

# News
- Remove unintended G1::isValidOrder on BN curve. It improves the performance of deserialization of a point of G1.

# Version v3 includes breaking changes to lib/dll specifications.
* The default `mcl.{a,lib}` has a maximum size of 384bit for the definition field Fp of the elliptic curve,
and 256bit for the order field Fr of the elliptic curve (`MCL_FP_BIT=384`, `MCL_FR_BIT=256`).
* The arguments of the Fp/Fr initialization function have been changed.
* `mclbn***.{a,lib}` has been merged into mcl.{a,lib} and removed.

# Support architecture

- x86-64 Windows + Visual Studio 2015 (or later)
- x86, x86-64 Linux + gcc/clang
- x86-64, M1 macOS
- ARM / ARM64 Linux
- WebAssembly : see [mcl-wasm](https://github.com/herumi/mcl-wasm)
- Android : see [mcl-android](https://github.com/herumi/mcl-android)
- iPhone
- s390x(systemz)
  - install llvm and clang, and `make UPDATE_ASM=1` once.
- (maybe any platform to be supported by LLVM)

# Support curves

- BN curve : p(z) = 36z^4 + 36z^3 + 24z^2 + 6z + 1.
  - BN254 : a BN curve over the 254-bit prime p(z) where z = -(2^62 + 2^55 + 1).
  - BN\_SNARK1 : a BN curve over a 254-bit prime p such that n := p + 1 - t has high 2-adicity.
  - BN381\_1 : a BN curve over the 381-bit prime p(z) where z = -(2^94 + 2^76 + 2^72 + 1).
  - BN462 : a BN curve over the 462-bit prime p(z) where z = 2^114 + 2^101 - 2^14 - 1.
- BLS12\_381 : [a BLS12-381 curve](https://blog.z.cash/new-snark-curve/)
- BLS12\_377

# BLS signature
See [bls](https://github.com/herumi/bls) if you want mcl for BLS-signature.

# C-API
See [api.md](api.md) and [FAQ](api.md#faq) for serialization and hash-to-curve.

# How to build on Linux and macOS
x86-64/ARM/ARM64 Linux, macOS and mingw64 are supported.

GMP is necessary only to build test programs.
- `sudo apt install libgmp-dev` on Ubuntu
- `brew install gmp` on macOS

OpenMP is optional (`make MCL_USE_OMP=1` to use OpenMP for `mulVec`)
- `sudo apt install libomp-dev` on Ubuntu
- `brew install libomp`

## How to build with Makefile

For x86-64 Linux and macOS,

```
git clone https://github.com/herumi/mcl
cd mcl
make -j4
```
clang++ is required except for x86-64 on Linux and Windows.

```
make -j4 CXX=clang++
```

- `lib/libmcl.a`: static library
- `lib/libmcl.so`: shared library

# How to build with CMake

For x86-64 Linux and macOS.
```
mkdir build
cd build
cmake ..
make
```

For the other platform (including mingw), clang++ is required.
```
mkdir build
cd build
cmake .. -DCMAKE_CXX_COMPILER=clang++
make
```
Use `clang++` instead of gcc on mingw.

For Visual Studio, (REMARK : It is not maintained; use the vcxproj file.)
```
mkdir build
cd build
cmake .. -A x64
msbuild mcl.sln /p:Configuration=Release /m
```

# The following command does not run well yet.
```
mkdir build
cd build
cmake -DCMAKE_CXX_COMPILER=clang-cl -A ARM64 ..
msbuild mcl.sln /p:Configuration=Release /m /p:Platform=ARM64
```

## How to build a static library with Visual Studio
Open `mcl.sln` and build it.
`src/proj/lib/lib.vcxproj` is to build a static library `lib/mcl.lib` which is defined `MCL_FP_BIT=384`.

## options

see `cmake .. -LA`.

## tests
make test binaries in `./bin`.
```
cmake .. -DBUILD_TESTING=ON
make -j4
```


## How to make from src/{base,bint}{32,64}.ll

clang (clang-cl on Windows) is necessary to build files with a suffix ll.

- BIT = 64 (if 64-bit CPU) else 32
- `src/base${BIT}.ll` is necessary if `MCL_USE_LLVM` is defined.
  - This code is used if xbyak is not used.
- `src/bint${BIT}.ll` is necessary if `MCL_BINT_ASM=1`.
  - `src/bint-x64-{amd64,win}.asm` is used instead if `MCL_BINT_ASM_X64=1`.
  - It is faster than `src/bint64.ll` because it uses mulx/adox/adcx.

These files may be going to be unified in the future.

## How to test of BLS12-381 pairing

```
# C
make bin/bn_c384_256_test.exe && bin/bn_c384_256_test.exe

# C++
make bin/bls12_test.exe && bin/bls12_test.exe
```

### How to make a library for BLS12-381 without Xbyak
On x64 environment, mcl uses JIT code, but if you want to avoid them,

```
make lib/libmcl.a MCL_STATIC_CODE=1 -j
# test of pairing
make test_static
```
The generated library supports only *BLS12_381* and requires compiler options `-DMCL_FP_BIT=384 -DMCL_STATIC_CODE`.

## How to profile on Linux

### Use perf
```
make MCL_USE_PROF=1 bin/bls12_test.exe
env MCL_PROF=1 bin/bls12_test.exe
```

### Use Intel VTune profiler
Supporse VTune is installed in `/opt/intel/vtune_amplifier/`.
```
make MCL_USE_PROF=2 bin/bls12_test.exe
env MCL_PROF=2 bin/bls12_test.exe
```

## How to build on 32-bit x86 Linux

Build GMP for 32-bit mode.

```
sudo apt install g++-multilib
sudo apt install clang-14
cd <GMP dir>
env ABI=32 ./configure --enable-cxx --prefix=<install dir>
make -j install
cd <mcl dir>
make ARCH=x86 LLVM_VER=-14 GMP_DIR=<install dir>
```

# How to build a library for arm with clang++ on Linux

```
make -f Makefile.cross BIT=32 TARGET=armv7l
sudo apt install g++-arm-linux-gnueabi
arm-linux-gnueabi-g++ sample/pairing.cpp -O3 -DNDEBUG -I ./include/ lib/libmcl.a -DMCL_FP_BIT=384
env QEMU_LD_PREFIX=/usr/arm-linux-gnueabi/ qemu-arm ./a.out
```

The static library `libbls384_256.a` built by `bls/Makefile.onelib` in [bls](https://github.com/herumi/bls) contains all mcl functions. So please see [the comment of Makefile.onelib](https://github.com/herumi/bls/blob/master/Makefile.onelib#L198) if you want to build this library on the other platform such as Mingw64 on Linux.

# How to build on 64-bit Windows with Visual Studio

Python3 is necessary.
Open a console window, and
```
git clone https://github.com/herumi/mcl
cd mcl

# static library (support both C/C++ API)
mklib
mk -s test\bls12_test.cpp && bin\bls12_test.exe

# dynamic library (support only C API: bn.h)
mklib dll
mk -d test\bn_c384_256_test.cpp && bin\bn_c384_256_test.exe
```
(not maintenanced)
Open mcl.sln and build or if you have msbuild.exe
```
msbuild /p:Configuration=Release
```

# How to build ARM64 Windows binaries on X64 Windows using Visual Studio
Install Clang for Visual Studio.

Open command prompt and run
```
cd mcl
setvar_arm64.bat
"%VS_PATH%"\vc\auxiliary\build\vcvarsamd64_arm64.bat

# static library
mklib_arm64
mk_arm64 -s test\bls12_test.cpp

# dynamic library
mklib_arm64 dll
mk_arm64 -d test\bn_c384_256_test.cpp
```

# C# test

```
cd mcl
mklib dll
cd ffi/cs
dotnet build mcl.sln
cd ../../bin
../ffi/cs/test/bin/Debug/netcoreapp3.1/test.exe
```

# How to build for wasm(WebAssembly)
mcl supports emcc (Emscripten) and `test/bn_test.cpp` runs on browers such as Firefox, Chrome and Edge.

* [IBE on browser](https://herumi.github.io/mcl-wasm/ibe-demo.html)
* [SHE on browser](https://herumi.github.io/she-wasm/she-demo.html)
* [BLS signature on brower](https://herumi.github.io/bls-wasm/bls-demo.html)

The timing of a pairing on `BN254` is 2.8msec on 64-bit Firefox with Skylake 3.4GHz.

# Node.js

* [mcl-wasm](https://www.npmjs.com/package/mcl-wasm) pairing library
* [bls-wasm](https://www.npmjs.com/package/bls-wasm) BLS signature library
* [she-wasm](https://www.npmjs.com/package/she-wasm) 2 Level Homomorphic Encryption library

# API for Two level homomorphic encryption
* [_Efficient Two-level Homomorphic Encryption in Prime-order Bilinear Groups and A Fast Implementation in WebAssembly_](https://dl.acm.org/citation.cfm?doid=3196494.3196552), N. Attrapadung, G. Hanaoka, S. Mitsunari, Y. Sakai,
K. Shimizu, and T. Teruya. ASIACCS 2018
* [she-api](https://github.com/herumi/mcl/blob/master/misc/she/she-api.md)
* [she-api(Japanese)](https://github.com/herumi/mcl/blob/master/misc/she/she-api-ja.md)

# Java API
See [java.md](https://github.com/herumi/mcl/blob/master/ffi/java/java.md)

# License

modified new BSD License
http://opensource.org/licenses/BSD-3-Clause

This library contains some part of the followings software licensed by BSD-3-Clause.
* [xbyak](https://github.com/herumi/xbyak)
* [cybozulib](https://github.com/herumi/cybozulib)
* [Lifted-ElGamal](https://github.com/aistcrypt/Lifted-ElGamal)

# References
* [ate-pairing](https://github.com/herumi/ate-pairing/)
* [_Faster Explicit Formulas for Computing Pairings over Ordinary Curves_](http://dx.doi.org/10.1007/978-3-642-20465-4_5),
 D.F. Aranha, K. Karabina, P. Longa, C.H. Gebotys, J. Lopez,
 EUROCRYPTO 2011, ([preprint](http://eprint.iacr.org/2010/526))
* [_High-Speed Software Implementation of the Optimal Ate Pairing over Barreto-Naehrig Curves_](http://dx.doi.org/10.1007/978-3-642-17455-1_2),
   Jean-Luc Beuchat, Jorge Enrique González Díaz, Shigeo Mitsunari, Eiji Okamoto, Francisco Rodríguez-Henríquez, Tadanori Teruya,
  Pairing 2010, ([preprint](http://eprint.iacr.org/2010/354))
* [_Faster hashing to G2_](https://link.springer.com/chapter/10.1007/978-3-642-28496-0_25),Laura Fuentes-Castañeda,  Edward Knapp,  Francisco Rodríguez-Henríquez,
  SAC 2011, ([PDF](http://cacr.uwaterloo.ca/techreports/2011/cacr2011-26.pdf))
* [_Skew Frobenius Map and Efficient Scalar Multiplication for Pairing–Based Cryptography_](https://www.researchgate.net/publication/221282560_Skew_Frobenius_Map_and_Efficient_Scalar_Multiplication_for_Pairing-Based_Cryptography),
Y. Sakemi, Y. Nogami, K. Okeya, Y. Morikawa, CANS 2008.

# compatilibity

- mclBnGT_inv returns a - b w, a conjugate of x for x = a + b w in Fp12 = Fp6[w]
  - use mclBnGT_invGeneric if x is not in GT
- mclBn_setETHserialization(true) (de)serialize acoording to [ETH2.0 serialization of BLS12-381](https://github.com/ethereum/eth2.0-specs/blob/dev/specs/bls_signature.md#point-representations) when BLS12-381 is used.
- (Break backward compatibility) libmcl_dy.a is renamed to libmcl.a
  - The option SHARE_BASENAME_SUF is removed
- 2nd argument of `mclBn_init` is changed from `maxUnitSize` to `compiledTimeVar`, which must be `MCLBN_COMPILED_TIME_VAR`.
- break backward compatibility of mapToGi for BLS12. A map-to-function for BN is used.
If `MCL_USE_OLD_MAPTO_FOR_BLS12` is defined, then the old function is used, but this will be removed in the future.

# FAQ

## How do I set the hash value to Fr?
The behavior of `setHashOf` function may be a little different from what you want.
  - https://github.com/herumi/mcl/blob/master/api.md#hash-and-mapto-functions
  - https://github.com/herumi/mcl/blob/master/api.md#set-buf0bufsize-1-to-x-with-masking-according-to-the-following-way

Please use the following code:
```
template<class F>
void setHash(F& x, const void *msg, size_t msgSize)
{
    uint8_t md[32];
    mcl::fp::sha256(md, sizeof(md), msg, msgSize);
    x.setBigEndianMod(md, sizeof(md));
    // or x.setLittleEndianMod(md, sizeof(md));
}
```


# History
- 2022/Apr/10 v1.60 improve {G1,G2}::mulVec
- 2022/Mar/25 v1.59 add set DST functions for hashMapToGi
- 2022/Mar/24 add F::invVec, G::normalizeVec
- 2022/Mar/08 v1.58 improve SECP256K1 for x64
- 2022/Feb/13 v1.57 add mulVecMT
- 2021/Aug/26 v1.52 improve {G1,G2}::isValidOrder() for BLS12-381
- 2021/May/04 v1.50 support s390x(systemz)
- 2021/Apr/21 v1.41 fix inner function of mapToGi for large dst (not affect hashAndMapToGi)
- 2021/May/24 v1.40 fix sigsegv in valgrind
- 2021/Jan/28 v1.31 fix : call setOrder in init for isValidOrder
- 2021/Jan/28 v1.30 a little optimization of Fp operations
- 2020/Nov/14 v1.28 support M1 mac
- 2020/Jun/07 v1.22 remove old hash-to-curve functions
- 2020/Jun/04 v1.21 mapToG1 and hashAndMapToG1 are compatible to irtf/eip-2537
- 2020/May/13 v1.09 support draft-irtf-cfrg-hash-to-curve-07
- 2020/Mar/26 v1.07 change DST for hash-to-curve-06
- 2020/Mar/15 v1.06 support hash-to-curve-06
- 2020/Jan/31 v1.05 mclBn_ethMsgToFp2 has changed to append zero byte at the end of msg
- 2020/Jan/25 v1.04 add new hash functions
- 2019/Dec/05 v1.03 disable to check the order in setStr
- 2019/Sep/30 v1.00 add some functions to bn.h ; [api.md](api.md).
- 2019/Sep/22 v0.99 add mclBnG1_mulVec, etc.
- 2019/Sep/08 v0.98 bugfix Ec::add(P, Q, R) when P == R
- 2019/Aug/14 v0.97 add some C api functions
- 2019/Jul/26 v0.96 improved scalar multiplication
- 2019/Jun/03 v0.95 fix a parser of 0b10 with base = 16
- 2019/Apr/29 v0.94 mclBn_setETHserialization supports [ETH2.0 serialization of BLS12-381](https://github.com/ethereum/eth2.0-specs/blob/dev/specs/bls_signature.md#point-representations)
- 2019/Apr/24 v0.93 support ios
- 2019/Mar/22 v0.92 shortcut for Ec::mul(Px, P, x) if P = 0
- 2019/Mar/21 python binding of she256 for Linux/Mac/Windows
- 2019/Mar/14 v0.91 modp supports mcl-wasm
- 2019/Mar/12 v0.90 fix Vint::setArray(x) for x == this
- 2019/Mar/07 add mclBnFr_setLittleEndianMod, mclBnFp_setLittleEndianMod
- 2019/Feb/20 LagrangeInterpolation sets out = yVec[0] if k = 1
- 2019/Jan/31 add mclBnFp_mapToG1, mclBnFp2_mapToG2
- 2019/Jan/31 fix crash on x64-CPU without AVX (thanks to mortdeus)

# Author

MITSUNARI Shigeo(herumi@nifty.com)

# Sponsors welcome
[GitHub Sponsor](https://github.com/sponsors/herumi)
