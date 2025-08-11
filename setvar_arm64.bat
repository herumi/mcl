set CFLAGS=--target=arm64-pc-windows-msvc -O2 -DNDEBUG -I include -I src -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0
for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
    set VS_PATH=%%i
)

for /d %%v in ("%VS_PATH%\VC\Tools\Llvm\ARM64\lib\clang\*") do (
    set CLANG_VERSION=%%~nxv
)

set CLANG_RT_PATH=%VS_PATH%\VC\Tools\Llvm\ARM64\lib\clang\%CLANG_VERSION%\lib\windows

set LDFLAGS=-lclang_rt.builtins-aarch64 -L "%CLANG_RT_PATH%"

echo LDFLAGS=%LDFLAGS%
