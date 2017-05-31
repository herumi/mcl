@echo off
call setvar.bat
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

echo cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj
lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj

echo cl /c %CFLAGS% src\bn_if.cpp /Foobj\bn_if256.obj /DBN_MAX_FP_UNIT_SIZE=4
cl /c %CFLAGS% src\bn_if.cpp /Foobj\bn_if256.obj /DBN_MAX_FP_UNIT_SIZE=4
echo link /nologo /DLL /OUT:bin\bn_if256.dll obj\bn_if256.obj obj\fp.obj %LDFLAGS% /implib:lib\bn_if256.lib
link /nologo /DLL /OUT:bin\bn_if256.dll obj\bn_if256.obj obj\fp.obj %LDFLAGS% /implib:lib\bn_if256.lib
