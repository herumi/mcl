cmake_minimum_required (VERSION 3.8)

project(mcl
	VERSION 1.64
	LANGUAGES CXX C ASM)

if(NOT DEFINED CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release")
endif()

option(
	MCL_MAX_BIT_SIZE
	"max bit size for Fp"
	384
)
option(
	MCL_STATIC_LIB
	"build static library"
	OFF
)
if(MSVC)
	set(MCL_TEST_WITH_GMP_DEFAULT OFF)
else()
	set(MCL_TEST_WITH_GMP_DEFAULT ON)
endif()
option(
	MCL_TEST_WITH_GMP
	"(Windows) download MPIR libraries from cybozulib_ext"
	${MCL_TEST_WITH_GMP_DEFAULT}
)
option(
	MCL_USE_ASM
	"use asm"
	ON
)
option(
	MCL_USE_LLVM
	"use base64.ll with -DCMAKE_CXX_COMPILER=clang++"
	OFF
)
option(
	MCL_BUILD_SAMPLE
	"Build mcl samples"
	OFF
)
option(
	MCL_BUILD_TESTING
	"Build mcl tests"
	OFF
)
if(MSVC)
	option(
		MCL_MSVC_RUNTIME_DLL
		"use dynamic runtime /MD in msvc builds"
		OFF
	)
endif()


if(MSVC)
	set(MCL_CYBOZULIB_EXT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../cybozulib_ext"
		CACHE PATH "external cybozulib_ext directory")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(MCL_USE_LLVM AND NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")
	message(WARNING "MCL_USE_LLVM will not be used: requiring clang/clang++.")
endif()

add_library(mcl SHARED src/fp.cpp)
add_library(mcl::mcl ALIAS mcl)
target_compile_definitions(mcl PUBLIC MCL_NO_AUTOLINK MCLBN_NO_AUTOLINK)
target_include_directories(mcl PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:$CMAKE_INSTALL_DIR/include>)
set_target_properties(mcl PROPERTIES
	POSITION_INDEPENDENT_CODE ON)
set_target_properties(mcl PROPERTIES
	OUTPUT_NAME mcl
	VERSION ${mcl_VERSION}
	SOVERSION ${mcl_VERSION_MAJOR})
# For semantics of ABI compatibility including when you must bump SOVERSION, see:
# https://community.kde.org/Policies/Binary_Compatibility_Issues_With_C%2B%2B#The_Do.27s_and_Don.27ts

add_library(mcl_st STATIC src/fp.cpp)
add_library(mcl::mcl_st ALIAS mcl_st)
target_compile_definitions(mcl_st PUBLIC MCL_NO_AUTOLINK MCLBN_NO_AUTOLINK)
target_include_directories(mcl_st PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:$CMAKE_INSTALL_DIR/include>)
set_target_properties(mcl_st PROPERTIES
	OUTPUT_NAME mcl
	POSITION_INDEPENDENT_CODE ON)
#set_target_properties(mcl_st PROPERTIES PREFIX "lib")

if(MCL_USE_LLVM AND CMAKE_CXX_COMPILER_ID MATCHES "Clang")
	add_executable(gen src/gen.cpp)
	target_include_directories(gen PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/include)

	add_custom_command(OUTPUT base64.ll
		COMMAND gen > base64.ll
		DEPENDS gen
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_base64.ll
		SOURCES ${CMAKE_CURRENT_BINARY_DIR}/base64.ll)

	add_custom_command(OUTPUT base64.o
		COMMAND ${CMAKE_CXX_COMPILER} -c -o base64.o base64.ll -O3 -fPIC
		DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/base64.ll
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_base64.o
		SOURCES ${CMAKE_CURRENT_BINARY_DIR}/base64.o)

	target_link_libraries(mcl PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/base64.o)
	add_dependencies(mcl gen_base64.o)
	target_link_libraries(mcl_st PRIVATE ${CMAKE_CURRENT_BINARY_DIR}/base64.o)
	add_dependencies(mcl_st gen_base64.o)
endif()

if(MSVC)
	if(MCL_MSVC_RUNTIME_DLL)
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MD /Oy /Ox /EHsc /GS- /Zi /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MDd")
	else()
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MT /Oy /Ox /EHsc /GS- /Zi /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MTd")
	endif()

	target_compile_definitions(mcl PUBLIC NOMINMAX)
	target_compile_definitions(mcl_st PUBLIC NOMINMAX)
	# set compiler flags for warnings level
	set(MCL_COMPILE_OPTIONS /W4)
	target_compile_options(mcl PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_options(mcl_st PRIVATE ${MCL_COMPILE_OPTIONS})
else()
	# Set compiler flags for warnings
	set(MCL_COMPILE_OPTIONS -Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align
		-Wwrite-strings -Wfloat-equal -Wpointer-arith -DNDEBUG -O3 -fPIC)

	target_compile_options(mcl PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_options(mcl_st PRIVATE ${MCL_COMPILE_OPTIONS})
	set_target_properties(mcl PROPERTIES
		CXX_STANDARD 11
		CXX_STANDARD_REQUIRED YES
		CXX_EXTENSIONS NO)
	set_target_properties(mcl_st PROPERTIES
		CXX_STANDARD 11
		CXX_STANDARD_REQUIRED YES
		CXX_EXTENSIONS NO)
	target_compile_features(mcl PUBLIC cxx_std_11)
	target_compile_features(mcl_st PUBLIC cxx_std_11)

	if(${MCL_MAX_BIT_SIZE} GREATER 0)
		target_compile_definitions(mcl PUBLIC MCL_MAX_BIT_SIZE=${MCL_MAX_BIT_SIZE})
		target_compile_definitions(mcl_st PUBLIC MCL_MAX_BIT_SIZE=${MCL_MAX_BIT_SIZE})
	endif()

	if(MCL_USE_LLVM AND CMAKE_CXX_COMPILER_ID MATCHES "Clang")
		target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
		target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
	elseif(MCL_USE_ASM)
		if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
			target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
			target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
			target_sources(mcl PRIVATE src/asm/aarch64.s)
			target_sources(mcl_st PRIVATE src/asm/aarch64.s)
			set(CPU arch64)
		elseif(${CMAKE_SYSTEM_PROCESSOR} MATCHES "^arm")
			target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
			target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
			target_sources(mcl PRIVATE src/asm/arm.s)
			target_sources(mcl_st PRIVATE src/asm/arm.s)
			set(CPU arm)
		elseif(APPLE)
			target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
			target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
			target_sources(mcl PRIVATE src/asm/x86-64mac.s)
			target_sources(mcl_st PRIVATE src/asm/x86-64mac.s)
			set(CPU x86-64)
		elseif(UNIX)
			target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
			target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
			target_sources(mcl PRIVATE src/asm/x86-64.s)
			target_sources(mcl_st PRIVATE src/asm/x86-64.s)
			set(CPU x86-64)
		endif()
	endif()
endif()

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
	find_program(ML64 ml64.exe HINTS "${cl_path}" DOC "path to assembler")
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj
		COMMAND ${ML64} -c ${CMAKE_CURRENT_SOURCE_DIR}/src/asm/bint-x64-win.asm -o ${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_bint-x64-win.obj
		SOURCES ${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj)
	target_link_libraries(mcl PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj)
	add_dependencies(mcl gen_bint-x64-win.obj)
	target_link_libraries(mcl_st PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj)
	add_dependencies(mcl_st gen_bint-x64-win.obj)
	target_compile_definitions(mcl PUBLIC MCL_BINT_ASM=1)
	target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM=1)
endif()

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
	target_compile_definitions(mcl PUBLIC MCL_BINT_ASM=1)
	target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM=1)
	target_sources(mcl PRIVATE src/asm/bint-x64-amd64.s)
	target_sources(mcl_st PRIVATE src/asm/bint-x64-amd64.s)
endif()

if(MCL_TEST_WITH_GMP)
	if(NOT MSVC)
		find_package(GMP REQUIRED)
	else()
		set(CYBOZULIB_EXT_DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/cybozulib_ext)
		set(CYBOZULIB_EXT_TAG release20170521)
		set(FILES config.h gmp-impl.h gmp-mparam.h gmp.h gmpxx.h longlong.h mpir.h mpirxx.h)
		foreach(file IN ITEMS ${FILES})
			file(DOWNLOAD https://raw.githubusercontent.com/herumi/cybozulib_ext/${CYBOZULIB_EXT_TAG}/include/${file} ${CYBOZULIB_EXT_DOWNLOAD_DIR}/include/${file})
			message("download cybozulib_ext/" ${file})
		endforeach()
		set(FILES mpir.lib mpirxx.lib mpirxx.pdb mpir.pdb)
		foreach(file IN ITEMS ${FILES})
			file(DOWNLOAD
			    https://raw.githubusercontent.com/herumi/cybozulib_ext/${CYBOZULIB_EXT_TAG}/lib/mt/14/${file} ${CYBOZULIB_EXT_DOWNLOAD_DIR}/lib/mt/14/${file})
			message("download lib/mt/14/" ${file})
		endforeach()

		# mpir
		add_library(cybozulib_ext::mpir STATIC IMPORTED)
		set_target_properties(cybozulib_ext::mpir PROPERTIES
			INTERFACE_INCLUDE_DIRECTORIES ${CYBOZULIB_EXT_DOWNLOAD_DIR}/include
			IMPORTED_LOCATION ${CYBOZULIB_EXT_DOWNLOAD_DIR}/lib/mt/14/mpir.lib)
		# mpirxx
		add_library(cybozulib_ext::mpirxx STATIC IMPORTED)
		set_target_properties(cybozulib_ext::mpirxx PROPERTIES
			INTERFACE_INCLUDE_DIRECTORIES ${CYBOZULIB_EXT_DOWNLOAD_DIR}/include
			IMPORTED_LOCATION ${CYBOZULIB_EXT_DOWNLOAD_DIR}/lib/mt/14/mpirxx.lib)
		# abstracted cybozulib_ext libraries
		add_library(windows_specific INTERFACE)
		add_library(mcl::windows_specific ALIAS windows_specific)
		target_link_libraries(windows_specific INTERFACE
			-LIBPATH:${CYBOZULIB_EXT_DOWNLOAD_DIR}/lib
			-LIBPATH:${CYBOZULIB_EXT_DOWNLOAD_DIR}/lib/mt/14
			cybozulib_ext::mpir
			cybozulib_ext::mpirxx)
	endif()
endif()

# mclbnXXX
foreach(bit IN ITEMS 256 384 384_256)
	if (MCL_STATIC_LIB)
		add_library(mclbn${bit} STATIC src/bn_c${bit}.cpp)
	else()
		add_library(mclbn${bit} SHARED src/bn_c${bit}.cpp)
	endif()
	add_library(mcl::mclbn${bit} ALIAS mclbn${bit})
	set_target_properties(mclbn${bit} PROPERTIES
		CXX_STANDARD 11
		CXX_STANDARD_REQUIRED YES
		CXX_EXTENSIONS NO)
	target_compile_options(mclbn${bit} PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_definitions(mclbn${bit}
		PUBLIC MCL_NO_AUTOLINK MCLBN_NO_AUTOLINK)
	target_link_libraries(mclbn${bit} PUBLIC mcl::mcl)
	set_target_properties(mclbn${bit} PROPERTIES
		VERSION ${mcl_VERSION}
		SOVERSION ${mcl_VERSION_MAJOR})
endforeach()

install(TARGETS mcl mcl_st mclbn256 mclbn384 mclbn384_256
	EXPORT mclTargets
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
	RUNTIME DESTINATION lib)

install(DIRECTORY include/mcl
	DESTINATION include
	FILES_MATCHING PATTERN "*.hpp"
	PATTERN "curve_type.h"
	PATTERN "bn.h"
	PATTERN "bn_c256.h"
	PATTERN "bn_c384_256.h"
	PATTERN "bn_c384.h")
install(DIRECTORY include/cybozu
	DESTINATION include
	FILES_MATCHING PATTERN "*.hpp")

install(EXPORT mclTargets
	FILE mclTargets.cmake
	NAMESPACE mcl::
	DESTINATION lib/cmake/mcl)

# support local build-tree export to allow import from external projects
export(EXPORT mclTargets
	FILE mclTargets.cmake
	NAMESPACE mcl::)
set(CMAKE_EXPORT_PACKAGE_REGISTRY ON)
export(PACKAGE mcl)


# Tests
if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MCL_BUILD_TESTING)
	AND BUILD_TESTING)
	enable_testing()
	add_subdirectory(test)
endif()

if(MCL_BUILD_SAMPLE)
	# sample code
	add_subdirectory(sample)
endif()
