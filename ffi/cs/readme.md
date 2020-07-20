# C# binding of mcl library

# How to build `bin/mclbn384_256.dll`.

```
git clone https://github.com/herumi/mcl
cd mcl
mklib dll
```

Open `ffi/cs/mcl.sln` and Set the directory of `mcl/bin` to `workingDirectory` at `Debug` of test project.
