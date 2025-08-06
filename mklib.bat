@echo off
call setvar.bat
if "%1"=="dll" (
  echo make dynamic library DLL
  set LOCAL_CFLAGS=%CFLAGS%
) else (
  echo make static library LIB
  set LOCAL_CFLAGS=%CFLAGS% /DMCL_DONT_EXPORT
)

python3 src\gen_bint_header.py proto > include/mcl/bint_proto.hpp
python3 src\gen_bint_header.py switch > src/bint_switch.hpp

if 1 == 1 (
  echo use masm
  python3 src\gen_bint_x64.py -win -m masm > src\asm\bint-x64-win.asm
  ml64 -c src\asm\bint-x64-win.asm
) else (
  echo use nasm
  python3 src\gen_bint_x64.py -win -m nasm > src\asm\bint-x64-win.asm
  nasm -f win64 -o bint-x64-win.obj src\asm\bint-x64-win.asm
)

echo CFLAGS=%LOCAL_CFLAGS%

set OBJ=obj\fp.obj obj\msm_avx.obj bint-x64-win.obj

cl /c %LOCAL_CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %LOCAL_CFLAGS% src\msm_avx.cpp /Foobj\msm_avx.obj /arch:AVX512

if "%1"=="dll" (
     echo link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
     link /nologo /DLL /OUT:bin\mcl.dll /Brepro %OBJ% %LDFLAGS% /implib:bin\mcl.lib
) else (
  echo lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
  lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
)
