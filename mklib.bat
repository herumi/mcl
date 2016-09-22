@echo off
nasm -f win64 -D_WIN64 src\asm\low_x86-64.asm
cl /Ox /DNDEBUG /W4 /Zi /EHsc /c -I ./include -I../xbyak -I../cybozulib -I../cybozulib_ext/include src\fp.cpp
lib /OUT:lib\mcl.lib /nodefaultlib fp.obj src\asm\low_x86-64.obj
