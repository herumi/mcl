include ../common.mk
ifeq ($(UNAME_S),Darwin)
  JAVA_INC=-I/System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/
  LIB_SUF=dylib
else
  JAVA_INC=-I/usr/lib/jvm/default-java/include
#JAVA_INC=-I/usr/lib/jvm/java-7-openjdk-amd64/include
  LIB_SUF=so
  CFLAGS+=-z noexecstack
  LDFLAGS+=-lrt
endif
CFLAGS+=$(JAVA_INC) $(JAVA_INC)/linux -I ../include -I ../../xbyak -I ../../cybozulib/include -Wno-strict-aliasing
MCL_LIB=../lib/libmcl.a

PACKAGE_NAME=com.herumi.mcl
PACKAGE_DIR=$(subst .,/,$(PACKAGE_NAME))

ELGAMAL_LIB=../bin/libmcl_elgamal.$(LIB_SUF)
BN256_LIB=../bin/libmcl_bn256.$(LIB_SUF)
JAVA_EXE=cd ../bin && LD_LIBRARY_PATH=./:$(LD_LIBRARY_PATH) java -classpath ../java
all: $(ELGAMAL_LIB)

elgamal_wrap.cxx: elgamal.i elgamal_impl.hpp
	$(MKDIR) $(PACKAGE_DIR)
	swig -java -package $(PACKAGE_NAME) -outdir $(PACKAGE_DIR) -c++ -Wall elgamal.i

bn256_wrap.cxx: bn256.i bn256_impl.hpp
	$(MKDIR) $(PACKAGE_DIR)
	swig -java -package $(PACKAGE_NAME) -outdir $(PACKAGE_DIR) -c++ -Wall bn256.i

$(MCL_LIB):
	make -C ..

$(ELGAMAL_LIB): elgamal_wrap.cxx $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(CFLAGS) $(LDFLAGS) $(MCL_LIB) -shared

$(BN256_LIB): bn256_wrap.cxx $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(CFLAGS) $(LDFLAGS) $(MCL_LIB) -shared

%.class: %.java
	javac $<

ElgamalTest.class: ElgamalTest.java $(ELGAMAL_LIB)
Bn256Test.class: Bn256Test.java $(BN256_LIB)

jar:
	jar cvf mcl.jar com

test_elgamal: ElgamalTest.class $(ELGAMAL_LIB)
	$(JAVA_EXE) ElgamalTest
	$(JAVA_EXE) ElgamalTest -e NIST_P192
	$(JAVA_EXE) ElgamalTest -e NIST_P256 -h sha256
	$(JAVA_EXE) ElgamalTest -e NIST_P384 -h sha384
	$(JAVA_EXE) ElgamalTest -e NIST_P521 -h sha512

test_bn256: Bn256Test.class $(BN256_LIB)
	$(JAVA_EXE) Bn256Test

clean:
	rm -rf *.class $(ELGAMAL_LIB) $(PACKAGE_DIR)/*.class *_wrap.cxx

