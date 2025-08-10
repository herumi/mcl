@echo off
call setvar.bat
if "%1"=="dll" (
  echo make dynamic library DLL
  set LOCAL_CFLAGS=%CFLAGS%
) else (
  echo make static library LIB
  set LOCAL_CFLAGS=%CFLAGS% /DMCL_DONT_EXPORT
)


echo CFLAGS=%LOCAL_CFLAGS%

set OBJ=obj\fp.obj obj\msm_avx.obj obj\bint-x64-win.obj

ml64 /c /Foobj\bint-x64-win.obj src\asm\bint-x64-win.asm
rem nasm -f win64 -o obj\bint-x64-win.obj src\asm\bint-x64-win.asm
cl /c %LOCAL_CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %LOCAL_CFLAGS% src\msm_avx.cpp /Foobj\msm_avx.obj /arch:AVX512

if "%1"=="dll" (
     echo link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
     link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
) else (
  echo lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
  lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
)
