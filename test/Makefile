include ../common.mk

TARGET=$(TEST_FILE)

SRC=fp_test.cpp ec_test.cpp fp_util_test.cpp window_method_test.cpp
ifeq ($(CPU),x64)
  SRC+=fp_generator_test.cpp mont_fp_test.cpp
endif

all: $(TARGET)

test: $(TARGET)
	@$(UNIT_TEST)

$(OBJDIR):
	@$(MKDIR) $(OBJDIR)

clean:
	$(CLEAN)

$(LIB):
	$(MAKE) -C ../src

-include $(DEPEND_FILE)

ifeq ($(USE_LLVM),1)
$(ASM_OBJ): $(ASM_SRC)
	$(CXX) $< -o $@ -c
endif

.PHONY: $(LIB)
