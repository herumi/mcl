include ../common.mk
ifeq ($(UNAME_S),Darwin)
  JAVA_INC=-I/System/Library/Frameworks/JavaVM.framework/Versions/Current/Headers/
  LIB_SUF=dylib
else
  JAVA_INC=-I/usr/lib/jvm/default-java/include
#JAVA_INC=-I/usr/lib/jvm/java-7-openjdk-amd64/include
  LIB_SUF=so
  CFLAGS+=-z noexecstack
  LIB+=-lrt
endif
CFLAGS+= -shared -fPIC $(JAVA_INC) -Wno-strict-aliasing

PACKAGE_NAME=com.herumi.mcl
PACKAGE_DIR=$(subst .,/,$(PACKAGE_NAME))

TARGET=../bin/libmcl_if_wrap.$(LIB_SUF)
JAVA_EXE=cd ../bin && LD_LIBRARY_PATH=./:$(LD_LIBRARY_PATH) java -classpath ../java
all: $(TARGET)

mcl_if_wrap.cxx: mcl_if.i mcl_if.hpp
	swig -java -package $(PACKAGE_NAME) -outdir $(PACKAGE_DIR) -c++ -Wall mcl_if.i

$(TARGET): mcl_if_wrap.cxx
	$(PRE)$(CXX) $< -o $@ $(CFLAGS) $(LDFLAGS) ../src/fp.cpp ../src/x64.s


%.class: %.java
	javac $<

MclTest.class: MclTest.java $(TARGET)

jar:
	jar cvf mcl.jar com

test: MclTest.class $(TARGET)
	$(JAVA_EXE) MclTest
	$(JAVA_EXE) MclTest -e NIST_P192
	$(JAVA_EXE) MclTest -e NIST_P256 -h sha256
	$(JAVA_EXE) MclTest -e NIST_P384 -h sha384
	$(JAVA_EXE) MclTest -e NIST_P521 -h sha512

clean:
	rm -rf *.class $(TARGET) $(PACKAGE_DIR)/*.class

