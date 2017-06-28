include common.mk
LIB_DIR=lib
OBJ_DIR=obj
EXE_DIR=bin
SRC_SRC=fp.cpp bn_c256.cpp bn_c384.cpp
TEST_SRC=fp_test.cpp ec_test.cpp fp_util_test.cpp window_method_test.cpp elgamal_test.cpp fp_tower_test.cpp gmp_test.cpp bn_test.cpp bn384_test.cpp glv_test.cpp pailler_test.cpp bgn_test.cpp
TEST_SRC+=bn_c256_test.cpp bn_c384_test.cpp
ifeq ($(CPU),x86-64)
  MCL_USE_XBYAK?=1
  TEST_SRC+=mont_fp_test.cpp sq_test.cpp
  ifeq ($(USE_LOW_ASM),1)
    TEST_SRC+=low_test.cpp
  endif
  ifeq ($(MCL_USE_XBYAK),1)
    TEST_SRC+=fp_generator_test.cpp
  endif
endif
SAMPLE_SRC=bench.cpp ecdh.cpp random.cpp rawbench.cpp vote.cpp pairing.cpp large.cpp tri-dh.cpp bls_sig.cpp pairing_c.c

ifneq ($(MCL_MAX_BIT_SIZE),)
  CFLAGS+=-DMCL_MAX_BIT_SIZE=$(MCL_MAX_BIT_SIZE)
endif
ifeq ($(MCL_USE_XBYAK),0)
  CFLAGS+=-DMCL_DONT_USE_XBYAK
endif
SHARE_BASENAME_SUF?=_dy
##################################################################
MCL_LIB=$(LIB_DIR)/libmcl.a
MCL_SLIB=$(LIB_DIR)/libmcl$(SHARE_BASENAME_SUF).$(LIB_SUF)
BN256_LIB=$(LIB_DIR)/libmclbn256.a
BN256_SLIB=$(LIB_DIR)/libmclbn256$(SHARE_BASENAME_SUF).$(LIB_SUF)
BN384_LIB=$(LIB_DIR)/libmclbn384.a
BN384_SLIB=$(LIB_DIR)/libmclbn384$(SHARE_BASENAME_SUF).$(LIB_SUF)
all: $(MCL_LIB) $(MCL_SLIB) $(BN256_LIB) $(BN256_SLIB) $(BN384_LIB) $(BN384_SLIB)

#LLVM_VER=-3.8
LLVM_LLC=llc$(LLVM_VER)
LLVM_OPT=opt$(LLVM_VER)
GEN_EXE=src/gen
ifeq ($(OS),mac)
  ASM_SRC_PATH_NAME=src/asm/$(CPU)mac
else
  ASM_SRC_PATH_NAME=src/asm/$(CPU)
endif
ifneq ($(CPU),)
  ASM_SRC=$(ASM_SRC_PATH_NAME).s
endif
ASM_OBJ=$(OBJ_DIR)/$(CPU).o
LIB_OBJ=$(OBJ_DIR)/fp.o
BN256_OBJ=$(OBJ_DIR)/bn_c256.o
BN384_OBJ=$(OBJ_DIR)/bn_c384.o
FUNC_LIST=src/func.list
MCL_USE_LLVM?=1
ifeq ($(MCL_USE_LLVM),1)
  CFLAGS+=-DMCL_USE_LLVM=1
  LIB_OBJ+=$(ASM_OBJ)
endif
LLVM_SRC=src/base$(BIT).ll

# CPU is used for llvm
# see $(LLVM_LLC) --version
LLVM_FLAGS=-march=$(CPU) -relocation-model=pic #-misched=ilpmax
LLVM_FLAGS+=-pre-RA-sched=list-ilp -max-sched-reorder=128

#HAS_BMI2=$(shell cat "/proc/cpuinfo" | grep bmi2 >/dev/null && echo "1")
#ifeq ($(HAS_BMI2),1)
#  LLVM_FLAGS+=-mattr=bmi2
#endif

ifeq ($(USE_LOW_ASM),1)
  LOW_ASM_OBJ=$(LOW_ASM_SRC:.asm=.o)
  LIB_OBJ+=$(LOW_ASM_OBJ)
endif
# special case for intel with bmi2
ifeq ($(INTEL),1)
  LIB_OBJ+=$(OBJ_DIR)/$(CPU).bmi2.o
endif

ifeq ($(UPDATE_ASM),1)
  ASM_SRC_DEP=$(LLVM_SRC)
  ASM_BMI2_SRC_DEP=src/base$(BIT).bmi2.ll
else
  ASM_SRC_DEP=
  ASM_BMI2_SRC_DEP=
endif

$(MCL_LIB): $(LIB_OBJ)
	$(AR) $@ $(LIB_OBJ)

$(MCL_SLIB): $(LIB_OBJ)
	$(PRE)$(CXX) -o $@ $(LIB_OBJ) -shared $(LDFLAGS)

$(BN256_LIB): $(BN256_OBJ)
	$(AR) $@ $(BN256_OBJ)

$(BN256_SLIB): $(BN256_OBJ) $(MCL_SLIB)
	$(PRE)$(CXX) -o $@ $(BN256_OBJ) -shared $(LDFLAGS) $(MCL_SLIB)

$(BN384_LIB): $(BN384_OBJ)
	$(AR) $@ $(BN384_OBJ)

$(BN384_SLIB): $(BN384_OBJ) $(MCL_SLIB)
	$(PRE)$(CXX) -o $@ $(BN384_OBJ) -shared $(LDFLAGS) $(MCL_SLIB)

$(ASM_OBJ): $(ASM_SRC)
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS)

$(ASM_SRC): $(ASM_SRC_DEP)
	$(LLVM_OPT) -O3 -o - $< -march=$(CPU) | $(LLVM_LLC) -O3 -o $@ $(LLVM_FLAGS)

$(LLVM_SRC): $(GEN_EXE) $(FUNC_LIST)
	$(GEN_EXE) -f $(FUNC_LIST) > $@

$(ASM_SRC_PATH_NAME).bmi2.s: $(ASM_BMI2_SRC_DEP)
	$(LLVM_OPT) -O3 -o - $< -march=$(CPU) | $(LLVM_LLC) -O3 -o $@ $(LLVM_FLAGS) -mattr=bmi2

$(OBJ_DIR)/$(CPU).bmi2.o: $(ASM_SRC_PATH_NAME).bmi2.s
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS)

src/base$(BIT).bmi2.ll: $(GEN_EXE)
	$(GEN_EXE) -f $(FUNC_LIST) -s bmi2 > $@

$(FUNC_LIST): $(LOW_ASM_SRC)
ifeq ($(USE_LOW_ASM),1)
	$(shell awk '/global/ { print $$2}' $(LOW_ASM_SRC) > $(FUNC_LIST))
	$(shell awk '/proc/ { print $$2}' $(LOW_ASM_SRC) >> $(FUNC_LIST))
else
	$(shell touch $(FUNC_LIST))
endif

$(GEN_EXE): src/gen.cpp src/llvm_gen.hpp
	$(CXX) -o $@ $< $(CFLAGS) -O0

asm: $(LLVM_SRC)
	$(LLVM_OPT) -O3 -o - $(LLVM_SRC) | $(LLVM_LLC) -O3 $(LLVM_FLAGS) -x86-asm-syntax=intel

$(LOW_ASM_OBJ): $(LOW_ASM_SRC)
	$(ASM) $<

test_go256: $(MCL_SLIB) $(BN256_SLIB)
	cd ffi/go/mcl && env CGO_CFLAGS="-I../../../include -DMCLBN_FP_UNIT_SIZE=4" CGO_LDFLAGS="-L../../../lib" LD_LIBRARY_PATH=../../../lib go test -tags bn256 .

test_go384: $(MCL_SLIB) $(BN384_SLIB)
	cd ffi/go/mcl && env CGO_CFLAGS="-I../../../include -DMCLBN_FP_UNIT_SIZE=6" CGO_LDFLAGS="-L../../../lib" LD_LIBRARY_PATH=../../../lib go test -tags bn384 .

test_go:
	$(MAKE) test_go256
	$(MAKE) test_go384

##################################################################

VPATH=test sample src

.SUFFIXES: .cpp .d .exe .c .o

$(OBJ_DIR)/%.o: %.cpp
	$(PRE)$(CXX) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(OBJ_DIR)/%.o: %.c
	$(PRE)$(CC) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(EXE_DIR)/%.exe: $(OBJ_DIR)/%.o $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/bn_c256_test.exe: $(OBJ_DIR)/bn_c256_test.o $(BN256_LIB) $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(BN256_LIB) $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/bn_c384_test.exe: $(OBJ_DIR)/bn_c384_test.o $(BN384_LIB) $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(BN384_LIB) $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/pairing_c.exe: $(OBJ_DIR)/pairing_c.o $(BN256_LIB) $(MCL_LIB)
	$(PRE)$(CC) $< -o $@ $(BN256_LIB) $(MCL_LIB) $(LDFLAGS) -lstdc++

SAMPLE_EXE=$(addprefix $(EXE_DIR)/,$(addsuffix .exe,$(basename $(SAMPLE_SRC))))
sample: $(SAMPLE_EXE) $(MCL_LIB)

TEST_EXE=$(addprefix $(EXE_DIR)/,$(TEST_SRC:.cpp=.exe))
test: $(TEST_EXE)
	@echo test $(TEST_EXE)
	@sh -ec 'for i in $(TEST_EXE); do $$i|grep "ctest:name"; done' > result.txt
	@grep -v "ng=0, exception=0" result.txt; if [ $$? -eq 1 ]; then echo "all unit tests succeed"; else exit 1; fi

clean:
	$(RM) $(MCL_LIB) $(MCL_SLIB) $(BN256_LIB) $(BN256_SLIB) $(BN384_LIB) $(BN384_SLIB) $(OBJ_DIR)/*.o $(OBJ_DIR)/*.d $(EXE_DIR)/*.exe $(GEN_EXE) $(ASM_OBJ) $(LIB_OBJ) $(BN256_OBJ) $(BN384_OBJ) $(LLVM_SRC) $(FUNC_LIST) src/*.ll

ALL_SRC=$(SRC_SRC) $(TEST_SRC) $(SAMPLE_SRC)
DEPEND_FILE=$(addprefix $(OBJ_DIR)/, $(addsuffix .d,$(basename $(ALL_SRC))))
-include $(DEPEND_FILE)

PREFIX?=/usr/local
install: lib/libmcl.a lib/libmcl$(SHARE_BASENAME_SUF).$(LIB_SUF)
	$(MAKE) -C ../cybozulib install PREFIX=$(PREFIX)
	$(MKDIR) $(PREFIX)/include/mcl
	cp -a include/mcl/ $(PREFIX)/include/
	$(MKDIR) $(PREFIX)/lib
	cp -a lib/libmcl.a lib/libmcl$(SHARE_BASENAME_SUF).$(LIB_SUF) $(PREFIX)/lib/

.PHONY: test

# don't remove these files automatically
.SECONDARY: $(addprefix $(OBJ_DIR)/, $(ALL_SRC:.cpp=.o))
 
