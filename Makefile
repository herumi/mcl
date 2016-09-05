include common.mk
LIB_DIR=lib
OBJ_DIR=obj
EXE_DIR=bin

SRC_SRC=fp.cpp
TEST_SRC=fp_test.cpp ec_test.cpp fp_util_test.cpp window_method_test.cpp elgamal_test.cpp fp_tower_test.cpp gmp_test.cpp bn_test.cpp
ifeq ($(CPU),x86-64)
  TEST_SRC+=fp_generator_test.cpp mont_fp_test.cpp sq_test.cpp
endif
SAMPLE_SRC=bench.cpp ecdh.cpp random.cpp rawbench.cpp vote.cpp pairing.cpp large.cpp

##################################################################
MCL_LIB=$(LIB_DIR)/libmcl.a
all: $(MCL_LIB)

#LLVM_VER=-3.8
LLVM_LLC=llc$(LLVM_VER)
LLVM_OPT=opt$(LLVM_VER)
GEN_EXE=src/gen
ifneq ($(CPU),)
  ASM_SRC=src/$(CPU).s
endif
ASM_OBJ=$(OBJ_DIR)/$(CPU).o
LIB_OBJ=$(OBJ_DIR)/fp.o
FUNC_LIST=src/func.list
USE_LLVM?=0
ifeq ($(USE_LLVM),1)
  CFLAGS+=-DMCL_USE_LLVM
  LIB_OBJ+=$(ASM_OBJ)
endif
LLVM_SRC=src/base$(BIT).ll

# CPU is used for llvm
# see $(LLVM_LLC) --version
LLVM_FLAGS=-march=$(CPU) -relocation-model=pic #-misched=ilpmax
LLVM_FLAGS+=-pre-RA-sched=list-ilp -max-sched-reorder=128

HAS_BMI2=$(shell cat "/proc/cpuinfo" | grep bmi2 >/dev/null && echo "1")
ifeq ($(HAS_BMI2),1)
  LLVM_FLAGS+=-mattr=bmi2
endif

ifeq ($(USE_LOW_ASM),1)
  LOW_ASM_OBJ=$(LOW_ASM_SRC:.asm=.o)
  LIB_OBJ+=$(LOW_ASM_OBJ)
endif

$(MCL_LIB): $(LIB_OBJ)
	-$(MKDIR) $(@D)
	$(AR) $@ $(LIB_OBJ)

$(ASM_OBJ): $(ASM_SRC)
	-$(MKDIR) $(@D)
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS)

$(ASM_SRC): $(LLVM_SRC)
	$(LLVM_OPT) -O3 -o - $< | $(LLVM_LLC) -O3 -o $@ $(LLVM_FLAGS)

$(LLVM_SRC): $(GEN_EXE) $(FUNC_LIST)
	$(GEN_EXE) -f $(FUNC_LIST) > $@

$(FUNC_LIST): $(LOW_ASM_SRC)
	$(shell awk '/global/ { print $$2}' $(LOW_ASM_SRC) > $(FUNC_LIST) || touch $(FUNC_LIST))
	$(shell awk '/proc/ { print $$2}' $(LOW_ASM_SRC) >> $(FUNC_LIST))

$(GEN_EXE): src/gen.cpp src/llvm_gen.hpp
	$(CXX) -o $@ $< $(CFLAGS) -O0

asm: $(LLVM_SRC)
	$(LLVM_OPT) -O3 -o - $(LLVM_SRC) | $(LLVM_LLC) -O3 $(LLVM_FLAGS) -x86-asm-syntax=intel

$(LOW_ASM_OBJ): $(LOW_ASM_SRC)
	$(ASM) $<

##################################################################

VPATH=test sample src

.SUFFIXES: .cpp .d .exe

$(OBJ_DIR)/%.o: %.cpp
	-$(MKDIR) $(@D)
	$(PRE)$(CXX) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(EXE_DIR)/%.exe: $(OBJ_DIR)/%.o $(MCL_LIB)
	-$(MKDIR) $(@D)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS)

SAMPLE_EXE=$(addprefix $(EXE_DIR)/,$(SAMPLE_SRC:.cpp=.exe))
sample: $(SAMPLE_EXE) $(MCL_LIB)

TEST_EXE=$(addprefix $(EXE_DIR)/,$(TEST_SRC:.cpp=.exe))
test: $(TEST_EXE)
	@echo test $(TEST_EXE)
	@sh -ec 'for i in $(TEST_EXE); do $$i|grep "ctest:name"; done' > result.txt
	@grep -v "ng=0, exception=0" result.txt || echo "all unit tests are ok"

clean:
	$(RM) $(MCL_LIB) $(OBJ_DIR)/* $(EXE_DIR)/*.exe $(GEN_EXE) $(ASM_SRC) $(ASM_OBJ) $(LIB_OBJ) $(LLVM_SRC)

ALL_SRC=$(SRC_SRC) $(TEST_SRC) $(SAMPLE_SRC)
DEPEND_FILE=$(addprefix $(OBJ_DIR)/, $(ALL_SRC:.cpp=.d))
-include $(DEPEND_FILE)

# don't remove these files automatically
.SECONDARY: $(addprefix $(OBJ_DIR)/, $(ALL_SRC:.cpp=.o))
 
