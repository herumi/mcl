@echo off
echo [[compile MclElGamalTest.java]]
%JAVA_DIR%\bin\javac MclElGamalTest.java

echo [[run MclElGamalTest]]
pushd ..\bin
%JAVA_DIR%\bin\java -classpath ..\java MclElGamalTest %1 %2 %3 %4 %5 %6
popd
