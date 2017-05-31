@echo off
call setvar.bat
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

echo cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
     cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj
     lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj

echo cl /c %CFLAGS% src\bn_c.cpp /Foobj\bn_c256.obj /DMCLBN_FP_UNIT_SIZE=4
     cl /c %CFLAGS% src\bn_c.cpp /Foobj\bn_c256.obj /DMCLBN_FP_UNIT_SIZE=4
echo link /nologo /DLL /OUT:bin\mclbn256.dll obj\bn_c256.obj obj\fp.obj %LDFLAGS% /implib:lib\mclbn256.lib
     link /nologo /DLL /OUT:bin\mclbn256.dll obj\bn_c256.obj obj\fp.obj %LDFLAGS% /implib:lib\mclbn256.lib

echo cl /c %CFLAGS% src\bn_c.cpp /Foobj\bn_c384.obj /DMCLBN_FP_UNIT_SIZE=6
     cl /c %CFLAGS% src\bn_c.cpp /Foobj\bn_c384.obj /DMCLBN_FP_UNIT_SIZE=6
echo link /nologo /DLL /OUT:bin\mclbn384.dll obj\bn_c384.obj obj\fp.obj %LDFLAGS% /implib:lib\mclbn384.lib
     link /nologo /DLL /OUT:bin\mclbn384.dll obj\bn_c384.obj obj\fp.obj %LDFLAGS% /implib:lib\mclbn384.lib
