GCC_VER=$(shell $(PRE)$(CC) -dumpversion)
UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
  OS=Linux
endif
ifeq ($(findstring MINGW64,$(UNAME_S)),MINGW64)
  OS=mingw64
  CFLAGS+=-D__USE_MINGW_ANSI_STDIO=1
endif
ifeq ($(findstring CYGWIN,$(UNAME_S)),CYGWIN)
  OS=cygwin
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
ARCH?=$(shell uname -m)
ifneq ($(findstring $(ARCH),x86_64/amd64),)
  CPU=x86-64
  INTEL=1
  ifeq ($(findstring $(OS),mingw64/cygwin),)
    GCC_EXT=1
  endif
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
ifeq ($(findstring $(OS),mac/mingw64),)
  LDFLAGS+=-lrt
endif

CP=cp -f
AR=ar r
MKDIR=mkdir -p
RM=rm -rf

ifeq ($(DEBUG),1)
  ifeq ($(GCC_EXT),1)
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
INC_OPT=-I include -I test -I ../cybozulib/include
CFLAGS+=$(CFLAGS_WARN) $(BIT_OPT) $(INC_OPT)
DEBUG=0
CFLAGS_OPT_USER?=$(CFLAGS_OPT)
ifeq ($(DEBUG),0)
CFLAGS+=$(CFLAGS_OPT_USER)
endif
CFLAGS+=$(CFLAGS_USER)
MCL_USE_GMP?=1
MCL_USE_OPENSSL?=1
ifeq ($(MCL_USE_GMP),0)
  CFLAGS+=-DMCL_USE_VINT
endif
ifneq ($(MCL_SIZEOF_UNIT),)
  CFLAGS+=-DMCL_SIZEOF_UNIT=$(MCL_SIZEOF_UNIT)
endif
ifeq ($(MCL_USE_OPENSSL),0)
  CFLAGS+=-DMCL_DONT_USE_OPENSSL
endif
ifeq ($(MCL_USE_GMP),1)
  GMP_LIB=-lgmp -lgmpxx
endif
ifeq ($(MCL_USE_OPENSSL),1)
  OPENSSL_LIB=-lcrypto
endif
LDFLAGS+=$(GMP_LIB) $(OPENSSL_LIB) $(BIT_OPT) $(LDFLAGS_USER)

CFLAGS+=-fPIC

