@echo off
call setvar.bat
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

echo cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj
lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj

echo cl /c %CFLAGS% src\bn256_if.cpp /Foobj\bn256_if.obj
cl /c %CFLAGS% src\bn256_if.cpp /Foobj\bn256_if.obj
echo link /nologo /DLL /OUT:bin\bn256_if.dll obj\bn256_if.obj obj\fp.obj %LDFLAGS% /implib:lib\bn256_if.lib
link /nologo /DLL /OUT:bin\bn256_if.dll obj\bn256_if.obj obj\fp.obj %LDFLAGS% /implib:lib\bn256_if.lib
