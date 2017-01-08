@echo off
call set-java-path.bat
set JAVA_INCLUDE=%JAVA_DIR%\include
set SWIG=..\..\..\p\swig\swig.exe
set PACKAGE_NAME=com.herumi.mcl
set PACKAGE_DIR=%PACKAGE_NAME:.=\%

echo [[run swig]]
mkdir %PACKAGE_DIR%
echo %SWIG% -java -package %PACKAGE_NAME% -outdir %PACKAGE_DIR% -c++ -Wall mcl_elgamal.i
%SWIG% -java -package %PACKAGE_NAME% -outdir %PACKAGE_DIR% -c++ -Wall mcl_elgamal.i
echo [[make dll]]
rem cl /MT /DNOMINMAX /LD /Ox /DNDEBUG /EHsc mcl_elgamal_wrap.cxx -I%JAVA_INCLUDE% -I%JAVA_INCLUDE%\win32 -I../include -I../../cybozulib/include -I../../cybozulib_ext/include -I../../xbyak /link /LIBPATH:../../cybozulib_ext/lib /LIBPATH:../lib /OUT:../bin/mcl_elgamal_wrap.dll
cl /MT /DNOMINMAX /LD /Ox /DNDEBUG /EHsc mcl_elgamal_wrap.cxx ../src/fp.cpp -DMCL_NO_AUTOLINK -I%JAVA_INCLUDE% -I%JAVA_INCLUDE%\win32 -I../include -I../../cybozulib/include -I../../cybozulib_ext/include -I../../xbyak /link /LIBPATH:../../cybozulib_ext/lib /OUT:../bin/mcl_elgamal_wrap.dll

call run-mcl_elgamal.bat

echo [[make jar]]
%JAVA_DIR%\bin\jar cvf mcl_elgamal.jar com