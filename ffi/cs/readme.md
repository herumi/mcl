# C# binding of mcl library

# How to build `bin/mclbn384_256.dll`.

```
git clone https://github.com/herumi/mcl
cd mcl
mklib dll
```

Open `ffi/cs/mcl.sln` and Set the directory of `mcl/bin` to `workingDirectory` at `Debug` of test project.

# Remark
- `bn256.cs` is an old code. It will be removed in the future.
- `mcl/mcl.cs` is a new version. It support `BN254`, `BN_SNARK` and `BLS12_381` curve, which requires `mclbn384_256.dll`.