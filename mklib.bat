@echo off
call "%~dp0setvar.bat"
rem usage: mklib.bat [dll] [clang=(0|1|2)]
rem clang=1 (default) requires clang++ to build src\base64.ll (MCL_USE_LLVM=1)
rem clang=2 also builds src\fp.cpp and src\msm_avx.cpp with clang-cl (CLANG_CFLAGS in setvar.bat)
rem clang=0 builds without clang++
rem USE_CLANG remains in the environment so that a following mk.bat uses the same compiler
set USE_DLL=0
set USE_CLANG=1
rem cmd splits "clang=0" into two arguments "clang" and "0"
:parse_args
if "%1"=="" goto :end_parse_args
if "%1"=="dll" set USE_DLL=1
if "%1"=="clang" (
  if "%2"=="0" set USE_CLANG=0
  if "%2"=="2" set USE_CLANG=2
  shift
)
shift
goto :parse_args
:end_parse_args
if "%USE_DLL%"=="1" (
  echo make dynamic library DLL
  set LOCAL_DEF=
) else (
  echo make static library LIB
  set LOCAL_DEF=/DMCL_DONT_EXPORT
)

set OBJ=obj\fp.obj obj\msm_avx.obj obj\bint-x64-win.obj
if not "%USE_CLANG%"=="0" (
  set LOCAL_DEF=%LOCAL_DEF% /DMCL_USE_LLVM=1
  set OBJ=%OBJ% obj\base64.obj
)
if "%USE_CLANG%"=="2" (
  set CXX=clang-cl
  set LOCAL_CFLAGS=%CLANG_CFLAGS% %LOCAL_DEF%
  set MSM_ARCH=-mavx512f -mavx512ifma
  set LOCAL_LDFLAGS=%LDFLAGS% %CLANG_RT_LIB%
) else (
  set CXX=cl
  set LOCAL_CFLAGS=%CFLAGS% %LOCAL_DEF%
  set MSM_ARCH=/arch:AVX512
  set LOCAL_LDFLAGS=%LDFLAGS%
)

echo CXX=%CXX%
echo CFLAGS=%LOCAL_CFLAGS%

ml64 /c /Foobj\bint-x64-win.obj src\asm\bint-x64-win.asm
rem nasm -f win64 -o obj\bint-x64-win.obj src\asm\bint-x64-win.asm
if not "%USE_CLANG%"=="0" (
  echo build base64.ll
  clang++ -c -O3 -mbmi2 -madx -fomit-frame-pointer -fno-stack-protector -Wno-override-module -o obj\base64.obj src\base64.ll
)
%CXX% /c %LOCAL_CFLAGS% src\fp.cpp /Foobj\fp.obj
%CXX% /c %LOCAL_CFLAGS% src\msm_avx.cpp /Foobj\msm_avx.obj %MSM_ARCH%

del /q lib\mcl.*
if "%USE_DLL%"=="1" (
     echo link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LOCAL_LDFLAGS% /implib:bin\mcl.lib
     link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LOCAL_LDFLAGS% /implib:bin\mcl.lib
) else (
  echo lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
  lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
)
