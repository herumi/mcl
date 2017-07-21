cmake_minimum_required (VERSION 2.6)
project(mcl CXX ASM)
set(SRCS src/fp.cpp)

option(
	MCL_MAX_BIT_SIZE
	"max bit size for Fp"
	0
)
option(
	DOWNLOAD_SOURCE
	"download xbyak, cybozulib"
	OFF
)
set(DOWNLOAD_SOURCE ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

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

	if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
		add_definitions(-DMCL_USE_LLVM=1)
		set(SRCS ${SRCS} src/asm/aarch64.s)
		set(CPU arch64)
	elseif(APPLE)
		add_definitions(-DMCL_USE_LLVM=1)
		set(SRCS ${SRCS} src/asm/x86-64mac.s src/asm/x86-64mac.bmi2.s)
		set(CPU x86-64)
	elseif(UNIX)
		add_definitions(-DMCL_USE_LLVM=1)
		set(SRCS ${SRCS} src/asm/x86-64.s src/asm/x86-64.bmi2.s)
		set(CPU x86-64)
	endif()
	set(LIBS mcl gmp gmpxx crypto)
endif()

if(DOWNLOAD_SOURCE)
	set(XBYAK_TAG v5.43)
	foreach(file IN ITEMS xbyak.h xbyak_util.h xbyak_mnemonic.h)
		file(DOWNLOAD https://raw.githubusercontent.com/herumi/xbyak/${XBYAK_TAG}/xbyak/${file} ${mcl_SOURCE_DIR}/include/xbyak/${file})
		message("download xbyak/" ${file})
	endforeach()

	set(CYBOZULIB_TAG release20170711)
	set(CYBOZULIB_FILES atoi.hpp bit_operation.hpp endian.hpp hash.hpp itoa.hpp random_generator.hpp unordered_map.hpp benchmark.hpp crypto.hpp exception.hpp inttype.hpp option.hpp test.hpp xorshift.hpp link_mpir.hpp link_libeay32.hpp link_ssleay32.hpp critical_section.hpp mutex.hpp)
	foreach(file IN ITEMS ${CYBOZULIB_FILES})
		file(DOWNLOAD https://raw.githubusercontent.com/herumi/cybozulib/${CYBOZULIB_TAG}/include/cybozu/${file} ${mcl_SOURCE_DIR}/include/cybozu/${file})
		message("download cybozu/" ${file})
	endforeach()

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
	include_directories(
		${mcl_SOURCE_DIR}/../cybozulib/include
		${mcl_SOURCE_DIR}/../xbyak
		${mcl_SOURCE_DIR}/../cybozulib_ext/include
	)
	if(MSVC)
		include_directories(
			${mcl_SOURCE_DIR}/../cybozulib_ext/include
		)
	endif()
endif()

include_directories(
	${mcl_SOURCE_DIR}/include
)

add_library(mcl STATIC ${SRCS})
if(NOT MSVC)
add_library(mcl_dy SHARED ${SRCS})
endif()

file(GLOB MCL_HEADERS include/mcl/*.hpp include/mcl/*.h)
file(GLOB CYBOZULIB_HEADERS include/cybozu/*.hpp)

install(TARGETS mcl DESTINATION lib)
if(NOT MSVC)
install(TARGETS mcl_dy DESTINATION lib)
endif()
install(FILES ${MCL_HEADERS} DESTINATION include/mcl)
install(FILES ${CYBOZULIB_HEADERS} DESTINATION include/cybozu)

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
