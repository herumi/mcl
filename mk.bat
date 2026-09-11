@echo off
call "%~dp0setvar.bat"
rem set USE_CLANG=2 (mklib clang=2 leaves it) to compile with clang-cl instead of cl
if "%USE_CLANG%"=="2" (
  set CXX=clang-cl
  set LOCAL_CFLAGS=%CLANG_CFLAGS%
  set LOCAL_LDFLAGS=%LDFLAGS% %CLANG_RT_LIB%
) else (
  set CXX=cl
  set LOCAL_CFLAGS=%CFLAGS%
  set LOCAL_LDFLAGS=%LDFLAGS%
)
if "%1"=="-s" (
  echo use static lib
  set LOCAL_CFLAGS=%LOCAL_CFLAGS% /DMCL_DONT_EXPORT lib/mcl.lib
) else if "%1"=="-d" (
  echo use dynamic lib
  set LOCAL_CFLAGS=%LOCAL_CFLAGS% bin/mcl.lib /DMCL_DLL
) else (
  echo "mk (-s|-d) <source file>"
  goto exit
)
set SRC=%2
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%
echo %CXX% %LOCAL_CFLAGS% %2 %3 /Fe:%EXE% /link %LOCAL_LDFLAGS%
         %CXX% %LOCAL_CFLAGS% %2 %3 /Fe:%EXE% /link %LOCAL_LDFLAGS%

:exit
