@echo off
call "%~dp0setvar.bat"
rem usage: mklib.bat [dll] [clang=(0|1)]
rem clang=1 (default) requires clang++ to build src\base64.ll (MCL_USE_LLVM=1)
rem clang=0 builds without clang++
set USE_DLL=0
set USE_CLANG=1
rem cmd splits "clang=0" into two arguments "clang" and "0"
:parse_args
if "%1"=="" goto :end_parse_args
if "%1"=="dll" set USE_DLL=1
if "%1"=="clang" (
  if "%2"=="0" set USE_CLANG=0
  shift
)
shift
goto :parse_args
:end_parse_args
if "%USE_DLL%"=="1" (
  echo make dynamic library DLL
  set LOCAL_CFLAGS=%CFLAGS%
) else (
  echo make static library LIB
  set LOCAL_CFLAGS=%CFLAGS% /DMCL_DONT_EXPORT
)

set OBJ=obj\fp.obj obj\msm_avx.obj obj\bint-x64-win.obj
if "%USE_CLANG%"=="1" (
  set LOCAL_CFLAGS=%LOCAL_CFLAGS% /DMCL_USE_LLVM=1
  set OBJ=%OBJ% obj\base64.obj
)

echo CFLAGS=%LOCAL_CFLAGS%

ml64 /c /Foobj\bint-x64-win.obj src\asm\bint-x64-win.asm
rem nasm -f win64 -o obj\bint-x64-win.obj src\asm\bint-x64-win.asm
if "%USE_CLANG%"=="1" (
  echo build base64.ll
  clang++ -c -O3 -mbmi2 -madx -fomit-frame-pointer -fno-stack-protector -Wno-override-module -o obj\base64.obj src\base64.ll
)
cl /c %LOCAL_CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %LOCAL_CFLAGS% src\msm_avx.cpp /Foobj\msm_avx.obj /arch:AVX512

del /q lib\mcl.*
if "%USE_DLL%"=="1" (
     echo link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
     link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
) else (
  echo lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
  lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
)
