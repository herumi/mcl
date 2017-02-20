@echo off
set CFLAGS=/MT /DNOMINMAX /Ox /DNDEBUG /W4 /Zi /EHsc -I ./include -I../xbyak -I../cybozulib/include -I../cybozulib_ext/include
set LDFLAGS=/link /LIBPATH:..\cybozulib_ext\lib /LIBPATH:.\lib
rem nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
rem lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj

echo cl /c %CFLAGS% src\fp.cpp
cl /c %CFLAGS% src\fp.cpp
echo lib /OUT:lib\mcl.lib /nodefaultlib fp.obj
lib /OUT:lib\mcl.lib /nodefaultlib fp.obj

echo cl /c %CFLAGS% src\bn256_if.cpp
cl /c %CFLAGS% src\bn256_if.cpp
echo cl /LD /Febin\bn256_if.dll bn256_if.obj fp.obj %LDFLAGS%
cl /LD /Febin\bn256_if.dll bn256_if.obj fp.obj %LDFLAGS%
