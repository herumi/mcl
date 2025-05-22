include common.mk
LIB_DIR?=lib
OBJ_DIR?=obj
EXE_DIR?=bin
MCL_SIZEOF_UNIT?=$(shell expr $(BIT) / 8)
MCL_FP_BIT?=384
MCL_FR_BIT?=256
ifeq ($(MCL_FP_BIT)_$(MCL_FR_BIT),256_256)
  MCL_SUF=256
endif
ifeq ($(MCL_FP_BIT)_$(MCL_FR_BIT),384_256)
  MCL_SUF=384_256
endif
ifeq ($(MCL_FP_BIT)_$(MCL_FR_BIT),384_384)
  MCL_SUF=384
endif

CFLAGS+=-DMCL_FP_BIT=$(MCL_FP_BIT)
CFLAGS+=-DMCL_FR_BIT=$(MCL_FR_BIT)

CLANG?=clang++$(LLVM_VER)
SRC_SRC=fp.cpp
TEST_SRC=fp_test.cpp ec_test.cpp fp_util_test.cpp window_method_test.cpp elgamal_test.cpp fp_tower_test.cpp gmp_test.cpp bn_test.cpp glv_test.cpp paillier_test.cpp she_test.cpp vint_test.cpp conversion_test.cpp
TEST_SRC+=aggregate_sig_test.cpp array_test.cpp
TEST_SRC+=modp_test.cpp
TEST_SRC+=ecdsa_test.cpp
TEST_SRC+=mul_test.cpp
TEST_SRC+=bint_test.cpp
TEST_SRC+=low_func_test.cpp
TEST_SRC+=smallmodp_test.cpp

MCL_SNAME=mcl
ifeq ($(MCL_SUF),256)
  SRC_SRC+=bn_c256.cpp she_c256.cpp
  TEST_SRC+=bn_c256_test.cpp
  TEST_SRC+=she_c256_test.cpp
  TEST_SRC+=ecdsa_c_test.cpp
endif
ifeq ($(MCL_SUF),384_256)
  SRC_SRC+=bn_c384_256.cpp she_c384_256.cpp
  TEST_SRC+=bn_c384_256_test.cpp she_c384_256_test.cpp
  TEST_SRC+=bls12_test.cpp
  TEST_SRC+=mapto_wb19_test.cpp
endif
ifeq ($(MCL_SUF),384)
  SRC_SRC+=bn_c384.cpp
  TEST_SRC+=bn_c384_test.cpp she_c384_test.cpp
endif

#TEST_SRC+=bn_c384.cpp bn384_test.cpp bn_c384_test.cpp she_c384_test.cpp
ifneq ($(MCL_USE_GMP),1)
  TEST_SRC+=static_init_test.cpp
endif
TEST_SRC+=invmod_test.cpp
LIB_OBJ=$(OBJ_DIR)/fp.o
ifeq ($(MCL_STATIC_CODE),1)
  LIB_OBJ+=obj/static_code.o
  TEST_SRC=bls12_test.cpp
endif
ifeq ($(CPU),x86-64)
  MCL_USE_XBYAK?=1
  TEST_SRC+=mont_fp_test.cpp #sq_test.cpp
  ifeq ($(MCL_USE_XBYAK),1)
    TEST_SRC+=fp_generator_test.cpp
  endif
endif
SAMPLE_SRC=bench.cpp ecdh.cpp random.cpp rawbench.cpp vote.cpp pairing.cpp tri-dh.cpp bls_sig.cpp pairing_c.c she_smpl.cpp mt_test.cpp
#SAMPLE_SRC+=large.cpp # rebuild of bint is necessary

ifeq ($(MCL_USE_XBYAK),0)
  CFLAGS+=-DMCL_DONT_USE_XBYAK
endif
ifeq ($(MCL_USE_PROF),1)
  CFLAGS+=-DMCL_USE_PROF
endif
ifeq ($(MCL_USE_PROF),2)
  CFLAGS+=-DMCL_USE_PROF -DXBYAK_USE_VTUNE -I /opt/intel/vtune_amplifier/include/
  LDFLAGS+=-L /opt/intel/vtune_amplifier/lib64 -ljitprofiling -ldl
endif
##################################################################
MCL_LIB=$(LIB_DIR)/lib$(MCL_SNAME).a
MCL_SLIB=$(LIB_DIR)/lib$(MCL_SNAME).$(LIB_SUF)
SHE_LIB=$(LIB_DIR)/lishe$(MCL_SUF).a
SHE_SLIB=$(LIB_DIR)/lishe$(MCL_SUF).$(LIB_SUF)

all: $(MCL_LIB) $(MCL_SLIB) $(SHE_LIB) $(SHE_SLIB)
ECDSA_LIB=$(LIB_DIR)/libmclecdsa.a

#LLVM_VER=-3.8
LLVM_LLC=llc$(LLVM_VER)
LLVM_OPT=opt$(LLVM_VER)
LLVM_OPT_VERSION=$(shell $(LLVM_OPT) --version 2>/dev/null | awk '/version/ { split($$3,a,"."); print a[1]}')
GEN_EXE=src/gen
GEN_EXE_OPT=-u $(BIT)
# incompatibility between llvm 3.4 and the later version
ifneq ($(LLVM_OPT_VERSION),)
ifeq ($(shell expr $(LLVM_OPT_VERSION) \>= 9),1)
  GEN_EXE_OPT+=-ver 0x90
endif
endif

# build base$(BIT).ll
BASE_LL=src/base$(BIT).ll
BASE_ASM=src/asm/$(CPU).S
BASE_OBJ=$(OBJ_DIR)/base$(BIT).o

ifeq ($(UPDATE_ASM),1)
$(GEN_EXE): src/gen.cpp src/llvm_gen.hpp
	$(CXX) -o $@ $< $(CFLAGS)

$(BASE_LL): $(GEN_EXE)
	$(GEN_EXE) $(GEN_EXE_OPT) > $@

$(BASE_ASM): $(BASE_LL)
	$(LLVM_OPT) -O3 -o - $< -march=$(CPU) | $(LLVM_LLC) -O3 -o $@ $(LLVM_FLAGS)
endif

# specify ARCH=x86_64 CLANG_TARGET=x86_64-apple-macos for x86_64 on M1 mac
# specify ARCH=arm64 CLANG_TARGET=arm64-apple-macos for aarch64 on Intel mac
# see https://developer.apple.com/documentation/apple-silicon/building-a-universal-macos-binary
ifeq ($(UNAME_S),Darwin)
ifeq ($(CLANG_TARGET),)
CLANG_TARGET?=$(ARCH)-apple-macos
endif
endif
ifneq ($(CLANG_TARGET),)
  CFLAGS+=-target $(CLANG_TARGET)
endif
ifeq ($(OS)-$(ARCH),Linux-x86_64)
$(BASE_OBJ): $(BASE_ASM)
	$(PRE)$(CC) -c $< -o $@ $(CFLAGS) $(CFLAGS_USER)
else
$(BASE_OBJ): $(BASE_LL)
	$(CLANG) -c $< -o $@ $(CFLAGS) $(CFLAGS_USER)
endif
ifeq ($(findstring $(OS),mingw64/cygwin),)
  MCL_USE_LLVM?=1
else
  MCL_USE_LLVM=0
endif
ifeq ($(MCL_USE_LLVM),1)
  CFLAGS+=-DMCL_USE_LLVM=1
  LIB_OBJ+=$(BASE_OBJ)
endif
# for debug
asm: $(BASE_LL)
	$(LLVM_OPT) -O3 -o - $(BASE_LL) | $(LLVM_LLC) -O3 $(LLVM_FLAGS) -x86-asm-syntax=intel

# build bit$(BIT).ll
BINT_ARCH?=-$(OS)-$(CPU)
MCL_BINT_ASM?=1
MCL_BINT_ASM_X64?=1
ASM_SUF?=S
ifeq ($(OS),mingw64)
  WIN_API=-win
endif
src/fp.cpp: src/bint_switch.hpp
ifeq ($(MCL_BINT_ASM),1)
  CFLAGS+=-DMCL_BINT_ASM=1
  BINT_LL=src/bint$(BIT).ll
  BINT_OBJ=$(OBJ_DIR)/bint$(BIT).o
  LIB_OBJ+=$(BINT_OBJ)
  ifeq ($(CPU)-$(MCL_BINT_ASM_X64),x86-64-1)
    ifeq ($(OS),mingw64)
      BINT_ASM_X64_BASENAME=bint-x64-mingw
$(BINT_OBJ): src/asm/$(BINT_ASM_X64_BASENAME).S
	$(PRE)$(CXX) $(CFLAGS) -c $< -o $@

    else
      BINT_ASM_X64_BASENAME=bint-x64-amd64
$(BINT_OBJ): src/asm/$(BINT_ASM_X64_BASENAME).$(ASM_SUF)
	$(PRE)$(CC) $(CFLAGS) -c $< -o $@

    endif
  else
    BINT_BASENAME=bint$(BIT)$(BINT_ARCH)
    BINT_SRC=src/asm/$(BINT_BASENAME).$(ASM_SUF)
    CFLAGS+=-DMCL_BINT_ASM_X64=0
$(BINT_OBJ): $(BINT_LL)
	$(CLANG) -c $< -o $@ $(CFLAGS) $(CFLAGS_USER)

  endif
else
  CFLAGS+=-DMCL_BINT_ASM=0
endif
#ifneq ($(MCL_FP_BIT),)
#  GEN_BINT_HEADER_PY_OPT+=-max_bit $(MCL_FP_BIT)
#endif
ifeq ($(UPDATE_LL),1)
src/gen_bint.exe: src/gen_bint.cpp src/llvm_gen.hpp
	$(CXX) -o $@ $< -I ./src -I ./include -Wall -Wextra $(CFLAGS)
src/bint64.ll: src/gen_bint.exe
	$< -u 64 -ver 0x90 > $@
src/bint32.ll: src/gen_bint.exe
	$< -u 32 -ver 0x90 > $@
endif
ifeq ($(ARCH),x86_64)
  ifneq ($(UNAME_S),Darwin)
    MCL_MSM?=1
  endif
endif
MCL_MSM_CURVE_BIT?=381
ifeq ($(MCL_MSM),1)
  ifeq ($(ARCH),x86_64)
    MSM=msm_avx
    ifeq ($(MCL_MSM_CURVE_BIT),377)
      CFLAGS+=-DMCL_MSM_BLS12_377
    endif
  endif
  CFLAGS+=-DMCL_MSM=1
  LIB_OBJ+=$(OBJ_DIR)/$(MSM).o
$(OBJ_DIR)/$(MSM).o: src/$(MSM).cpp src/$(MSM)_bls12_381.h src/avx512.hpp
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS) -mavx512f -mavx512ifma -std=c++11 $(CFLAGS_USER)
src/$(MSM)_bls12_381.h: src/gen_msm_para.py
	python3 src/gen_msm_para.py $(MCL_MSM_CURVE_BIT) > $@
else
  CFLAGS+=-DMCL_MSM=0
endif
src/bint_switch.hpp: src/gen_bint_header.py
	python3 $< > $@ switch $(GEN_BINT_HEADER_PY_OPT)
src/llvm_proto.hpp: src/gen_llvm_proto.py
	python3 $< > $@
src/asm/$(BINT_ASM_X64_BASENAME).$(ASM_SUF): src/s_xbyak.py src/gen_bint_x64.py
ifeq ($(ASM_SUF),S)
	python3 src/gen_bint_x64.py -curveBit=$(MCL_MSM_CURVE_BIT) -m gas $(WIN_API) > $@
else
	python3 src/gen_bint_x64.py -curveBit=$(MCL_MSM_CURVE_BIT) -win > $@
endif
update_bint_x64_asm:
	python3 src/gen_bint_x64.py -curveBit=$(MCL_MSM_CURVE_BIT) -win -m masm > src/asm/bint-x64-win.asm
	python3 src/gen_bint_x64.py -curveBit=$(MCL_MSM_CURVE_BIT) -m gas > src/asm/bint-x64-amd64.S
	python3 src/gen_bint_x64.py -curveBit=$(MCL_MSM_CURVE_BIT) -m gas -win > src/asm/bint-x64-mingw.S

$(BINT_SRC): src/bint$(BIT).ll
	$(CLANG) -S $< -o $@ -no-integrated-as -fpic -O2 -DNDEBUG -Wall -Wextra $(CFLAGS) $(CFLAGS_USER)
#$(BINT_OBJ): $(BINT_SRC)
#	$(AS) $< -o $@
header:
	$(MAKE) src/bint_switch.hpp
	$(MAKE) src/llvm_proto.hpp

update_gen:
	$(shell touch src/*.py)
	$(MAKE) update_bint_x64_asm
	$(MAKE) header

#	$(MAKE) $(BINT_SRC)
#$(BINT_LL_SRC): src/bint.cpp src/bint.hpp
#	$(CLANG) -c $< -o - -emit-llvm -std=c++17 -fpic -O2 -DNDEBUG -Wall -Wextra -I ./include -I ./src | llvm-dis$(LLVM_VER) -o $@
BN_OBJ=$(OBJ_DIR)/bn_c$(MCL_SUF).o
SHE_OBJ=$(OBJ_DIR)/she_c$(MCL_SUF).o

# CPU is used for llvm
# see $(LLVM_LLC) --version
LLVM_FLAGS=-march=$(CPU) -relocation-model=pic #-misched=ilpmax
LLVM_FLAGS+=-pre-RA-sched=list-ilp -max-sched-reorder=128 -mattr=-sse

ifneq ($(findstring $(OS),mac/mac-m1/mingw64),)
  BN_SLIB_LDFLAGS+=-l$(MCL_SNAME) -L./lib
  SHE_SLIB_LDFLAGS+=-l$(MCL_SNAME) -L./lib
endif
ifeq ($(OS),mingw64)
  MCL_SLIB_LDFLAGS+=-Wl,--out-implib,$(MCL_LIB)
  SHE_SLIB_LDFLAGS+=-Wl,--out-implib,$(SHE_SLIB)
endif

$(MCL_LIB): $(LIB_OBJ)
	$(AR) $(ARFLAGS) $@ $(LIB_OBJ)

$(MCL_SLIB): $(LIB_OBJ)
	$(PRE)$(CXX) -o $@ $(LIB_OBJ) -shared $(CFLAGS) $(MCL_SLIB_LDFLAGS)

$(BN_LIB): $(BN_OBJ)
	$(AR) $(ARFLAGS) $@ $(BN_OBJ)

$(BN_SLIB): $(BN_OBJ) $(MCL_SLIB)
	$(PRE)$(CXX) -o $@ $(BN_OBJ) -shared $(CFLAGS) $(BN_SLIB_LDFLAGS)

$(SHE_LIB): $(SHE_OBJ)
	$(AR) $(ARFLAGS) $@ $(SHE_OBJ)

$(SHE_SLIB): $(SHE_OBJ) $(MCL_LIB)
	$(PRE)$(CXX) -o $@ $(SHE_OBJ) $(MCL_LIB) -shared $(CFLAGS) $(SHE_SLIB_LDFLAGS)

ECDSA_OBJ=$(OBJ_DIR)/ecdsa_c.o
$(ECDSA_LIB): $(ECDSA_OBJ)
	$(AR) $(ARFLAGS) $@ $(ECDSA_OBJ)

src/base64m.ll: $(GEN_EXE)
	$(GEN_EXE) $(GEN_EXE_OPT) -wasm > $@

src/dump_code: src/dump_code.cpp src/fp.cpp src/fp_generator.hpp
	$(CXX) -o $@ src/dump_code.cpp src/fp.cpp -g -I include -DMCL_DUMP_JIT -DMCL_SIZEOF_UNIT=8 -DNDEBUG -DMCL_MSM=0

src/static_code.asm: src/dump_code
	$< > $@

obj/static_code.o: src/static_code.asm
	nasm $(NASM_ELF_OPT) -o $@ $<

bin/static_code_test.exe: test/static_code_test.cpp src/fp.cpp obj/static_code.o $(BINT_OBJ)
	$(CXX) -o $@ -O3 $^ -g -DMCL_DONT_USE_XBYAK -DMCL_STATIC_CODE -DMCL_SIZEOF_UNIT=8 -DMCL_MSM=0 -I include -Wall -Wextra

# set PATH for mingw, set LD_LIBRARY_PATH is for other env
COMMON_LIB_PATH="../../../lib"
PATH_VAL=$$PATH:$(COMMON_LIB_PATH) LD_LIBRARY_PATH=$(COMMON_LIB_PATH) DYLD_LIBRARY_PATH=$(COMMON_LIB_PATH) CGO_CFLAGS="-I$(shell pwd)/include" CGO_LDFLAGS="-L../../../lib"

test_go: $(MCL_LIB) $(BN384_256_LIB)
	$(RM) $(BLS384_256_SLIB) $(MCL_SLIB)
	cd ffi/go/mcl && go test -v -count=1 .

test_python_she: $(SHE256_SLIB)
	cd ffi/python && env LD_LIBRARY_PATH="../../lib" DYLD_LIBRARY_PATH="../../lib" PATH=$$PATH:"../../lib" python3 she.py
test_python:
	$(MAKE) test_python_she

test_java:
	$(MAKE) -C ffi/java test

##################################################################

VPATH=test sample src

.SUFFIXES: .cpp .d .exe .c .o

$(OBJ_DIR)/%.o: %.cpp
	$(PRE)$(CXX) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(OBJ_DIR)/fp$(MCL_SUF).o: fp.cpp
	$(PRE)$(CXX) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(OBJ_DIR)/%.o: %.c
	$(PRE)$(CC) $(CFLAGS) -c $< -o $@ -MMD -MP -MF $(@:.o=.d)

$(OBJ_DIR)/%.o: src/asm/%.S
	$(PRE)$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: src/asm/%.asm
	nasm $(NASM_ELF_OPT) -o $@ $<

ifneq ($(CLANG_TARGET),)
  LDFLAGS+=-target $(CLANG_TARGET)
endif
$(EXE_DIR)/%.exe: $(OBJ_DIR)/%.o $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/bn_c$(MCL_SUF)_test.exe: $(OBJ_DIR)/bn_c$(MCL_SUF)_test.o $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/pairing_c.exe: $(OBJ_DIR)/pairing_c.o $(MCL_LIB)
	$(PRE)$(CC) $< -o $@ $(MCL_LIB) $(LDFLAGS) -lstdc++

$(EXE_DIR)/she_c$(MCL_SUF)_test.exe: $(OBJ_DIR)/she_c$(MCL_SUF)_test.o $(SHE_LIB) $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(SHE_LIB) $(MCL_LIB) $(LDFLAGS)

# assume MCL_FP_BIT=256
$(EXE_DIR)/ecdsa_c_test.exe: $(OBJ_DIR)/ecdsa_c_test.o $(ECDSA_LIB) $(MCL_LIB) src/ecdsa_c.cpp include/mcl/ecdsa.hpp include/mcl/ecdsa.h
	$(PRE)$(CXX) $< -o $@ $(ECDSA_LIB) $(MCL_LIB) $(LDFLAGS)

$(EXE_DIR)/paillier_test.exe: $(OBJ_DIR)/paillier_test.o $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS) -lgmp -lgmpxx

$(EXE_DIR)/bint_test.exe: $(OBJ_DIR)/bint_test.o $(MCL_LIB)
	$(PRE)$(CXX) $< -o $@ $(MCL_LIB) $(LDFLAGS) -lgmp -lgmpxx

SAMPLE_EXE=$(addprefix $(EXE_DIR)/,$(addsuffix .exe,$(basename $(SAMPLE_SRC))))
sample: $(SAMPLE_EXE) $(MCL_LIB)

TEST_EXE=$(addprefix $(EXE_DIR)/,$(TEST_SRC:.cpp=.exe))
test_ci: $(TEST_EXE)
	@sh -ec 'for i in $(TEST_EXE); do echo $$i; env LSAN_OPTIONS=verbosity=0:log_threads=1 $$i; done'
test: $(TEST_EXE)
	@echo test $(TEST_EXE)
	@sh -ec 'for i in $(TEST_EXE); do $$i|grep "ctest:name"; done' > result.txt
	@grep -v "ng=0, exception=0" result.txt; if [ $$? -eq 1 ]; then echo "all unit tests succeed"; else exit 1; fi

EMCC_OPT=-I./include -I./src -Wall -Wextra
EMCC_OPT+=-O3 -DNDEBUG -DMCLSHE_WIN_SIZE=8
EMCC_OPT+=-s WASM=1 -s NO_EXIT_RUNTIME=1 -s NODEJS_CATCH_EXIT=0 -s NODEJS_CATCH_REJECTION=0  -s MODULARIZE=1 #-s ASSERTIONS=1
EMCC_OPT+=-DCYBOZU_MINIMUM_EXCEPTION
EMCC_OPT+=-s ABORTING_MALLOC=0
SHE_C_DEP=src/fp.cpp src/she_c_impl.hpp include/mcl/she.hpp include/mcl/fp.hpp include/mcl/op.hpp include/mcl/she.h Makefile
MCL_C_DEP=src/fp.cpp include/mcl/bn.hpp include/mcl/fp.hpp include/mcl/op.hpp include/mcl/bn.h Makefile
ifeq ($(MCL_USE_LLVM),2)
  EMCC_OPT+=src/base64m.ll -DMCL_USE_LLVM
  SHE_C_DEP+=src/base64m.ll
endif

# test
bin/emu:
	$(CXX) -g -o $@ src/fp.cpp test/bn_c384_256_test.cpp -DMCL_DONT_USE_XBYAK -DMCL_SIZEOF_UNIT=$(MCL_SIZEOF_UNIT) -DMCL_FP_BIT=384 -I./include -DMCL_BINT_ASM=0 -DMCL_MSM=0 $(CFLAGS_USER)
bin/pairing_c_min.exe: sample/pairing_c.c include/mcl/vint.hpp src/fp.cpp include/mcl/bn.hpp
	$(CXX) -std=c++03 -O3 -g -fno-threadsafe-statics -fno-exceptions -fno-rtti -o $@ sample/pairing_c.c src/fp.cpp -I./include -DXBYAK_NO_EXCEPTION -DMCL_SIZEOF_UNIT=$(MCL_SIZEOF_UNIT) -DMCL_FP_BIT=384 -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION -DNDEBUG -DMCL_BINT_ASM=0 -DMCL_MSM=0 # -DMCL_DONT_USE_CSPRNG
bin/ecdsa-emu:
	$(CXX) -g -o $@ src/fp.cpp test/ecdsa_test.cpp -DMCL_SIZEOF_UNIT=4 -D__EMSCRIPTEN__ -DMCL_FP_BIT=256 -I./include
bin/ecdsa-c-emu:
	$(CXX) -g -o $@ src/fp.cpp src/ecdsa_c.cpp test/ecdsa_c_test.cpp -DMCL_FP_BIT=256 -DMCL_SIZEOF_UNIT=4 -DMCL_BINT_ASM=0 -I ./include -DMCL_WASM32

bin/llvm_test64.exe: test/llvm_test.cpp src/base64.ll
	$(CLANG) -o $@ -Ofast -DNDEBUG -Wall -Wextra -I ./include test/llvm_test.cpp src/base64.ll

bin/llvm_test32.exe: test/llvm_test.cpp src/base32.ll
	$(CLANG) -o $@ -Ofast -DNDEBUG -Wall -Wextra -I ./include test/llvm_test.cpp src/base32.ll -m32

test_emu_32bit:
	$(MAKE) MCL_SIZEOF_UNIT=4 bin/emu && bin/emu

test_fp_util_32bit:
	$(CXX) -m32 src/fp.cpp test/fp_util_test.cpp -DMCL_DONT_USE_XBYAK -DMCL_FP_BIT=384 -I./include -DMCL_BINT_ASM=0 -DMCL_MSM=0 -o bin/fp_util_test.exe && bin/fp_util_test.exe
test_conversion_32bit:
	$(CXX) -m32 src/fp.cpp test/conversion_test.cpp -DMCL_DONT_USE_XBYAK -DMCL_FP_BIT=384 -I./include -DMCL_BINT_ASM=0 -DMCL_MSM=0 -o bin/conversion_test.exe && bin/conversion_test.exe

test_bls12_32bit:
	$(CXX) -m32 src/fp.cpp test/bls12_test.cpp -DMCL_DONT_USE_XBYAK -DMCL_FP_BIT=384 -I./include -DMCL_BINT_ASM=0 -DMCL_MSM=0 -o bin/bls12_test.exe && bin/bls12_test.exe

test_32bit:
	$(MAKE) test_bls12_32bit
	$(MAKE) test_fp_util_32bit
	$(MAKE) test_conversion_32bit
	$(MAKE) test_emu_32bit

# clear before testing
test_static:
	$(MAKE) lib/libmcl.a MCL_STATIC_CODE=1 -j
	$(CXX) -O2 -DNDEBUG -g -o bin/pairing_static.exe sample/pairing.cpp -I ./include lib/libmcl.a -DMCL_FP_BIT=384 -DMCL_STATIC_CODE
	bin/pairing_static.exe

$(OBJ_DIR)/$(MSM)_test.o: src/$(MSM).cpp
	$(PRE)$(CXX) -c $< -o $@ $(CFLAGS) -mavx512f -mavx512ifma -std=c++11 $(CFLAGS_USER) -DMCL_MSM_TEST
MSM_TEST_OBJ=$(OBJ_DIR)/$(MSM)_test.o $(filter-out $(OBJ_DIR)/msm_avx.o,$(LIB_OBJ))
$(EXE_DIR)/msm_test.exe: $(MSM_TEST_OBJ) $(MCL_LIB)
	$(PRE)$(CXX) -o $@ $(MSM_TEST_OBJ) $(LDFLAGS)
-include $(OBJ_DIR)/msm_test.d

make_tbl:
	$(MAKE) ../bls/src/qcoeff-bn254.hpp

../bls/src/qcoeff-bn254.hpp:  $(MCL_LIB) misc/precompute.cpp
	$(CXX) -o misc/precompute misc/precompute.cpp $(CFLAGS) $(MCL_LIB) $(LDFLAGS)
	./misc/precompute > ../bls/src/qcoeff-bn254.hpp

MCL_STANDALONE?=-std=c++03 -O3 -fpic -fno-exceptions -fno-threadsafe-statics -fno-rtti -fno-stack-protector -fpic -I ./include -DNDEBUG -DMCL_STANDALONE -DMCL_SIZEOF_UNIT=$(MCL_SIZEOF_UNIT) -DMCL_FP_BIT=384 -D_FORTIFY_SOURCE=0 -DMCL_USE_LLVM=1 $(CFLAGS_EXTRA)
ifneq ($(CLANG_TARGET),)
  MCL_STANDALONE+=-target $(CLANG_TARGET)
endif
fp.o: src/fp.cpp
	$(CLANG) -c $< $(MCL_STANDALONE)
base$(BIT).o: src/base$(BIT).ll
	$(CLANG) -c $< $(MCL_STANDALONE)
bint$(BIT).o: src/bint$(BIT).ll
	$(CLANG) -c $< $(MCL_STANDALONE)
libmcl.a: fp.o base$(BIT).o bint$(BIT).o
	$(AR) $(ARFLAGS) $@ fp.o base$(BIT).o bint$(BIT).o
# e.g. make CLANG=clang++-12 CLANG_TARGET=aarch64 standalone
standalone: libmcl.a
clean_standalone:
	$(RM) libmcl.a

update_xbyak:
	cp -a ../xbyak/xbyak/xbyak.h ../xbyak/xbyak/xbyak_util.h ../xbyak/xbyak/xbyak_mnemonic.h src/xbyak/

update_s_xbyak:
	cp -a ../s_xbyak/s_xbyak.py src/

update_cybozulib:
	cp -a $(addprefix ../cybozulib/,$(wildcard include/cybozu/*.hpp)) include/cybozu/

ANDROID_TARGET=armeabi-v7a arm64-v8a x86_64
NDK_BUILD?=ndk-build
android: $(BASE_LL)
	@$(NDK_BUILD) -C android/jni NDK_DEBUG=0 MCL_LIB_SHARED=$(MCL_LIB_SHARED)
	@for target in $(ANDROID_TARGET); do \
		mkdir -p lib/android/$$target; \
		cp android/obj/local/$$target/libmcl.a lib/android/$$target/; \
	done

clean:
	$(RM) $(LIB_DIR)/*.a $(LIB_DIR)/*.$(LIB_SUF) $(OBJ_DIR)/*.o $(OBJ_DIR)/*.obj $(OBJ_DIR)/*.d $(EXE_DIR)/*.exe $(GEN_EXE) src/static_code.asm src/dump_code lib/android
	$(RM) src/gen_bint.exe
	$(MAKE) clean_standalone

clean_gen:
	$(RM) src/asm/bint* src/bint_switch.hpp

MCL_VER=$(shell awk '/static const int version/ { printf("%.2f\n", substr($$6,3,3)/100)}' include/mcl/op.hpp)
CMakeLists.txt: include/mcl/op.hpp
	sed -i -e 's/	VERSION [0-9].[0-9][0-9]$$/	VERSION $(MCL_VER)/' $@
update_version:
	$(MAKE) CMakeLists.txt

ALL_SRC=$(SRC_SRC) $(TEST_SRC) $(SAMPLE_SRC)
DEPEND_FILE=$(addprefix $(OBJ_DIR)/, $(addsuffix .d,$(basename $(ALL_SRC))))
-include $(DEPEND_FILE)

PREFIX?=/usr/local
install: lib/libmcl.a lib/libmcl.$(LIB_SUF)
	$(MKDIR) $(PREFIX)/include/mcl
	cp -a include/mcl $(PREFIX)/include/
	cp -a include/cybozu $(PREFIX)/include/
	$(MKDIR) $(PREFIX)/lib
	cp -a lib/libmcl.a lib/libmcl.$(LIB_SUF) $(PREFIX)/lib/

.PHONY: test she-wasm bin/emu android update_bint_x64_asm

# don't remove these files automatically
.SECONDARY: $(addprefix $(OBJ_DIR)/, $(ALL_SRC:.cpp=.o))

