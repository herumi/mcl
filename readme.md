# mcl

A class library of finite field, elliptic curve and pairing

# Abstract

mcl is a library for pairing-based cryptography.
The current version supports the optimal Ate pairing over BN curves.

# Support architecture

* 64-bit Windows + Visual Studio
* x86, x86-64 Linux + gcc/clang
* ARM
* ARM64
* (maybe any platoform to be supported by LLVM)

# Installation Requirements

* [GMP](https://gmplib.org/) must
```
apt install libgmp-dev
```
* [OpenSSL](https://www.openssl.org/) must
* [LLVM](http://llvm.org/) optional

Create a working directory (e.g., work) and clone the following repositories.
```
mkdir work
cd work
git clone git://github.com/herumi/mcl.git
git clone git://github.com/herumi/cybozulib.git
git clone git://github.com/herumi/xbyak.git
git clone git://github.com/herumi/cybozulib_ext.git
```
* Xbyak is a prerequisite for optimizing the operations in the finite field on x86-64.
* Cybozulib_ext is a prerequisite for running OpenSSL and GMP on VC (Visual C++).

# Build and test
To make lib/libmcl.a and test, run
```
make test
```
To make sample programs, run
```
make sample
```
If LLVM is installed, then
```
make MCL_USE_LLVM=1 LLVM_VER=-3.8
```
Change `LLVM_VER=-3.8` to `LLVM_VER=-3.7` if the version of LLVM is 3.7.

## Build for 32-bit Linux
Build openssl and gmp for 32-bit mode and install <lib32>
```
make ARCH=x86 CFLAGS_USER="-I <lib32>/include" LDFLAGS_USER="-L <lib32>/lib -Wl,-rpath,<lib32>/lib"
```

## Build for 64-bit Windows
open mcl.sln and build or if you have msbuild.exe
```
msbuild /p:Configuration=Release
```

## Build for ARM64 Linux
```
make MCL_USE_LLVM=1 LLVM_VER=-3.7 ARCH=aarch64
```
## Build for ARM Linux
```
make MCL_USE_LLVM=1 LLVM_VER=-3.8 ARCH=arm
```

# License

modified new BSD License
http://opensource.org/licenses/BSD-3-Clause

The original source of the followings are https://github.com/aistcrypt/Lifted-ElGamal .
These files are licensed by BSD-3-Clause and are used for only tests.

```
include/mcl/elgamal.hpp
include/mcl/window_method.hpp
test/elgamal_test.cpp
test/window_method_test.cpp
sample/vote.cpp
```
This library contains [mie](https://github.com/herumi/mie/) and [Lifted-ElGamal](https://github.com/aistcrypt/Lifted-ElGamal/).

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

# Author

光成滋生 MITSUNARI Shigeo(herumi@nifty.com)
