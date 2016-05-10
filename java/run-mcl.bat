@echo off
echo [[compile MclTest.java]]
%JAVA_DIR%\bin\javac MclTest.java

echo [[run MclTest]]
pushd ..\bin
%JAVA_DIR%\bin\java -classpath ..\java MclTest %1 %2 %3 %4 %5 %6
popd
