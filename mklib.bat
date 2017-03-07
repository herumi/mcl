@echo off
call setvar.bat
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

echo cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
cl /c %CFLAGS% src\fp.cpp /Foobj\fp.obj
echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj
lib /nologo /OUT:lib\mcl.lib /nodefaultlib obj\fp.obj

echo cl /c %CFLAGS% src\bn256.cpp /Foobj\bn256.obj
cl /c %CFLAGS% src\bn256.cpp /Foobj\bn256.obj
echo link /nologo /DLL /OUT:bin\bn256.dll obj\bn256.obj obj\fp.obj %LDFLAGS% /implib:lib\bn256.lib
link /nologo /DLL /OUT:bin\bn256.dll obj\bn256.obj obj\fp.obj %LDFLAGS% /implib:lib\bn256.lib
