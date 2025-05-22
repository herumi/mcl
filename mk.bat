@echo off
call setvar.bat
if "%1"=="-s" (
  echo use static lib
  set LOCAL_CFLAGS=%CFLAGS% /DMCL_DONT_EXPORT lib/mcl.lib
) else if "%1"=="-d" (
  echo use dynamic lib
  set LOCAL_CFLAGS=%CFLAGS% lib/mclbn.lib /DMCL_DLL
) else (
  echo "mk (-s|-d) <source file>"
  goto exit
)
set SRC=%2
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%
echo cl %LOCAL_CFLAGS% %2 /Fe:%EXE% /link %LDFLAGS%
         cl %LOCAL_CFLAGS% %2 /Fe:%EXE% /link %LDFLAGS%

:exit
