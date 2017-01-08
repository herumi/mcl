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

TARGET=../bin/libmcl_elgamal_wrap.$(LIB_SUF)
JAVA_EXE=cd ../bin && LD_LIBRARY_PATH=./:$(LD_LIBRARY_PATH) java -classpath ../java
all: $(TARGET)

mcl_elgamal_wrap.cxx: mcl_elgamal.i mcl_elgamal.hpp
	$(MKDIR) $(PACKAGE_DIR)
	swig -java -package $(PACKAGE_NAME) -outdir $(PACKAGE_DIR) -c++ -Wall mcl_elgamal.i

$(MCL_LIB):
	make -C ..

$(TARGET): mcl_elgamal_wrap.cxx $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(CFLAGS) $(LDFLAGS) $(MCL_LIB) -shared


%.class: %.java
	javac $<

MclElgamalTest.class: MclElgamalTest.java $(TARGET)

jar:
	jar cvf mcl_elgamal.jar com

test_elgamal: MclElgamalTest.class $(TARGET)
	$(JAVA_EXE) MclElgamalTest
	$(JAVA_EXE) MclElgamalTest -e NIST_P192
	$(JAVA_EXE) MclElgamalTest -e NIST_P256 -h sha256
	$(JAVA_EXE) MclElgamalTest -e NIST_P384 -h sha384
	$(JAVA_EXE) MclElgamalTest -e NIST_P521 -h sha512

clean:
	rm -rf *.class $(TARGET) $(PACKAGE_DIR)/*.class

