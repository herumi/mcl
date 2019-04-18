cmake_minimum_required (VERSION 3.0)
project(mcl CXX ASM)
set(SRCS src/fp.cpp)

option(
	MCL_MAX_BIT_SIZE
	"max bit size for Fp"
	0
)
option(
	DOWNLOAD_SOURCE
	"download cybozulib_ext"
	OFF
)
option(
	USE_OPENSSL
	"use openssl"
	ON
)
option(
	USE_GMP
	"use gmp"
	ON
)
option(
	USE_ASM
	"use asm"
	ON
)
option(
	USE_XBYAK
	"use xbyak"
	ON
)
option(
	USE_LLVM
	"use base64.ll with -DCMAKE_CXX_COMPILER=clang++"
	OFF
)
option(
	ONLY_LIB
	"only lib"
	OFF
)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(USE_LLVM)
	add_executable(gen src/gen.cpp)
	add_custom_target(base64.ll
		DEPENDS gen
		SOURCES base64.ll
	)
	add_custom_command(OUTPUT base64.ll
		COMMAND gen > base64.ll
	)
	add_custom_target(base64.o
		DEPENDS base64.ll
		SOURCES base64.o
	)
	add_custom_command(OUTPUT base64.o
		COMMAND ${CMAKE_CXX_COMPILER} -c -o base64.o base64.ll -O3 -fPIC
	)
endif()

if(MSVC)
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MT /W4 /Oy /Ox /EHsc /GS- /Zi /DNDEBUG /DNOMINMAX")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MTd /W4 /DNOMINMAX")
	link_directories(${CMAKE_SOURCE_DIR}/../cybozulib_ext/lib)
	link_directories(${CMAKE_SOURCE_DIR}/lib)
else()
	if("${CFLAGS_OPT_USER}" STREQUAL "")
		set(CFLAGS_OPT_USER "-O3 -DNDEBUG -march=native")
	endif()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wfloat-equal -Wpointer-arith ${CFLAGS_OPT_USER}")

	if(${MCL_MAX_BIT_SIZE} GREATER 0)
		add_definitions(-DMCL_MAX_BIT_SIZE=${MCL_MAX_BIT_SIZE})
	endif()

	if(USE_LLVM)
		add_definitions(-DMCL_USE_LLVM=1 -DMCL_LLVM_BMI2=0)
	elseif(USE_ASM)
		if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
			add_definitions(-DMCL_USE_LLVM=1)
			set(SRCS ${SRCS} src/asm/aarch64.s)
			set(CPU arch64)
		elseif(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^arm")
			add_definitions(-DMCL_USE_LLVM=1)
			set(SRCS ${SRCS} src/asm/arm.s)
			set(CPU arm)
		elseif(APPLE)
			add_definitions(-DMCL_USE_LLVM=1)
			set(SRCS ${SRCS} src/asm/x86-64mac.s src/asm/x86-64mac.bmi2.s)
			set(CPU x86-64)
		elseif(UNIX)
			add_definitions(-DMCL_USE_LLVM=1)
			set(SRCS ${SRCS} src/asm/x86-64.s src/asm/x86-64.bmi2.s)
			set(CPU x86-64)
		endif()
	endif()
	if(USE_GMP)
		set(EXT_LIBS ${EXT_LIBS} gmp gmpxx)
	endif()
	if(USE_OPENSSL)
		set(EXT_LIBS ${EXT_LIBS} crypto)
	endif()
endif()

if(NOT USE_GMP)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMCL_USE_VINT -DMCL_VINT_FIXED_BUFFER")
endif()
if(NOT USE_OPENSSL)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMCL_DONT_USE_OPENSSL")
endif()
if(NOT USE_XBYAK)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMCL_DONT_USE_XBYAK")
endif()

if(DOWNLOAD_SOURCE)
	if(MSVC)
		set(CYBOZULIB_EXT_TAG release20170521)
		set(FILES config.h gmp-impl.h gmp-mparam.h gmp.h gmpxx.h longlong.h mpir.h mpirxx.h)
		foreach(file IN ITEMS ${FILES})
			file(DOWNLOAD https://raw.githubusercontent.com/herumi/cybozulib_ext/${CYBOZULIB_EXT_TAG}/include/${file} ${mcl_SOURCE_DIR}/include/cybozulib_ext/${file})
			message("download cybozulib_ext/" ${file})
		endforeach()
		set(FILES aes.h applink.c asn1.h asn1_mac.h asn1t.h bio.h blowfish.h bn.h buffer.h camellia.h cast.h cmac.h cms.h comp.h conf.h conf_api.h crypto.h des.h des_old.h dh.h dsa.h dso.h dtls1.h e_os2.h ebcdic.h ec.h ecdh.h ecdsa.h engine.h err.h evp.h hmac.h idea.h krb5_asn.h kssl.h lhash.h md4.h md5.h mdc2.h modes.h obj_mac.h objects.h ocsp.h opensslconf.h opensslv.h ossl_typ.h pem.h pem2.h pkcs12.h pkcs7.h pqueue.h rand.h rc2.h rc4.h ripemd.h rsa.h safestack.h seed.h sha.h srp.h srtp.h ssl.h ssl2.h ssl23.h ssl3.h stack.h symhacks.h tls1.h ts.h txt_db.h ui.h ui_compat.h whrlpool.h x509.h x509_vfy.h x509v3.h)
		foreach(file IN ITEMS ${FILES})
			file(DOWNLOAD https://raw.githubusercontent.com/herumi/cybozulib_ext/${CYBOZULIB_EXT_TAG}/include/openssl/${file} ${mcl_SOURCE_DIR}/include/cybozulib_ext/openssl/${file})
			message("download cybozulib_ext/openssl/" ${file})
		endforeach()
		set(FILES mpir.lib mpirxx.lib mpirxx.pdb ssleay32.lib libeay32.lib mpir.pdb)
		foreach(file IN ITEMS ${FILES})
			file(DOWNLOAD https://raw.githubusercontent.com/herumi/cybozulib_ext/${CYBOZULIB_EXT_TAG}/lib/mt/14/${file} ${mcl_SOURCE_DIR}/lib/mt/14/${file})
			message("download lib/mt/14/" ${file})
		endforeach()
		if(MSVC)
			include_directories(
				${mcl_SOURCE_DIR}/include/cybozulib_ext
			)
		endif()
	endif()
else()
	if(MSVC)
		include_directories(
			${mcl_SOURCE_DIR}/../cybozulib_ext/include
		)
	endif()
endif()

include_directories(
	${mcl_SOURCE_DIR}/include
)

if(USE_LLVM)
	add_library(mcl SHARED ${SRCS} base64.o)
	add_library(mcl_st STATIC ${SRCS} base64.o)
	add_dependencies(mcl base64.o)
	add_dependencies(mcl_st base64.o)
else()
	add_library(mcl SHARED ${SRCS})
	add_library(mcl_st STATIC ${SRCS})
endif()
target_link_libraries(mcl ${EXT_LIBS})
target_link_libraries(mcl_st ${EXT_LIBS})
set_target_properties(mcl_st PROPERTIES OUTPUT_NAME mcl)
#set_target_properties(mcl_st PROPERTIES PREFIX "lib")
#set_target_properties(mcl PROPERTIES OUTPUT_NAME mcl VERSION 1.0.0 SOVERSION 1)
# For semantics of ABI compatibility including when you must bump SOVERSION, see:
# https://community.kde.org/Policies/Binary_Compatibility_Issues_With_C%2B%2B#The_Do.27s_and_Don.27ts

set(LIBS mcl ${EXT_LIBS})
foreach(bit IN ITEMS 256 384 384_256 512)
	add_library(mclbn${bit} SHARED src/bn_c${bit}.cpp)
	target_link_libraries(mclbn${bit} ${LIBS})
	add_executable(bn_c${bit}_test test/bn_c${bit}_test.cpp)
	target_link_libraries(bn_c${bit}_test mclbn${bit})
endforeach()

file(GLOB MCL_HEADERS include/mcl/*.hpp include/mcl/bn.h include/mcl/curve_type.h)
file(GLOB CYBOZULIB_HEADERS include/cybozu/*.hpp)

install(TARGETS mcl DESTINATION lib)
install(TARGETS mcl_st DESTINATION lib)
install(TARGETS mclbn256 DESTINATION lib)
install(TARGETS mclbn384 DESTINATION lib)
install(TARGETS mclbn384_256 DESTINATION lib)
install(TARGETS mclbn512 DESTINATION lib)
install(FILES ${MCL_HEADERS} DESTINATION include/mcl)
install(FILES include/mcl/impl/bn_c_impl.hpp DESTINATION include/mcl/impl)
install(FILES ${CYBOZULIB_HEADERS} DESTINATION include/cybozu)

if(NOT ONLY_LIB)
	set(TEST_BASE fp_test ec_test fp_util_test window_method_test elgamal_test fp_tower_test gmp_test bn_test glv_test)
	#set(TEST_BASE bn_test)
	foreach(base IN ITEMS ${TEST_BASE})
		add_executable(
			${base}
			test/${base}.cpp
		)
		target_link_libraries(
			${base}
			${LIBS}
		)
	endforeach()
endif()
