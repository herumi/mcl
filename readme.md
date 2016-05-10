# mcl

A class library of finite field and elliptic curve.

# Abstract

This is a library to make a protocol for elliptic curve cryptography.

# Installation Requirements

Create a working directory (e.g., work) and clone the following repositories.
```
mkdir work
cd work
git clone git://github.com/herumi/xbyak.git
git clone git://github.com/herumi/cybozulib.git
git clone git://github.com/herumi/cybozulib_ext.git
```
* Cybozulib_ext is a prerequisite for running OpenSSL and GMP on VC (Visual C++).
* Xbyak is a prerequisite for optimizing the operations in the finite field on Intel CPUs.
* OpenSSL and libgmp-dev are available via apt-get (or other similar commands) if using Linux.

# Build and test
To make lib/libmcl.a and test, run
```
make test
```
To make sample programs, run
```
make sample
```

## Build for 32-bit Linux
Build openssl and gmp for 32-bit mode and install <lib32>
```
cd mcl
make BIT=32 CFLAGS_USER="-I <lib32>/include" LDFLAGS_USER="-L <lib32>/lib -Wl,-rpath,<lib32>/lib"
```

## Build for 64-bit Windows
open mcl.sln and build or if you have msbuild.exe
```
msbuild /p:Configuration=Release
```

# License

modified new BSD License
http://opensource.org/licenses/BSD-3-Clause

The original source of the followings are git://github.com/aistcrypt/Lifted-ElGamal.git .
These files are licensed by BSD-3-Clause and are used for only tests.

```
include/mcl/elgamal.hpp
include/mcl/window_method.hpp
test/elgamal_test.cpp
test/window_method_test.cpp
sample/vote.cpp
```

# Author

MITSUNARI Shigeo(herumi@nifty.com)

