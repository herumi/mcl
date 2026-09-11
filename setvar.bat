set CFLAGS=/DNOMINMAX /O2 /DNDEBUG /openmp /W4 /EHsc /nologo -I./include -I../cybozulib_ext/include -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256
set LDFLAGS=/LIBPATH:.\lib /LIBPATH:c:\prog\cybozulib_ext\lib
rem for clang-cl (USE_CLANG=2) : the same optimization options as Makefile on x64, without /openmp
set CLANG_CFLAGS=%CFLAGS:/openmp=% /clang:-O3 /clang:-fomit-frame-pointer /clang:-fno-stack-protector -mbmi2 -madx
rem clang-cl requires clang_rt.builtins for __udivti3 (128-bit division in bint.hpp)
set CLANG_RT_LIB=
where clang >nul 2>&1 && for /f "usebackq tokens=*" %%i in (`clang -print-resource-dir`) do set CLANG_RT_LIB="%%i\lib\windows\clang_rt.builtins-x86_64.lib"
