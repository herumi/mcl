@echo off
set CFLAGS=--target=arm64-pc-windows-msvc -O2 -DNDEBUG -I include -I src -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0
if "%1"=="-s" (
  echo use static lib
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DONT_EXPORT -L lib -lmcl
) else if "%1"=="-d" (
  echo use dynamic lib
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DLL -L lib -lmclbn
) else (
  echo "mk (-s|-d) <source file>"
  goto exit
)
set SRC=%2
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%

for /f "usebackq tokens=*" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
    set VS_PATH=%%i
)

for /d %%v in ("%VS_PATH%\VC\Tools\Llvm\ARM64\lib\clang\*") do (
    set CLANG_VERSION=%%~nxv
)

set CLANG_RT_PATH=%VS_PATH%\VC\Tools\Llvm\ARM64\lib\clang\%CLANG_VERSION%\lib\windows

echo clang++ %2 %3 -o %EXE% %LOCAL_CFLAGS% -lclang_rt.builtins-aarch64 -L "%CLANG_RT_PATH%"
     clang++ %2 %3 -o %EXE% %LOCAL_CFLAGS% -lclang_rt.builtins-aarch64 -L "%CLANG_RT_PATH%"

:exit
