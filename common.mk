GCC_VER=$(shell $(PRE)$(CC) -dumpversion)
UNAME_S=$(shell uname -s)
ifeq ($(UNAME_S),Linux)
  OS=Linux
endif
ifneq ($(UNAME_S),Darwin)
  LDFLAGS += -lrt
endif
CP = cp -f
AR = ar r
MKDIR=mkdir -p
RM=rm -fr
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
CFLAGS_WARN=-Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wfloat-equal -Wpointer-arith
CFLAGS+= -g
CFLAGS+=$(CFLAGS_WARN)
BIT?=64
ifeq ($(BIT),32)
  CPU?=x86
else
  ifeq ($(BIT),64)
    CPU?=x64
  endif
endif
ifeq ($(BIT),0)
	BIT_OPT=
else
	BIT_OPT=-m$(BIT)
endif
ifeq ($(MARCH),)
ifeq ($(shell expr $(GCC_VER) \> 4.2.1),1)
	CFLAGS+=-march=native
endif
else
	CFLAGS+=$(MARCH)
endif

DEBUG=0
ifeq ($(DEBUG),1)
	DEBUG=1
endif

ifeq ($(DEBUG),0)
  CFLAGS+=$(CFLAGS_OPT)
  OBJDIR=release
  OBJSUF=
else
  ifeq ($(OS),Linux)
#    LDFLAGS+=-rdynamic
  endif
  OBJDIR=debug
  OBJSUF=d
endif

####################################################

LIB=$(TOPDIR)lib/libmcl$(OBJSUF).a
LDFLAGS += -lpthread -m$(BIT) -lgmp -lgmpxx -lcrypto

ifeq ($(MARCH),)
  ifeq ($(BIT),64)
#    CFLAGS += -DMCL_USE_XBYAK
  endif
endif

CFLAGS += -DMCL_USE_LLVM

####################################################

TOPDIR:=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))/
PARENTDIR:=$(realpath $(TOPDIR)../)/
EXTDIR:=$(PARENTDIR)cybozulib_ext/
CFLAGS+= -I$(TOPDIR)include -I$(PARENTDIR)cybozulib/include/ -I$(PARENTDIR)xbyak/ $(BIT_OPT) $(INC_DIR)
#LDFLAGS+= -L$(TOPDIR)lib $(BIT_OPT) -Wl,-rpath,'$$ORIGIN/../lib' $(LD_DIR)
LDFLAGS+= $(BIT_OPT)

MKDEP = sh -ec '$(PRE)$(CC) -MM $(CFLAGS) $< | sed "s@\($*\)\.o[ :]*@$(OBJDIR)/\1.o $@ : @g" > $@; [ -s $@ ] || rm -f $@; touch $@'

CLEAN=$(RM) $(TARGET) $(OBJDIR)

define UNIT_TEST
sh -ec 'for i in $(TARGET); do $$i|grep "ctest:name"; done' > result.txt
grep -v "ng=0, exception=0" result.txt || echo "all unit tests are ok"
endef

define SAMPLE_TEST
sh -ec 'for i in $(TARGET); do $$i; done'
endef

.SUFFIXES: .cpp .d .exe

$(OBJDIR)/%.o: %.cpp
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS)

$(OBJDIR)/%.o: %.s
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS)

$(OBJDIR)/%.d: %.cpp $(OBJDIR)
	@$(MKDEP)

$(TOPDIR)bin/%$(OBJSUF).exe: $(OBJDIR)/%.o $(LIB)
	$(PRE)$(CXX) $< -o $@ $(LIB) $(LDFLAGS)

OBJ=$(addprefix $(OBJDIR)/,$(SRC:.cpp=.o))

DEPEND_FILE=$(addprefix $(OBJDIR)/, $(SRC:.cpp=.d))
TEST_FILE=$(addprefix $(TOPDIR)bin/, $(SRC:.cpp=$(OBJSUF).exe))

.PHONY: test

