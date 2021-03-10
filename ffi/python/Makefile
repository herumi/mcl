include ../../common.mk

SHE384_256_SLIB=libmclshe384_256.$(LIB_SUF)

she_test: ../../lib/$(SHE384_256_SLIB)
	env LD_LIBRARY_PATH=../../lib python3 she.py

../../lib/$(SHE384_256_SLIB):
	make -C ../../ lib/$(SHE384_256_SLIB)
