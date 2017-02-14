@echo off
cl /DNOMINMAX /Ox /DNDEBUG /W4 /Zi /EHsc -I ./include -I../xbyak -I../cybozulib/include -I../cybozulib_ext/include %1 %2 /link /LIBPATH:..\cybozulib_ext\lib /LIBPATH:.\lib
