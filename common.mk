GCC_VER=$(shell $(PRE)$(CC) -dumpversion)
UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
  OS=Linux
endif
ifneq ($(UNAME_S),Darwin)
  LDFLAGS+=-lrt
endif
BIT?=64
ifeq ($(BIT),32)
  CPU?=x86
else
  ifeq ($(BIT),64)
    CPU?=x86-64
  endif
endif


CP=cp -f
AR=ar r
MKDIR=mkdir -p
RM=rm -rf


ifneq ($(DEBUG),1)
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
  ifeq ($(shell expr $(GCC_VER) \> 4.2.1),1)
    CFLAGS_OPT+=-march=native
  endif
  else
    CFLAGS_OPT+=$(MARCH)
  endif
endif
CFLAGS_WARN=-Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wfloat-equal -Wpointer-arith
CFLAGS+= -g3
ifeq ($(BIT),0)
  BIT_OPT=
else
  BIT_OPT=-m$(BIT)
endif
INC_OPT=-I include -I test -I ../xbyak -I ../cybozulib/include
CFLAGS+=$(CFLAGS_WARN) $(BIT_OPT) $(INC_OPT)
DEBUG=0
ifeq ($(DEBUG),0)
CFLAGS+=$(CFLAGS_OPT)
endif
LDFLAGS+=-lgmp -lgmpxx -lcrypto $(BIT_OPT)

CFLAGS += -DMCL_USE_LLVM -fPIC

