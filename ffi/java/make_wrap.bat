@echo off
call set-java-path.bat
set JAVA_INCLUDE=%JAVA_DIR%\include
set SWIG=..\..\..\..\p\swig\swig.exe
set PACKAGE_NAME=com.herumi.mcl
set PACKAGE_DIR=%PACKAGE_NAME:.=\%
if /i "%1"=="" (
	set NAME=mcl
	set LIBNAME=
) else (
	set NAME=%1
	set LIBNAME=%NAME%
)

echo [[run swig]]
mkdir %PACKAGE_DIR%
set TOP_DIR=../..
%SWIG% -java -package %PACKAGE_NAME% -outdir %PACKAGE_DIR% -c++ -Wall %NAME%.i
echo [[make dll]]
ml64 -c %TOP_DIR%/src\asm\bint-x64-win.asm
cl /MT /DNOMINMAX /LD /Ox /DNDEBUG /EHsc %NAME%_wrap.cxx %TOP_DIR%/src/fp.cpp bint-x64-win.obj -I%JAVA_INCLUDE% -I%JAVA_INCLUDE%\win32 -I%TOP_DIR%/include -I%TOP_DIR%/../cybozulib/include /link /OUT:%TOP_DIR%/bin/mcl%LIBNAME%java.dll

call run-%NAME%.bat

echo [[make jar]]
%JAVA_DIR%\bin\jar cvf mcl.jar com
