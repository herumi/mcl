include ../common.mk

ifeq ($(USE_MONT_FP),1)
  CFLAGS += -DUSE_MONT_FP
endif

ifeq ($(USE_LLVM),1)
  CFLAGS += -DMIE_USE_LLVM
  ASM_SRC=../src/$(CPU).s
  ASM_OBJ=$(ASM_SRC:.s=.o)
  SRC+=$(ASM_SRC)
  LDFLAGS+=$(ASM_OBJ)
endif

TARGET=$(TEST_FILE)
LIBS=

SRC=fp_test.cpp ec_test.cpp fp_util_test.cpp
ifeq ($(CPU),x64)
  SRC+=fp_generator_test.cpp mont_fp_test.cpp
endif

all: $(TARGET)

test: $(TARGET) $(ASM_OBJ)
	@$(UNIT_TEST)

$(OBJDIR):
	@$(MKDIR) $(OBJDIR)

clean:
	$(CLEAN)

$(LIBS):
	$(MAKE) -C ../src

-include $(DEPEND_FILE)

ifeq ($(USE_LLVM),1)
$(ASM_OBJ): $(ASM_SRC)
	$(CXX) $< -o $@ -c
endif
