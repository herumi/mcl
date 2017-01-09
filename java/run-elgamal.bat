@echo off
echo [[compile ElgamalTest.java]]
%JAVA_DIR%\bin\javac ElgamalTest.java

echo [[run ElgamalTest]]
pushd ..\bin
%JAVA_DIR%\bin\java -classpath ..\java ElgamalTest %1 %2 %3 %4 %5 %6
popd
