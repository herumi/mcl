@echo off
call setvar_arm64.bat

if "%1"=="dll" (
  echo make dynamic library DLL
  set LOCAL_CFLAGS=%CFLAGS%
  set LOCAL_LDFLAGS=%LDFLAGS%
) else (
  echo make static library LIB
  set LOCAL_CFLAGS=%CFLAGS% -DMCL_DONT_EXPORT
  set LOCAL_LDFLAGS=%LDFLAGS%
)

set OBJ=obj\fp.o obj\bint64.o obj\base64.o

echo LOCAL_CFLAGS=%LOCAL_CFLAGS%
echo LOCAL_LDFLAGS=%LOCAL_LDFLAGS%

clang++ -c -o obj\base64.o src\base64.ll %LOCAL_CFLAGS%
clang++ -c -o obj\bint64.o src\bint64.ll %LOCAL_CFLAGS%
clang++ -c -o obj\fp.o src\fp.cpp %LOCAL_CFLAGS%

if "%1"=="dll" (
clang-cl -target aarch64-pc-windows-msvc /LD %OBJ% /Fe:bin\mclbn.dll /link /Brepro "%CLANG_RT_PATH%\clang_rt.builtins-aarch64.lib" msvcrt.lib kernel32.lib /LIBPATH:"%WindowsSdkDir%Lib\%WindowsSDKVersion%\um\arm64" /LIBPATH:"%WindowsSdkDir%Lib\%WindowsSDKVersion%\ucrt\arm64"
) else (
echo lib /nologo /OUT:lib\mcl.lib /Brepro /nodefaultlib %OBJ%
lib /nologo /OUT:lib\mcl.lib /nodefaultlib %OBJ%
)
