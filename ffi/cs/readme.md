# C# binding of mcl library

# How to build `bin/mcl.dll`.

```
git clone https://github.com/herumi/mcl
cd mcl
mklib dll
```

Open `mcl/ffi/cs/mcl.sln` and Set the directory of `mcl/bin` to `workingDirectory` at `Debug` of test project.
`mcl/mcl.cs` supports `BN254`, `BN_SNARK` and `BLS12_381` curve, which requires `bin/mcl.dll`.

# `ETHmode` with `BLS12_381`

If you need the map-to-G1/G2 function defined in [Hashing to Elliptic Curves](https://www.ietf.org/id/draft-irtf-cfrg-hash-to-curve-09.html),
then initialize this library as the followings:
```
MCL.Init(BLS12_381);
MCL.ETHmode();
```
