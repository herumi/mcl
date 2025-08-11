cmake_minimum_required(VERSION 3.10)

# ARM64 cross-compilation support
option(ARM64_CROSS "Enable ARM64 Windows cross-compilation" OFF)

# Windows ARM64 native build support
if(WIN32 AND CMAKE_SYSTEM_PROCESSOR STREQUAL "ARM64")
    set(WINDOWS_ARM64_NATIVE TRUE)
    message(STATUS "Windows ARM64 native build detected")
endif()

if(ARM64_CROSS AND NOT CMAKE_TOOLCHAIN_FILE)
    message(FATAL_ERROR "ARM64_CROSS requires CMAKE_TOOLCHAIN_FILE. Use: cmake -DCMAKE_TOOLCHAIN_FILE=cmake/arm64-windows-toolchain.cmake -DARM64_CROSS=ON")
endif()

# Mark ARM64_CROSS as used to avoid warning
if(ARM64_CROSS)
    message(STATUS "ARM64 cross-compilation enabled via ARM64_CROSS=${ARM64_CROSS}")
endif()

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

# Disable GMP for ARM64 cross-compilation and native ARM64
if(ARM64_CROSS OR WINDOWS_ARM64_NATIVE)
	set(MCL_TEST_WITH_GMP_DEFAULT OFF)
	message(STATUS "Disabling GMP for ARM64 build")
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

# Override BIT for ARM64 cross-compilation and native ARM64
if(ARM64_CROSS OR WINDOWS_ARM64_NATIVE)
	set(BIT "64")
	message(STATUS "ARM64 build detected (ARM64_CROSS=${ARM64_CROSS}, WINDOWS_ARM64_NATIVE=${WINDOWS_ARM64_NATIVE}), setting BIT=64")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Ensure directories exist
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_library(mcl SHARED src/fp.cpp)
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

add_library(mcl_st STATIC src/fp.cpp)
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
if(ARM64_CROSS)
	# ARM64 cross-compilation settings
	message(STATUS "Configuring ARM64 cross-compilation build")

	# Get cached values from toolchain file
	set(VS_PATH "${VS_PATH_CACHE}")
	set(MSVC_VERSION "${MSVC_VERSION_CACHE}")
	set(CLANG_RT_PATH "${CLANG_RT_PATH_CACHE}")
	set(WindowsSdkDir "${WindowsSdkDir_CACHE}")
	set(WindowsSDKVersion "${WindowsSDKVersion_CACHE}")

	target_compile_definitions(mcl PUBLIC NOMINMAX)
	target_compile_definitions(mcl_st PUBLIC NOMINMAX)

	# Additional ARM64 specific compile definitions
	target_compile_definitions(mcl PUBLIC MCL_MSM=0)
	target_compile_definitions(mcl_st PUBLIC MCL_MSM=0)

	# MCL compile options are already set by toolchain file
	set(MCL_COMPILE_OPTIONS "")

	# Custom DLL creation for ARM64 (matching mklib_arm64.bat)
	# Override default shared library creation
	set_target_properties(mcl PROPERTIES
		RULE_LAUNCH_LINK ""
		LINK_WHAT_YOU_USE FALSE
	)

	# We'll create a custom command for the DLL in the LLVM section

	# Override both default library targets
	set_target_properties(mcl PROPERTIES
		EXCLUDE_FROM_ALL TRUE
	)
	set_target_properties(mcl_st PROPERTIES
		EXCLUDE_FROM_ALL TRUE
	)

elseif(WINDOWS_ARM64_NATIVE)
	# Windows ARM64 native build settings
	message(STATUS "Configuring Windows ARM64 native build")

	target_compile_definitions(mcl PUBLIC NOMINMAX MCL_MSM=0)
	target_compile_definitions(mcl_st PUBLIC NOMINMAX MCL_MSM=0)

	if(MCL_MSVC_RUNTIME_DLL)
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MD /Oy /Ox /EHsc /GS- /Brepro /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MDd /Brepro")
	else()
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MT /Oy /Ox /EHsc /GS- /Brepro /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MTd /Brepro")
	endif()

	set(MCL_COMPILE_OPTIONS /W4)

elseif(MSVC)
	if(MCL_MSVC_RUNTIME_DLL)
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MD /Oy /Ox /EHsc /GS- /Brepro /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MDd /Brepro")
	else()
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} /MT /Oy /Ox /EHsc /GS- /Brepro /DNDEBUG")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} /MTd /Brepro")
	endif()

	target_compile_definitions(mcl PUBLIC NOMINMAX)
	target_compile_definitions(mcl_st PUBLIC NOMINMAX)
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

if(MCL_COMPILE_OPTIONS)
	target_compile_options(mcl PRIVATE ${MCL_COMPILE_OPTIONS})
	target_compile_options(mcl_st PRIVATE ${MCL_COMPILE_OPTIONS})
endif()

# Assembly/LLVM optimized code handling
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	find_program(ML64 ml64.exe HINTS "${cl_path}" DOC "path to assembler")
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
elseif(ARM64_CROSS)
	# ARM64 cross-compilation LLVM compilation (matching mklib_arm64.bat)
	set(BINT_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint${BIT}.o")
	message(STATUS "ARM64 bint object: ${BINT_OBJ}")
	target_compile_definitions(mcl PUBLIC MCL_BINT_ASM_X64=0)
	target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM_X64=0)

	add_custom_command(OUTPUT ${BINT_OBJ}
		COMMAND "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang++.exe" --target=arm64-pc-windows-msvc -O2 -DNDEBUG -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0 -fno-ident -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		COMMENT "Compiling bint${BIT}.ll for ARM64")
	add_custom_target(gen_bint.o
		SOURCES ${BINT_OBJ})

	# For ARM64, we don't link to CMake targets since we use custom commands
elseif(WINDOWS_ARM64_NATIVE)
	# Windows ARM64 native LLVM compilation
	set(BINT_OBJ "${CMAKE_CURRENT_BINARY_DIR}/bint${BIT}.o")
	message(STATUS "Windows ARM64 native bint object: ${BINT_OBJ}")
	target_compile_definitions(mcl PUBLIC MCL_BINT_ASM_X64=0)
	target_compile_definitions(mcl_st PUBLIC MCL_BINT_ASM_X64=0)

			add_custom_command(OUTPUT ${BINT_OBJ}
			COMMAND ${CMAKE_CXX_COMPILER} -O2 -DNDEBUG -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0 -fno-ident -c -o ${BINT_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/bint${BIT}.ll
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Compiling bint${BIT}.ll for Windows ARM64 native")
	add_custom_target(gen_bint.o
		SOURCES ${BINT_OBJ})
	target_link_libraries(mcl PUBLIC ${BINT_OBJ})
	add_dependencies(mcl gen_bint.o)
	target_link_libraries(mcl_st PUBLIC ${BINT_OBJ})
	add_dependencies(mcl_st gen_bint.o)
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

# Base LLVM optimized code
if (CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64" AND NOT APPLE AND NOT CMAKE_SYSTEM_NAME STREQUAL "MSYS")
  set(X86_64_LINUX TRUE)
else()
  set(X86_64_LINUX FALSE)
endif()

if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	# skip
elseif(ARM64_CROSS) # ARM64 Windows cross-compilation
	if(${MCL_USE_LLVM})
		set(BASE_OBJ "${CMAKE_CURRENT_BINARY_DIR}/base${BIT}.o")
		message(STATUS "ARM64 base object: ${BASE_OBJ}")
		target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
		target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)

		add_custom_command(OUTPUT ${BASE_OBJ}
			COMMAND "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang++.exe" --target=arm64-pc-windows-msvc -O2 -DNDEBUG -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0 -fno-ident -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Compiling base${BIT}.ll for ARM64")
		add_custom_target(gen_base.o
			SOURCES ${BASE_OBJ})

		# For ARM64, we don't link to CMake targets since we use custom commands

		# Collect all objects for custom DLL creation
		set(ARM64_OBJECTS ${BINT_OBJ} ${BASE_OBJ})

		# Custom static library creation for ARM64 (matching mklib_arm64.bat static lib creation)
		set(MCL_STATIC_LIB "${CMAKE_CURRENT_BINARY_DIR}/lib/mcl.lib")
		set(FP_OBJ_STATIC "${CMAKE_CURRENT_BINARY_DIR}/fp_static.o")
		set(FP_OBJ_DLL "${CMAKE_CURRENT_BINARY_DIR}/fp_dll.o")

		# Compile fp.cpp to object for static library (with /MT)
		add_custom_command(OUTPUT ${FP_OBJ_STATIC}
			COMMAND "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang-cl.exe" --target=arm64-pc-windows-msvc /O2 /DNDEBUG /DMCL_SIZEOF_UNIT=8 /DMCL_FP_BIT=384 /DMCL_FR_BIT=256 /DMCL_MSM=0 /DNOMINMAX /MT /Brepro -DMCL_DONT_EXPORT -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION -I${CMAKE_CURRENT_SOURCE_DIR}/include -I${CMAKE_CURRENT_SOURCE_DIR}/src /c /Fo:${FP_OBJ_STATIC} ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Compiling fp.cpp for ARM64 static library")
		add_custom_target(gen_fp_static.o
			SOURCES ${FP_OBJ_STATIC})

		# Compile fp.cpp to object for DLL (with /MD)
		add_custom_command(OUTPUT ${FP_OBJ_DLL}
			COMMAND "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang-cl.exe" --target=arm64-pc-windows-msvc /O2 /DNDEBUG /DMCL_SIZEOF_UNIT=8 /DMCL_FP_BIT=384 /DMCL_FR_BIT=256 /DMCL_MSM=0 /DNOMINMAX /MD /Brepro -DCYBOZU_DONT_USE_STRING -DCYBOZU_DONT_USE_EXCEPTION -I${CMAKE_CURRENT_SOURCE_DIR}/include -I${CMAKE_CURRENT_SOURCE_DIR}/src /c /Fo:${FP_OBJ_DLL} ${CMAKE_CURRENT_SOURCE_DIR}/src/fp.cpp
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Compiling fp.cpp for ARM64 DLL")
		add_custom_target(gen_fp_dll.o
			SOURCES ${FP_OBJ_DLL})

		# Create static library using lib.exe (matching mklib_arm64.bat)
		add_custom_command(OUTPUT ${MCL_STATIC_LIB}
			COMMAND "${CMAKE_AR}" /nologo /OUT:${MCL_STATIC_LIB} /Brepro /nodefaultlib ${FP_OBJ_STATIC} ${BASE_OBJ} ${BINT_OBJ}
			DEPENDS gen_fp_static.o gen_base.o gen_bint.o
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Creating ARM64 static library with lib.exe")

		# Create a target for the static library
		add_custom_target(mcl_static_lib ALL DEPENDS ${MCL_STATIC_LIB})

		# Override the default static library target
		set_target_properties(mcl_st PROPERTIES
			EXCLUDE_FROM_ALL TRUE
		)

		# Custom DLL creation command (matching mklib_arm64.bat dll creation)
		set(MCL_DLL "${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.dll")

		# Create DLL using clang-cl (exactly matching mklib_arm64.bat line 24)
		add_custom_command(OUTPUT ${MCL_DLL}
			COMMAND "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang-cl.exe"
				--target=arm64-pc-windows-msvc /LD
				${FP_OBJ_DLL} ${BASE_OBJ} ${BINT_OBJ}
				/Fe:${MCL_DLL} /link /Brepro
				"${CLANG_RT_PATH_CACHE}/clang_rt.builtins-aarch64.lib"
				msvcrt.lib kernel32.lib
				/LIBPATH:"${VS_PATH_CACHE}/VC/Tools/MSVC/${MSVC_VERSION_CACHE}/lib/arm64"
				/LIBPATH:"${WindowsSdkDir_CACHE}Lib/${WindowsSDKVersion_CACHE}/um/arm64"
				/LIBPATH:"${WindowsSdkDir_CACHE}Lib/${WindowsSDKVersion_CACHE}/ucrt/arm64"
			DEPENDS gen_fp_dll.o gen_base.o gen_bint.o
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Creating ARM64 DLL with clang-cl (matching mklib_arm64.bat)")

		# Create a target for the DLL
		add_custom_target(mcl_dll ALL DEPENDS ${MCL_DLL})

		# Override the default shared library target
		set_target_properties(mcl PROPERTIES
			EXCLUDE_FROM_ALL TRUE
		)
	endif()
elseif(WINDOWS_ARM64_NATIVE) # Windows ARM64 native
	if(${MCL_USE_LLVM})
		set(BASE_OBJ "${CMAKE_CURRENT_BINARY_DIR}/base${BIT}.o")
		message(STATUS "Windows ARM64 native base object: ${BASE_OBJ}")
		target_compile_definitions(mcl PUBLIC MCL_USE_LLVM=1)
		target_compile_definitions(mcl_st PUBLIC MCL_USE_LLVM=1)

		add_custom_command(OUTPUT ${BASE_OBJ}
			COMMAND ${CMAKE_CXX_COMPILER} -O2 -DNDEBUG -DMCL_SIZEOF_UNIT=8 -DMCL_FP_BIT=384 -DMCL_FR_BIT=256 -DMCL_MSM=0 -fno-ident -c -o ${BASE_OBJ} ${CMAKE_CURRENT_SOURCE_DIR}/src/base${BIT}.ll
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Compiling base${BIT}.ll for Windows ARM64 native")
		add_custom_target(gen_base.o
			SOURCES ${BASE_OBJ})
		target_link_libraries(mcl PUBLIC ${BASE_OBJ})
		add_dependencies(mcl gen_base.o)
		target_link_libraries(mcl_st PUBLIC ${BASE_OBJ})
		add_dependencies(mcl_st gen_base.o)
	endif()
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

# MSM optimization (skip for ARM64)
if(CMAKE_SYSTEM_PROCESSOR STREQUAL "AMD64") # Win64
	# Commented out MSM for now
elseif(ARM64_CROSS OR WINDOWS_ARM64_NATIVE) # ARM64 Windows (cross-compilation or native)
	# ARM64 doesn't use AVX instructions, so skip MSM optimization
	message(STATUS "Skipping MSM AVX optimization for ARM64")
	target_compile_definitions(mcl PUBLIC MCL_MSM=0)
	target_compile_definitions(mcl_st PUBLIC MCL_MSM=0)
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
	if(NOT MSVC AND NOT ARM64_CROSS AND NOT WINDOWS_ARM64_NATIVE)
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

if(ARM64_CROSS)
	# Install custom ARM64 targets
	# No default CMake targets to install since we use custom commands

	# Install custom static library
	if(TARGET mcl_static_lib)
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/lib/mcl.lib
			DESTINATION lib)
	endif()

	# Install custom DLL if it exists
	if(TARGET mcl_dll)
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.dll
			DESTINATION bin)
		# Also install the import library
		install(FILES ${CMAKE_CURRENT_BINARY_DIR}/bin/mcl.lib
			DESTINATION lib)
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

# Only install export targets if not ARM64 cross-compilation
if(NOT ARM64_CROSS)
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