GCC_VER=$(shell $(PRE)$(CC) -dumpversion)
UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
  OS=Linux
endif
ifeq ($(UNAME_S),Darwin)
  OS=mac
  ARCH=x86_64
  LIB_SUF=dylib
  CFLAGS+=-I/usr/local/opt/openssl/include
  LDFLAGS+=-L/usr/local/opt/openssl/lib
else
  LIB_SUF=so
endif
ARCH?=$(shell arch)
DO_IT=0
ifeq ($(ARCH),x86_64)
  DO_IT=1
endif
ifeq ($(ARCH),amd64)
  DO_IT=1
endif
ifeq ($(ARCH),OpenBSD.amd64)
  DO_IT=1
endif
ifeq ($(DO_IT),1)
  CPU=x86-64
  INTEL=1
  BIT=64
  BIT_OPT=-m64
  #LOW_ASM_SRC=src/asm/low_x86-64.asm
  #ASM=nasm -felf64
endif
ifeq ($(ARCH),x86)
  CPU=x86
  INTEL=1
  BIT=32
  BIT_OPT=-m32
  #LOW_ASM_SRC=src/asm/low_x86.asm
endif
ifeq ($(ARCH),armv7l)
  CPU=arm
  BIT=32
  #LOW_ASM_SRC=src/asm/low_arm.s
endif
ifeq ($(ARCH),aarch64)
  CPU=aarch64
  BIT=64
endif
ifneq ($(UNAME_S),Darwin)
  LDFLAGS+=-lrt
endif

CP=cp -f
AR=ar r
MKDIR=mkdir -p
RM=rm -rf

ifeq ($(DEBUG),1)
  ifeq ($(INTEL),1)
    CFLAGS+=-fsanitize=address
    LDFLAGS+=-fsanitize=address
  endif
else
  CFLAGS_OPT+=-fomit-frame-pointer -DNDEBUG
  ifeq ($(CXX),clang++)
    CFLAGS_OPT+=-O3
  else
    ifeq ($(shell expr $(GCC_VER) \> 4.6.0),1)
      CFLAGS_OPT+=-Ofast
    else
      CFLAGS_OPT+=-O3
    endif
  endif
  ifeq ($(MARCH),)
    ifeq ($(INTEL),1)
      CFLAGS_OPT+=-march=native
    endif
  else
    CFLAGS_OPT+=$(MARCH)
  endif
endif
CFLAGS_WARN=-Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wfloat-equal -Wpointer-arith
CFLAGS+=-g3
INC_OPT=-I include -I test -I ../xbyak -I ../cybozulib/include
CFLAGS+=$(CFLAGS_WARN) $(BIT_OPT) $(INC_OPT) $(CFLAGS_USER)
DEBUG=0
CFLAGS_OPT_USER?=$(CFLAGS_OPT)
ifeq ($(DEBUG),0)
CFLAGS+=$(CFLAGS_OPT_USER)
endif
LDFLAGS+=-lgmp -lgmpxx -lcrypto $(BIT_OPT) $(LDFLAGS_USER)

CFLAGS+=-fPIC

