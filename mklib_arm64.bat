@echo off

set CFLAGS=--target=arm64-pc-windows-msvc -O2 -DNDEBUG -I include -I src  -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0

if "%1"=="dll" (
  echo make dynamic library DLL
  set LOCAL_CFLAGS=%CFLAGS%
) else (
  echo make static library LIB
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DONT_EXPORT
)


echo %LOCAL_CFLAGS%
set OBJ=fp.o bint64.o base64.o

clang++ -c src\base64.ll %LOCAL_CFLAGS%
clang++ -c src\bint64.ll %LOCAL_CFLAGS%
clang++ -c src\fp.cpp %LOCAL_CFLAGS%

echo lib /nologo /OUT:lib\mcl.lib /nodefaultlib %OBJ%
lib /nologo /OUT:lib\mcl.lib /nodefaultlib %OBJ%

if "%1"=="dll" (
     echo link /nologo /DLL /OUT:bin\mclbn.dll %OBJ% %LDFLAGS% /implib:lib\mclbn.lib
     link /nologo /DLL /OUT:bin\mclbn.dll %OBJ% %LDFLAGS% /implib:lib\mclbn.lib
)
