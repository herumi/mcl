rem @echo off
call setvar_arm64.bat

if "%1"=="-s" (
  echo use static lib
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DONT_EXPORT -L lib -lmcl
  set LOCAL_LDFLAGS=%LDFLAGS%
) else if "%1"=="-d" (
  echo use dynamic lib
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DLL -L lib -lmclbn
  set LOCAL_LDFLAGS=%LDFLAGS%
) else (
  echo "mk (-s|-d) <source file>"
  goto exit
)

set SRC=%2
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%

echo clang++ %2 %3 -o %EXE% %LOCAL_CFLAGS% -lclang_rt.builtins-aarch64 -L "%CLANG_RT_PATH%"
     clang++ %2 %3 -o %EXE% %LOCAL_CFLAGS% -lclang_rt.builtins-aarch64 -L "%CLANG_RT_PATH%"

:exit
