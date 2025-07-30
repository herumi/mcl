cmake_minimum_required (VERSION 3.10)

project(mcl
	VERSION 1.74
	LANGUAGES CXX C ASM)

if(NOT DEFINED CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release")
endif()

set(MCL_FP_BIT 384 CACHE STRING "max bit size for Fp")
set(MCL_FR_BIT 256 CACHE STRING "max bit size for Fr")

option(
	MCL_STANDALONE
	"build without standard library"
	OFF
)

set(MCL_CFLAGS_STANDALONE -fno-threadsafe-statics -fno-exceptions -fno-rtti -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION CACHE STRING "add user defined CFLAGS")

option(
	MCL_USE_GMP
	"Use GMP for the main library"
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
	MCL_USE_LLVM
	"use base64.ll with -DCMAKE_CXX_COMPILER=clang++"
	ON
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

#if(MSVC)
#	set(MCL_CYBOZULIB_EXT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/../cybozulib_ext"
#		CACHE PATH "external cybozulib_ext directory")
#endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(BIT "64")
else()
	set(BIT "32")
endif()
#message("CMAKE_SIZEOF_VOID_P is ${CMAKE_SIZEOF_VOID_P}")
#message("BIT is ${BIT}")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Check if we need special Windows ARM64 handling first
set(CLANG_WINDOWS_ARM64 FALSE)
if(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64" AND WIN32)
	# Find Visual Studio installation dynamically
	set(PROGRAM_FILES_X86 "ProgramFiles(x86)")
	find_program(VS_CLANG clang++.exe 
		PATHS "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Enterprise/VC/Tools/Llvm/ARM64/bin"
		      "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Professional/VC/Tools/Llvm/ARM64/bin"
		      "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Community/VC/Tools/Llvm/ARM64/bin"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Enterprise/VC/Tools/Llvm/ARM64/bin"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Professional/VC/Tools/Llvm/ARM64/bin"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Community/VC/Tools/Llvm/ARM64/bin")
	if(VS_CLANG)
		set(CLANG_WINDOWS_ARM64 TRUE)
		message("Found Clang for ARM64: ${VS_CLANG}")
	endif()
endif()

if(CLANG_WINDOWS_ARM64)
	# For Windows ARM64 with Clang, create empty targets and add objects later
	add_library(mcl SHARED)
	add_library(mcl_st STATIC)
	# Set the linker language explicitly since we have no initial sources
	set_target_properties(mcl PROPERTIES LINKER_LANGUAGE CXX)
	set_target_properties(mcl_st PROPERTIES LINKER_LANGUAGE CXX)
else()
	# For other platforms, create targets with normal sources
	add_library(mcl SHARED src/fp.cpp)
	add_library(mcl_st STATIC src/fp.cpp)
endif()
add_library(mcl::mcl ALIAS mcl)
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

add_library(mcl::mcl_st ALIAS mcl_st)
target_include_directories(mcl_st PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:$CMAKE_INSTALL_DIR/include>)
set_target_properties(mcl_st PROPERTIES
	OUTPUT_NAME mcl
	POSITION_INDEPENDENT_CODE ON)
#set_target_properties(mcl_st PROPERTIES PREFIX "lib")

target_compile_definitions(mcl PUBLIC MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT})
target_compile_definitions(mcl_st PUBLIC MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT})

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
else()
	# Set compiler flags for warnings
	set(MCL_COMPILE_OPTIONS -Wall -Wextra -Wformat=2 -Wcast-qual -Wcast-align
		-Wwrite-strings -Wfloat-equal -Wpointer-arith -DNDEBUG -O3 -fPIC)
endif()

if (${MCL_USE_GMP})
	list(APPEND MCL_COMPILE_OPTIONS -DMCL_USE_GMP=1)
	target_link_libraries(mcl PRIVATE GMP::GMP)
	target_link_libraries(mcl_st PRIVATE GMP::GMP)
endif()

if (${MCL_STANDALONE})
	set(MCL_COMPILE_OPTIONS ${MCL_COMPILE_OPTIONS} ${MCL_CFLAGS_STANDALONE})
endif()
target_compile_options(mcl PRIVATE ${MCL_COMPILE_OPTIONS})
target_compile_options(mcl_st PRIVATE ${MCL_COMPILE_OPTIONS})

#	set_target_properties(mcl PROPERTIES
#		CXX_STANDARD 11
#		CXX_STANDARD_REQUIRED YES
#		CXX_EXTENSIONS NO)
#	set_target_properties(mcl_st PROPERTIES
#		CXX_STANDARD 11
#		CXX_STANDARD_REQUIRED YES
#		CXX_EXTENSIONS NO)
#	target_compile_features(mcl PUBLIC cxx_std_11)
#	target_compile_features(mcl_st PUBLIC cxx_std_11)


# use bint-x64 on x64, bint${BIT}.ll on the other CPU
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	# Find ML64 assembler dynamically
	set(PROGRAM_FILES_X86 "ProgramFiles(x86)")
	find_program(ML64 ml64.exe 
		PATHS "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Enterprise/VC/Tools/MSVC/*/bin/Hostx64/x64"
		      "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Professional/VC/Tools/MSVC/*/bin/Hostx64/x64"
		      "$ENV{ProgramFiles}/Microsoft Visual Studio/*/Community/VC/Tools/MSVC/*/bin/Hostx64/x64"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Enterprise/VC/Tools/MSVC/*/bin/Hostx64/x64"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Professional/VC/Tools/MSVC/*/bin/Hostx64/x64"
		      "$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Community/VC/Tools/MSVC/*/bin/Hostx64/x64"
		DOC "path to assembler")
	
	if(NOT ML64)
		message(FATAL_ERROR "MASM not found. Please ensure Visual Studio with MSVC tools is installed.")
	endif()
	
	message("Found MASM: ${ML64}")
	set(BINT_X64_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj")
	add_custom_command(OUTPUT ${BINT_X64_OBJ}
		COMMAND ${ML64} /c /Fo ${BINT_X64_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/asm/bint-x64-win.asm
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_bint-x64-win.obj
		SOURCES ${BINT_X64_OBJ})
	target_link_libraries(mcl PUBLIC ${BINT_X64_OBJ})
	add_dependencies(mcl gen_bint-x64-win.obj)
	target_link_libraries(mcl_st PUBLIC ${BINT_X64_OBJ})
	add_dependencies(mcl_st gen_bint-x64-win.obj)
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE)
	if (CMAKE_SYSTEM_NAME STREQUAL "MSYS")
		target_sources(mcl PRIVATE src/asm/bint-x64-mingw.S)
		target_sources(mcl_st PRIVATE src/asm/bint-x64-mingw.S)
	else()
		target_sources(mcl PRIVATE src/asm/bint-x64-amd64.S)
		target_sources(mcl_st PRIVATE src/asm/bint-x64-amd64.S)
	endif()
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64" AND WIN32)
	# For Windows ARM64, use Clang from Visual Studio for all compilation (following mklib_arm64.bat)
	if(CLANG_WINDOWS_ARM64)
		# Compile LLVM files with Clang
		set(BINT_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint${BIT}.o")
		set(BASE_OBJ "${CMAKE_CURRENT_BINARY_DIR}/base${BIT}.o")
		set(FP_OBJ "${CMAKE_CURRENT_BINARY_DIR}/fp.o")
		
		add_custom_command(OUTPUT ${BINT_OBJ}
			COMMAND ${VS_CLANG} --target=arm64-pc-windows-msvc -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll -O2 -DNDEBUG
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
		
		add_custom_command(OUTPUT ${BASE_OBJ}
			COMMAND ${VS_CLANG} --target=arm64-pc-windows-msvc -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll -O2 -DNDEBUG
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
		
		# Compile fp.cpp with Clang (like mklib_arm64.bat)
		add_custom_command(OUTPUT ${FP_OBJ}
			COMMAND ${VS_CLANG} --target=arm64-pc-windows-msvc -c -o ${FP_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp -O2 -DNDEBUG -I${CMAKE_CURRENT_SOURCE_DIR}/include -I${CMAKE_CURRENT_SOURCE_DIR}/src -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=${MCL_FP_BIT} -DMCL_FR_BIT=${MCL_FR_BIT} -DNOMINMAX
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp)
		
		add_custom_target(gen_bint.o SOURCES ${BINT_OBJ})
		add_custom_target(gen_base.o SOURCES ${BASE_OBJ})
		add_custom_target(gen_fp.o SOURCES ${FP_OBJ})
		
		# Add the compiled objects as sources to the targets
		target_sources(mcl PRIVATE ${BINT_OBJ} ${BASE_OBJ} ${FP_OBJ})
		target_sources(mcl_st PRIVATE ${BINT_OBJ} ${BASE_OBJ} ${FP_OBJ})
		
		target_link_libraries(mcl PUBLIC ${BINT_OBJ} ${BASE_OBJ} ${FP_OBJ})
		add_dependencies(mcl gen_bint.o gen_base.o gen_fp.o)
		target_link_libraries(mcl_st PUBLIC ${BINT_OBJ} ${BASE_OBJ} ${FP_OBJ})
		add_dependencies(mcl_st gen_bint.o gen_base.o gen_fp.o)
		
		# Find and link Clang runtime library for ARM64
		set(PROGRAM_FILES_X86 "ProgramFiles(x86)")
		file(GLOB VS_CLANG_RT_DIRS 
			"$ENV{ProgramFiles}/Microsoft Visual Studio/*/Enterprise/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows"
			"$ENV{ProgramFiles}/Microsoft Visual Studio/*/Professional/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows"
			"$ENV{ProgramFiles}/Microsoft Visual Studio/*/Community/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows"
			"$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Enterprise/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows"
			"$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Professional/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows"
			"$ENV{${PROGRAM_FILES_X86}}/Microsoft Visual Studio/*/Community/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows")
		
		if(VS_CLANG_RT_DIRS)
			list(GET VS_CLANG_RT_DIRS 0 CLANG_RT_PATH)
			message("Found Clang runtime path: ${CLANG_RT_PATH}")
			find_library(CLANG_RT_LIB clang_rt.builtins-aarch64 PATHS ${CLANG_RT_PATH} NO_DEFAULT_PATH)
			if(CLANG_RT_LIB)
				message("Found Clang runtime library: ${CLANG_RT_LIB}")
				target_link_libraries(mcl PUBLIC ${CLANG_RT_LIB})
				target_link_libraries(mcl_st PUBLIC ${CLANG_RT_LIB})
			endif()
		endif()
		
		# Add necessary Windows system libraries for Clang ARM64 builds
		target_link_libraries(mcl PUBLIC 
			kernel32.lib 
			msvcrt.lib
			vcruntime.lib
			ucrt.lib)
		target_link_libraries(mcl_st PUBLIC 
			kernel32.lib 
			libcmt.lib
			libvcruntime.lib
			libucrt.lib)
	else()
		message(WARNING "Visual Studio Clang for ARM64 not found, falling back to pure C++ implementation")
		target_compile_definitions(mcl PUBLIC MCL_BINT_ASM=0)
		target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM=0)
		target_compile_definitions(mcl PUBLIC MCL_BINT_ASM_X64=0)
		target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM_X64=0)
	endif()
else()
	if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang")
		message(FATAL_ERROR "requiring clang++. cmake -DCMAKE_CXX_COMPILER=clang++ ..")
	endif()
	set(BINT_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint${BIT}.o")
	message("bint_obj=" ${BINT_OBJ})
	target_compile_definitions(mcl PUBLIC MCL_BINT_ASM_X64=0)
	target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM_X64=0)

	add_custom_command(OUTPUT ${BINT_OBJ}
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll -O3 -fPIC
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_bint.o
		SOURCES ${BINT_OBJ})
	target_link_libraries(mcl PUBLIC ${BINT_OBJ})
	add_dependencies(mcl gen_bint.o)
	target_link_libraries(mcl_st PUBLIC ${BINT_OBJ})
	add_dependencies(mcl_st gen_bint.o)
	target_sources(mcl_st PRIVATE ${BINT_OBJ})
endif()

# use generated asm or compile base${BIT}.ll by clang

if (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE AND NOT CMAKE_SYSTEM_NAME STREQUAL "MSYS")
  set(X86_64_LINUX TRUE)
else()
  set(X86_64_LINUX FALSE)
endif()

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	# skip
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "ARM64" AND WIN32)
	message("Windows ARM64 base compilation handled with bint compilation")
elseif(X86_64_LINUX)
	target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
	target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)
	target_sources(mcl PRIVATE src/asm/x86-64.S)
	target_sources(mcl_st PRIVATE src/asm/x86-64.S)
elseif(${MCL_USE_LLVM})
	set(BASE_OBJ "${CMAKE_CURRENT_BINARY_DIR}/base${BIT}.o")
	message("base_obj=" ${BASE_OBJ})
	target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
	target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)

	add_custom_command(OUTPUT ${BASE_OBJ}
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll -O3 -fPIC
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_base.o
		SOURCES ${BASE_OBJ})
	target_link_libraries(mcl PUBLIC ${BASE_OBJ})
	add_dependencies(mcl gen_base.o)
	target_link_libraries(mcl_st PUBLIC ${BASE_OBJ})
	add_dependencies(mcl_st gen_base.o)
	target_sources(mcl_st PRIVATE ${BASE_OBJ})
endif()

# use src/msm_avx.cpp on x64
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
#	set(MSM_OBJ "${CMAKE_CURRENT_BINARY_DIR}/msm_avx.obj")

#	add_custom_command(OUTPUT ${MSM_OBJ}
#		COMMAND ${CMAKE_CXX_COMPILER} /c /Fo:${MSM_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/msm_avx.cpp -I ${CMAKE_CURRENT_SOURCE_DIR}/include /arch:AVX512 /Ox /Oy /Gm- /EHsc /MT /GS- /DCYBOZU_DONT_USE_STRING /DCYBOZU_DONT_USE_EXCEPTION  /DNDEBUG /DMCL_NO_AUTOLINK /DMCLBN_NO_AUTOLINK /DNOMINMAX
#		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
#	add_custom_target(msm_avx.o
#		SOURCES ${MSM_OBJ})
#	target_link_libraries(mcl PUBLIC ${MSM_OBJ})
#	add_dependencies(mcl msm_avx.o)
#	target_link_libraries(mcl_st PUBLIC ${MSM_OBJ})
#	add_dependencies(mcl_st msm_avx.o)
#	target_sources(mcl_st PRIVATE ${MSM_OBJ})

elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE)
	set(MSM_OBJ "${CMAKE_CURRENT_BINARY_DIR}/msm_avx.o")

	add_custom_command(OUTPUT ${MSM_OBJ}
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${MSM_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/msm_avx.cpp ${MCL_COMPILE_OPTIONS} -I ${CMAKE_CURRENT_SOURCE_DIR}/include -mavx512f -mavx512ifma -std=c++11 -fno-rtti -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION -DNDEBUG
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(msm_avx.o
		SOURCES ${MSM_OBJ})
	target_link_libraries(mcl PUBLIC ${MSM_OBJ})
	add_dependencies(mcl msm_avx.o)
	target_link_libraries(mcl_st PUBLIC ${MSM_OBJ})
	add_dependencies(mcl_st msm_avx.o)
	target_sources(mcl_st PRIVATE ${MSM_OBJ})
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

install(TARGETS mcl mcl_st
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
if(MCL_BUILD_TESTING)
	enable_testing()
	add_subdirectory(test)
endif()

if(MCL_BUILD_SAMPLE)
	# sample code
	add_subdirectory(sample)
endif()
