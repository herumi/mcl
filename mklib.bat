@echo off
call setvar.bat
if "%1"=="dll" (
  echo make dynamic library DLL
) else (
  echo make static library LIB
)
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

python3 src\gen_bint_x64.py -win -m masm > src\asm\bint-x64-win.asm
ml64 -c src\asm\bint-x64-win.asm

if "%1"=="dll" (
  set CFLAGS=%CFLAGS% /DMCL_NO_AUTOLINK /DMCLBN_NO_AUTOLINK
)

set OBJ=obj\fp.obj bint-x64-win.obj

echo cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
     cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib %OBJ%
     lib /nologo /OUT:lib\mcl.lib /nodefaultlib %OBJ%

if "%1"=="dll" (
     cl /c %CFLAGS% src\bn_c256.cpp /Foobj\bn_c256.obj
     link /nologo /DLL /OUT:bin\mclbn256.dll obj\bn_c256.obj %OBJ% %LDFLAGS% /implib:lib\mclbn256.lib

     cl /c %CFLAGS% src\bn_c384_256.cpp /Foobj\bn_c384_256.obj
     link /nologo /DLL /OUT:bin\mclbn384_256.dll obj\bn_c384_256.obj %OBJ% %LDFLAGS% /implib:lib\mclbn384_256.lib

     cl /c %CFLAGS% src\she_c384_256.cpp /Foobj\she_c384_256.obj /DMCL_NO_AUTOLINK
     link /nologo /DLL /OUT:bin\mclshe384_256.dll obj\she_c384_256.obj %OBJ% %LDFLAGS% /implib:lib\mclshe_c384_256.lib
) else (
     cl /c %CFLAGS% src\bn_c256.cpp /Foobj\bn_c256.obj
     lib /nologo /OUT:lib\mclbn256.lib /nodefaultlib obj\bn_c256.obj lib\mcl.lib

     cl /c %CFLAGS% src\bn_c384_256.cpp /Foobj\bn_c384_256.obj
     lib /nologo /OUT:lib\mclbn384_256.lib /nodefaultlib obj\bn_c384_256.obj lib\mcl.lib
)
