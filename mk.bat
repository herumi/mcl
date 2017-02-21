@echo off
call setvar.bat
set SRC=%1
set EXE=%SRC:.cpp=.exe%
set EXE=%EXE:.c=.exe%
set EXE=%EXE:test\=bin\%
set EXE=%EXE:sample\=bin\%
echo cl %CFLAGS% %1 %2 %3 /Fe:%EXE% /link %LDFLAGS%
cl %CFLAGS% %1 %2 %3 /Fe:%EXE% /link %LDFLAGS%
