for i in 32 48
do echo $i
touch test/she_test.cpp
make bin/she_test.exe CFLAGS_USER=-DMCL_FP_BIT=$i
bin/she_test.exe > misc/she/bench$i.txt
done
