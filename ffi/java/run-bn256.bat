@echo off
echo [[compile Bn256Test.java]]
%JAVA_DIR%\bin\javac Bn256Test.java

echo [[run Bn256Test]]
set TOP_DIR=..\..
pushd %TOP_DIR%\bin
%JAVA_DIR%\bin\java -classpath ../ffi/java Bn256Test %1 %2 %3 %4 %5 %6
popd
