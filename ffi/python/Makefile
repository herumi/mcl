include ../../common.mk

SHE384_256_SLIB=libmclshe384_256.$(LIB_SUF)

she_test: ../../lib/$(SHE384_256_SLIB)
	cd ../../lib && python3 ../ffi/python/she.py

../../lib/$(SHE384_256_SLIB):
	make -C ../../ lib/$(SHE384_256_SLIB)
