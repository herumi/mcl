rem MCL_FP_BIT (384 or 256) and MCL_USE_GRUMPKIN (0 or 1) : mklib.bat sets them from its options (-256, -grumpkin) and leaves them in the environment so that a following mk.bat uses the same flags
if not defined MCL_FP_BIT set MCL_FP_BIT=384
if not defined MCL_USE_GRUMPKIN set MCL_USE_GRUMPKIN=0
rem MCL_SUF : the suffix of obj%MCL_SUF%\, lib\mcl%MCL_SUF%.lib and bin\mcl%MCL_SUF%.dll (empty for 384, 256 for 256)
set MCL_SUF=
if "%MCL_FP_BIT%"=="256" set MCL_SUF=256
set CFLAGS=/DNOMINMAX /O2 /DNDEBUG /W4 /EHsc /nologo -I./include -I../cybozulib_ext/include -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=%MCL_FP_BIT% -DMCL_FR_BIT=256 -DMCL_USE_GRUMPKIN=%MCL_USE_GRUMPKIN%
set LDFLAGS=/LIBPATH:.\lib /LIBPATH:c:\prog\cybozulib_ext\lib
rem for clang-cl (USE_CLANG=2) : the same optimization options as Makefile on x64
set CLANG_CFLAGS=%CFLAGS% /clang:-O3 /clang:-fomit-frame-pointer /clang:-fno-stack-protector
rem clang-cl requires clang_rt.builtins for __udivti3 (128-bit division in bint.hpp)
set CLANG_RT_LIB=
where clang >nul 2>&1 && for /f "usebackq tokens=*" %%i in (`clang -print-resource-dir`) do set CLANG_RT_LIB="%%i\lib\windows\clang_rt.builtins-x86_64.lib"
