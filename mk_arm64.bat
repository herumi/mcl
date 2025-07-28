@echo off
call setvar_arm64.bat

set SRC=%2
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%

if "%1"=="-s" (
  echo use static lib
  echo  clang++ %2 %3 -o %EXE% %CFLAGS% %LDFLAGS% -DMCL_DONT_EXPORT -lmcl -L lib
  clang++ %2 %3 -o %EXE% %CFLAGS% %LDFLAGS% -DMCL_DONT_EXPORT -lmcl -L lib
) else if "%1"=="-d" (
  echo use dynamic lib
  echo  clang++ %2 %3 -o %EXE% %CFLAGS% %LDFLAGS% -DMCL_DLL -lmclbn -L bin
  clang++ %2 %3 -o %EXE% %CFLAGS% %LDFLAGS% -DMCL_DLL -lmclbn -L bin
) else (
  echo "mk (-s|-d) <source file>"
  goto exit
)

:exit
