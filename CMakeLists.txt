cmake_minimum_required (VERSION 3.10)

project(mcl
	VERSION 3.03
	LANGUAGES CXX C ASM)

if(NOT DEFINED CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE "Release")
endif()

# Windows ARM64 target (x64-host cross build via the toolchain file, or ARM64
# native build). Both reach the same code path below. The architecture may come
# from CMAKE_SYSTEM_PROCESSOR (toolchain / Ninja) or from CMAKE_GENERATOR_PLATFORM
# (the Visual Studio generator with -A ARM64), in any letter case.
set(MCL_WIN_ARM64 FALSE)
if(WIN32)
	set(_mcl_target_arch "${CMAKE_SYSTEM_PROCESSOR}")
	if(CMAKE_GENERATOR_PLATFORM)
		set(_mcl_target_arch "${CMAKE_GENERATOR_PLATFORM}")
	endif()
	string(TOUPPER "${_mcl_target_arch}" _mcl_target_arch)
	if(_mcl_target_arch MATCHES "ARM64")
		set(MCL_WIN_ARM64 TRUE)
		message(STATUS "Windows ARM64 build detected")
	endif()
endif()

set(MCL_FP_BIT 384 CACHE STRING "max bit size for Fp")
set(MCL_FR_BIT 256 CACHE STRING "max bit size for Fr")

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

# GMP is not supported on Windows ARM64
if(MCL_WIN_ARM64)
	set(MCL_TEST_WITH_GMP_DEFAULT OFF)
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

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	set(BIT "64")
else()
	set(BIT "32")
endif()

# When cross-building for ARM64 the compiler checks are skipped, so
# CMAKE_SIZEOF_VOID_P may be unset; force 64-bit.
if(MCL_WIN_ARM64)
	set(BIT "64")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# Always load Visual Studio finder on Windows; it is the single source of truth for VS paths
if(WIN32)
	include(FindVisualStudio)
endif()

# Resolve the clang/llvm tools and library paths for Windows ARM64 (shared by
# the cross and native builds).
if(MCL_WIN_ARM64)
	include(WinArm64Tools)
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Ensure output directories exist (useful for custom commands)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(MCL_WIN_ARM64)
	# On Windows ARM64 the library is produced by the custom commands below
	# (clang-cl / llvm-lib). Create placeholder targets excluded from ALL so
	# the rest of the file can still reference mcl/mcl_st uniformly.
	add_library(mcl SHARED src/fp.cpp)
	add_library(mcl_st STATIC src/fp.cpp)
	set_target_properties(mcl mcl_st PROPERTIES EXCLUDE_FROM_ALL TRUE)
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

add_library(mcl::mcl_st ALIAS mcl_st)
target_include_directories(mcl_st PUBLIC
	$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
	$<INSTALL_INTERFACE:$CMAKE_INSTALL_DIR/include>)
set_target_properties(mcl_st PROPERTIES
	OUTPUT_NAME mcl
	POSITION_INDEPENDENT_CODE ON)

target_compile_definitions(mcl PUBLIC MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT})
target_compile_definitions(mcl_st PUBLIC MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT})

# Compiler and linker settings
if(MCL_WIN_ARM64)
	# The library objects are built by the custom commands below with explicit
	# flags, so only the public compile definitions matter here.
	target_compile_definitions(mcl PUBLIC NOMINMAX MCL_MSM=0)
	target_compile_definitions(mcl_st PUBLIC NOMINMAX MCL_MSM=0)
	set(MCL_COMPILE_OPTIONS "")

elseif(MSVC)
	if(MCL_MSVC_RUNTIME_DLL)
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MD /Oy /O2 /EHsc /GS- /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MDd")
	else()
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MT /Oy /O2 /EHsc /GS- /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MTd")
	endif()

	# Set /Brepro for reproducible builds in linker flags
	set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /Brepro")
	set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /Brepro")

	# Set mklib.bat compatible static linker flags for x64 Windows
	if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
		set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /nodefaultlib")
	endif()

	# Set mklib.bat compatible flags for x64 Windows
	if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64")
		target_compile_definitions(mcl PUBLIC NOMINMAX MCL_SIZEOF_UNIT=8 MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT})
		target_compile_definitions(mcl_st PUBLIC NOMINMAX MCL_SIZEOF_UNIT=8 MCL_FP_BIT=${MCL_FP_BIT} MCL_FR_BIT=${MCL_FR_BIT} MCL_DONT_EXPORT)
		set(MCL_COMPILE_OPTIONS /W4 /openmp)
	else()
		target_compile_definitions(mcl PUBLIC NOMINMAX)
		target_compile_definitions(mcl_st PUBLIC NOMINMAX)
		set(MCL_COMPILE_OPTIONS /W4)
	endif()
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

if(MCL_COMPILE_OPTIONS)
	target_compile_options(mcl PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_options(mcl_st PRIVATE ${MCL_COMPILE_OPTIONS})
endif()

# use bint-x64 on x64, bint${BIT}.ll on the other CPU
if(MCL_WIN_ARM64)
	# Build the whole library for Windows ARM64 here, following mklib_arm64.bat:
	# compile *.ll with clang++ (cl driver cannot consume LLVM IR), fp.cpp with
	# clang-cl, archive with llvm-lib, and link the DLL with clang-cl. The
	# placeholder mcl/mcl_st targets are replaced by these custom outputs.
	set(BINT_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint${BIT}.o")
	set(BASE_OBJ "${CMAKE_CURRENT_BINARY_DIR}/base${BIT}.o")
	set(FP_OBJ_STATIC "${CMAKE_CURRENT_BINARY_DIR}/fp_static.o")
	set(FP_OBJ_DLL "${CMAKE_CURRENT_BINARY_DIR}/fp_dll.o")
	set(MCL_STATIC_LIB "${CMAKE_CURRENT_BINARY_DIR}/lib/mcl.lib")
	set(MCL_DLL "${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.dll")

	set(ARM64_TARGET --target=arm64-pc-windows-msvc)
	set(ARM64_LL_FLAGS -O2 -DNDEBUG -fno-ident)
	set(ARM64_CL_FLAGS ${ARM64_TARGET} /O2 /DNDEBUG /DMCL_SIZEOF_UNIT=8
		/DMCL_FP_BIT=${MCL_FP_BIT} /DMCL_FR_BIT=${MCL_FR_BIT} /DMCL_MSM=0
		/DMCL_BINT_ASM_X64=0 /DNOMINMAX /Brepro
		-DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION
		-I${CMAKE_CURRENT_SOURCE_DIR}/include -I${CMAKE_CURRENT_SOURCE_DIR}/src)

	# *.ll -> *.o (clang++)
	add_custom_command(OUTPUT ${BINT_OBJ}
		COMMAND "${MCL_CLANG}" ${ARM64_TARGET} ${ARM64_LL_FLAGS} -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Compiling bint${BIT}.ll for ARM64")
	add_custom_command(OUTPUT ${BASE_OBJ}
		COMMAND "${MCL_CLANG}" ${ARM64_TARGET} ${ARM64_LL_FLAGS} -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Compiling base${BIT}.ll for ARM64")

	# fp.cpp -> *.o (clang-cl); static uses /MT + MCL_DONT_EXPORT, DLL uses /MD
	add_custom_command(OUTPUT ${FP_OBJ_STATIC}
		COMMAND "${MCL_CLANG_CL}" ${ARM64_CL_FLAGS} /MT -DMCL_DONT_EXPORT /c /Fo:${FP_OBJ_STATIC} ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Compiling fp.cpp for ARM64 static library")
	add_custom_command(OUTPUT ${FP_OBJ_DLL}
		COMMAND "${MCL_CLANG_CL}" ${ARM64_CL_FLAGS} /MD /c /Fo:${FP_OBJ_DLL} ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Compiling fp.cpp for ARM64 DLL")

	# static library (llvm-lib)
	add_custom_command(OUTPUT ${MCL_STATIC_LIB}
		COMMAND "${MCL_LLVM_LIB}" /nologo /OUT:${MCL_STATIC_LIB} /Brepro /nodefaultlib ${FP_OBJ_STATIC} ${BASE_OBJ} ${BINT_OBJ}
		DEPENDS ${FP_OBJ_STATIC} ${BASE_OBJ} ${BINT_OBJ}
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Creating ARM64 static library mcl.lib")
	add_custom_target(mcl_static_lib ALL DEPENDS ${MCL_STATIC_LIB})

	# DLL (clang-cl drives the link)
	set(_arm64_libpath_args "")
	foreach(_d ${MCL_WINSDK_LIBDIRS})
		list(APPEND _arm64_libpath_args /LIBPATH:${_d})
	endforeach()
	add_custom_command(OUTPUT ${MCL_DLL}
		COMMAND "${MCL_CLANG_CL}" ${ARM64_TARGET} /LD ${FP_OBJ_DLL} ${BASE_OBJ} ${BINT_OBJ} /Fe:${MCL_DLL} /link /Brepro "${MCL_CLANG_RT}" msvcrt.lib kernel32.lib ${_arm64_libpath_args}
		DEPENDS ${FP_OBJ_DLL} ${BASE_OBJ} ${BINT_OBJ}
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Creating ARM64 DLL mcl.dll")
	add_custom_target(mcl_dll ALL DEPENDS ${MCL_DLL})

elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	# Locate ML64 assembler under VS_PATH discovered by FindVisualStudio
	if(NOT VS_PATH)
		message(FATAL_ERROR "VS_PATH is not set. FindVisualStudio must locate Visual Studio on Windows builds.")
	endif()
	file(GLOB ML64_CAND "${VS_PATH}/VC/Tools/MSVC/*/bin/Hostx64/x64/ml64.exe")
	list(LENGTH ML64_CAND _ml64_len)
	if(_ml64_len GREATER 0)
		list(GET ML64_CAND 0 ML64)
	endif()
	if(NOT ML64 OR NOT EXISTS "${ML64}")
		message(FATAL_ERROR "ML64 assembler not found under VS_PATH='${VS_PATH}'. Ensure Visual Studio with MSVC tools is installed.")
	endif()
	message(STATUS "Found ML64 assembler: ${ML64}")
	set(BINT_X64_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint-x64-win.obj")
	add_custom_command(OUTPUT ${BINT_X64_OBJ}
		COMMAND ${ML64} /c /Fo ${BINT_X64_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/asm/bint-x64-win.asm
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(gen_bint-x64-win.obj
		SOURCES ${BINT_X64_OBJ})
	add_dependencies(mcl gen_bint-x64-win.obj)
	target_sources(mcl PRIVATE ${BINT_X64_OBJ})
	add_dependencies(mcl_st gen_bint-x64-win.obj)
	target_sources(mcl_st PRIVATE ${BINT_X64_OBJ})
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE)
	if (CMAKE_SYSTEM_NAME STREQUAL "MSYS")
		target_sources(mcl PRIVATE src/asm/bint-x64-mingw.S)
		target_sources(mcl_st PRIVATE src/asm/bint-x64-mingw.S)
	else()
		target_sources(mcl PRIVATE src/asm/bint-x64-amd64.S)
		target_sources(mcl_st PRIVATE src/asm/bint-x64-amd64.S)
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
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll -O3 -fPIC -fno-ident
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
elseif(MCL_WIN_ARM64)
	# base/fp objects and the lib/dll are built in the MCL_WIN_ARM64 block above
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
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll -O3 -fPIC -fno-ident
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
	set(MSM_OBJ "${CMAKE_CURRENT_BINARY_DIR}/msm_avx.obj")

	add_custom_command(OUTPUT ${MSM_OBJ}
		COMMAND ${CMAKE_CXX_COMPILER} /c /Fo:${MSM_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/msm_avx.cpp -I ${CMAKE_CURRENT_SOURCE_DIR}/include /arch:AVX512 /O2 /Oy /Gm- /EHsc /MT /GS- /DCYBOZU_DONT_USE_STRING /DCYBOZU_DONT_USE_EXCEPTION  /DNDEBUG /DMCL_NO_AUTOLINK /DMCLBN_NO_AUTOLINK /DNOMINMAX
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(msm_avx.o
		SOURCES ${MSM_OBJ})
	target_link_libraries(mcl PUBLIC ${MSM_OBJ})
	add_dependencies(mcl msm_avx.o)
	target_link_libraries(mcl_st PUBLIC ${MSM_OBJ})
	add_dependencies(mcl_st msm_avx.o)
	target_sources(mcl_st PRIVATE ${MSM_OBJ})

elseif(MCL_WIN_ARM64)
	# ARM64 doesn't use AVX instructions, so skip MSM optimization
	message(STATUS "Skipping MSM AVX optimization for ARM64")
elseif(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE)
	set(MSM_OBJ "${CMAKE_CURRENT_BINARY_DIR}/msm_avx.o")

	add_custom_command(OUTPUT ${MSM_OBJ}
		COMMAND ${CMAKE_CXX_COMPILER} -c -o ${MSM_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/msm_avx.cpp ${MCL_COMPILE_OPTIONS} -I ${CMAKE_CURRENT_SOURCE_DIR}/include -mavx512f -mavx512ifma -std=c++11 -fno-rtti -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION -DNDEBUG
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(msm_avx.o
		SOURCES ${MSM_OBJ})
	target_link_libraries(mcl PUBLIC ${MSM_OBJ})
	add_dependencies(mcl msm_avx.o)
	target_sources(mcl_st PRIVATE ${MSM_OBJ})
endif()

if(MCL_TEST_WITH_GMP)
	if(NOT MSVC AND NOT MCL_WIN_ARM64)
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

if(MCL_WIN_ARM64)
	# Install custom ARM64 outputs (not the default CMake targets)
	if(TARGET mcl_static_lib)
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/lib/mcl.lib DESTINATION lib)
	endif()
	if(TARGET mcl_dll)
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.dll DESTINATION bin)
		# Also install the import library if produced next to the DLL
		if(EXISTS ${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.lib)
			install(FILES ${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.lib DESTINATION lib)
		endif()
	endif()
else()
	install(TARGETS mcl mcl_st
		EXPORT mclTargets
		LIBRARY DESTINATION lib
		ARCHIVE DESTINATION lib
		RUNTIME DESTINATION lib)
endif()

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

if(NOT MCL_WIN_ARM64)
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
endif()

# Tests
if(MCL_BUILD_TESTING)
	enable_testing()
	add_subdirectory(test)
endif()

if(MCL_BUILD_SAMPLE)
	# sample code
	add_subdirectory(sample)
endif()
