@echo off
rem usage: mklib.bat [dll] [clang=(0|1|2)] [-256] [-grumpkin]
rem clang=1 (default) requires clang++ to build src\base64.ll (MCL_USE_LLVM=1)
rem clang=2 also builds src\fp.cpp and src\msm_avx.cpp with clang-cl (CLANG_CFLAGS in setvar.bat)
rem clang=0 builds without clang++
rem -256 builds with MCL_FP_BIT=256 (BN254, secp256k1, ...) into obj256\ and lib\mcl256.lib (bin\mcl256.dll) instead of obj\ and lib\mcl.lib (MCL_FP_BIT=384)
rem -grumpkin adds MCL_USE_GRUMPKIN=1 (the curve GG, Grumpkin) ; requires -256
rem USE_CLANG, MCL_FP_BIT and MCL_USE_GRUMPKIN remain in the environment so that a following mk.bat uses the same compiler and flags
set USE_DLL=0
set USE_CLANG=1
set MCL_FP_BIT=384
set MCL_USE_GRUMPKIN=0
rem cmd splits "clang=0" into two arguments "clang" and "0"
:parse_args
if "%1"=="" goto :end_parse_args
if "%1"=="dll" set USE_DLL=1
if "%1"=="-256" set MCL_FP_BIT=256
if "%1"=="-grumpkin" set MCL_USE_GRUMPKIN=1
if "%1"=="clang" (
  if "%2"=="0" set USE_CLANG=0
  if "%2"=="2" set USE_CLANG=2
  shift
)
shift
goto :parse_args
:end_parse_args
if "%MCL_USE_GRUMPKIN%"=="1" if not "%MCL_FP_BIT%"=="256" (
  echo -grumpkin requires -256
  exit /b 1
)
call "%~dp0setvar.bat"
set OBJ_DIR=obj%MCL_SUF%
set LIB_NAME=mcl%MCL_SUF%
if not exist %OBJ_DIR% mkdir %OBJ_DIR%
if not exist lib mkdir lib
if not exist bin mkdir bin
if "%USE_DLL%"=="1" (
  echo make dynamic library DLL
  set LOCAL_DEF=
) else (
  echo make static library LIB
  set LOCAL_DEF=/DMCL_DONT_EXPORT
)

set OBJ=%OBJ_DIR%\fp.obj %OBJ_DIR%\msm_avx.obj %OBJ_DIR%\bint-x64-win.obj
if not "%USE_CLANG%"=="0" (
  set LOCAL_DEF=%LOCAL_DEF% /DMCL_USE_LLVM=1
  set OBJ=%OBJ% %OBJ_DIR%\base64.obj
)
if "%USE_CLANG%"=="2" (
  set CXX=clang-cl
  set LOCAL_CFLAGS=%CLANG_CFLAGS% %LOCAL_DEF%
  set LOCAL_LDFLAGS=%LDFLAGS% %CLANG_RT_LIB%
) else (
  set CXX=cl
  set LOCAL_CFLAGS=%CFLAGS% %LOCAL_DEF%
  set LOCAL_LDFLAGS=%LDFLAGS%
)

echo CXX=%CXX%
echo CFLAGS=%LOCAL_CFLAGS%
echo MCL_FP_BIT=%MCL_FP_BIT% MCL_USE_GRUMPKIN=%MCL_USE_GRUMPKIN% OBJ_DIR=%OBJ_DIR% LIB_NAME=%LIB_NAME%

ml64 /c /Fo%OBJ_DIR%\bint-x64-win.obj src\asm\bint-x64-win.asm
rem nasm -f win64 -o %OBJ_DIR%\bint-x64-win.obj src\asm\bint-x64-win.asm
if not "%USE_CLANG%"=="0" (
  echo build base64.ll
  clang++ -c -O3 -fomit-frame-pointer -fno-stack-protector -Wno-override-module -o %OBJ_DIR%\base64.obj src\base64.ll
)
%CXX% /c %LOCAL_CFLAGS% src\fp.cpp /Fo%OBJ_DIR%\fp.obj
rem msm_avx.cpp enables AVX-512 only in the regions of MCL_MSM_AVX512_BEGIN / END (cl can use the intrinsics without /arch), so no /arch:AVX512 or -mavx512f here
%CXX% /c %LOCAL_CFLAGS% src\msm_avx.cpp /Fo%OBJ_DIR%\msm_avx.obj

del /q lib\%LIB_NAME%.*
if "%USE_DLL%"=="1" (
     echo link /nologo /DLL /OUT:bin\%LIB_NAME%.dll /Brepro %OBJ% %LOCAL_LDFLAGS% /implib:bin\%LIB_NAME%.lib
     link /nologo /DLL /OUT:bin\%LIB_NAME%.dll /Brepro %OBJ% %LOCAL_LDFLAGS% /implib:bin\%LIB_NAME%.lib
) else (
  echo lib /nologo /OUT:lib\%LIB_NAME%.lib /Brepro /nodefaultlib %OBJ%
  lib /nologo /OUT:lib\%LIB_NAME%.lib /Brepro /nodefaultlib %OBJ%
)
