cmake_minimum_required (VERSION 2.6)
project(mcl CXX ASM)
set(LIBS mcl gmp gmpxx crypto)
set(SRCS src/fp.cpp)

option(
	MCL_MAX_BIT_SIZE
	"max bit size for Fp"
	0
)

if("${CFLAGS_OPT_USER}" STREQUAL "")
	set(CFLAGS_OPT_USER "-O3 -DNDEBUG -march=native")
endif()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align -Wwrite-strings -Wfloat-equal -Wpointer-arith ${CFLAGS_OPT_USER}")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

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

include_directories(
	${mcl_SOURCE_DIR}/include
	${mcl_SOURCE_DIR}/../cybozulib/include
	${mcl_SOURCE_DIR}/../xbyak
)

add_library(mcl STATIC ${SRCS})
add_library(mcl_dy SHARED ${SRCS})

file(GLOB MCL_HEADERS include/mcl/*.hpp include/mcl/*.h)
file(GLOB CYBOZULIB_HEADERS ../cybozulib/include/cybozu/*.hpp)

install(TARGETS mcl DESTINATION lib)
install(TARGETS mcl_dy DESTINATION lib)
install(FILES ${MCL_HEADERS} DESTINATION include/mcl)
install(FILES ${CYBOZULIB_HEADERS} DESTINATION include/cybozu)

set(TEST_BASE fp_test ec_test fp_util_test window_method_test elgamal_test fp_tower_test gmp_test bn_test glv_test)
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
