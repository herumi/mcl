# ARM64 Windows cross-compilation toolchain file
# This file should be used with: cmake -DCMAKE_TOOLCHAIN_FILE=cmake/arm64-windows-toolchain.cmake

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR ARM64)
set(CMAKE_CROSSCOMPILING TRUE)

# Find Visual Studio installation path via shared helper
include("${CMAKE_CURRENT_LIST_DIR}/FindVisualStudio.cmake")
if(NOT VS_PATH OR NOT EXISTS "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
    message(FATAL_ERROR "Visual Studio with LLVM x64 tools not found. Please install Visual Studio with C++ LLVM tools.")
endif()

# Set compilers - use clang-cl for MSVC compatibility
set(CMAKE_C_COMPILER "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
set(CMAKE_CXX_COMPILER "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")

# Force CMake to recognize as Clang but with MSVC-compatible interface
set(CMAKE_C_COMPILER_ID "Clang")
set(CMAKE_CXX_COMPILER_ID "Clang")
set(CMAKE_C_SIMULATE_ID "MSVC")
set(CMAKE_CXX_SIMULATE_ID "MSVC")

# Find MSVC version for cross-tools
file(GLOB MSVC_VERSION_DIRS "${VS_PATH}/VC/Tools/MSVC/*")
if(MSVC_VERSION_DIRS)
    # Get the latest version
    list(SORT MSVC_VERSION_DIRS)
    list(REVERSE MSVC_VERSION_DIRS)
    list(GET MSVC_VERSION_DIRS 0 MSVC_VERSION_DIR)
    get_filename_component(MSVC_VERSION ${MSVC_VERSION_DIR} NAME)

    # Set lib.exe and link.exe for ARM64 target (HostX64/ARM64)
    set(CMAKE_AR "${VS_PATH}/VC/Tools/MSVC/${MSVC_VERSION}/bin/HostX64/ARM64/lib.exe")
    set(CMAKE_LINKER "${VS_PATH}/VC/Tools/MSVC/${MSVC_VERSION}/bin/HostX64/ARM64/link.exe")
endif()

# Find clang runtime library path (use ARM64 version, not x64)
# This matches setvar_arm64.bat logic
file(GLOB CLANG_VERSION_DIRS "${VS_PATH}/VC/Tools/Llvm/ARM64/lib/clang/*")
if(CLANG_VERSION_DIRS)
    list(GET CLANG_VERSION_DIRS 0 CLANG_VERSION_DIR)
    get_filename_component(CLANG_VERSION ${CLANG_VERSION_DIR} NAME)
    set(CLANG_RT_PATH "${VS_PATH}/VC/Tools/Llvm/ARM64/lib/clang/${CLANG_VERSION}/lib/windows")
endif()

# Find Windows SDK paths
execute_process(
    COMMAND reg query "HKLM\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0" /v InstallationFolder
    OUTPUT_VARIABLE SDK_ROOT_RAW
    ERROR_QUIET
)
if(SDK_ROOT_RAW)
    string(REGEX MATCH "InstallationFolder[ ]+REG_SZ[ ]+([^\r\n]+)" SDK_MATCH ${SDK_ROOT_RAW})
    if(SDK_MATCH)
        set(WindowsSdkDir ${CMAKE_MATCH_1})
    endif()
endif()

execute_process(
    COMMAND reg query "HKLM\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0" /v ProductVersion
    OUTPUT_VARIABLE SDK_VER_RAW
    ERROR_QUIET
)
if(SDK_VER_RAW)
    string(REGEX MATCH "ProductVersion[ ]+REG_SZ[ ]+([^\r\n]+)" SDK_VER_MATCH ${SDK_VER_RAW})
    if(SDK_VER_MATCH)
        set(WindowsSDKVersion "${CMAKE_MATCH_1}.0")
    endif()
endif()

# Set compile flags for ARM64 cross-compilation using clang-cl syntax
# clang-cl uses MSVC-style flags but with Clang features
set(ARM64_COMPILE_FLAGS
    "--target=arm64-pc-windows-msvc"
    "/O2"
    "/DNDEBUG"
    "/DMCL_SIZEOF_UNIT=8"
    "/DMCL_FP_BIT=384"
    "/DMCL_FR_BIT=256"
    "/DMCL_MSM=0"
    "/MT"  # Use static runtime for consistency with mklib_arm64.bat
)

# Convert to string for CMake cache variables
string(REPLACE ";" " " ARM64_COMPILE_FLAGS_STR "${ARM64_COMPILE_FLAGS}")

# Set initial cache variables for compile flags
set(CMAKE_C_FLAGS_INIT "${ARM64_COMPILE_FLAGS_STR}")
set(CMAKE_CXX_FLAGS_INIT "${ARM64_COMPILE_FLAGS_STR}")

# For shared libraries, we need special handling in CMakeLists.txt
# Static libraries will use lib.exe automatically

# Cache variables for use in main CMakeLists.txt
set(VS_PATH_CACHE "${VS_PATH}" CACHE INTERNAL "Visual Studio Path")
set(MSVC_VERSION_CACHE "${MSVC_VERSION}" CACHE INTERNAL "MSVC Version")
set(CLANG_RT_PATH_CACHE "${CLANG_RT_PATH}" CACHE INTERNAL "Clang Runtime Path")
set(WindowsSdkDir_CACHE "${WindowsSdkDir}" CACHE INTERNAL "Windows SDK Directory")
set(WindowsSDKVersion_CACHE "${WindowsSDKVersion}" CACHE INTERNAL "Windows SDK Version")

# Skip compiler test that is causing issues
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)

message(STATUS "ARM64 cross-compilation toolchain initialized")
message(STATUS "Visual Studio Path: ${VS_PATH}")
message(STATUS "MSVC Version: ${MSVC_VERSION}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "CXX Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "Archiver (lib.exe): ${CMAKE_AR}")
message(STATUS "Linker: ${CMAKE_LINKER}")
message(STATUS "Clang RT Path: ${CLANG_RT_PATH}")
message(STATUS "Clang Runtime Library: ${CLANG_RT_PATH}/clang_rt.builtins-aarch64.lib")
message(STATUS "Windows SDK: ${WindowsSdkDir} (${WindowsSDKVersion})")

# Verify that the clang runtime library exists
if(EXISTS "${CLANG_RT_PATH}/clang_rt.builtins-aarch64.lib")
    message(STATUS "clang_rt.builtins-aarch64.lib found")
else()
    message(WARNING "clang_rt.builtins-aarch64.lib NOT found at: ${CLANG_RT_PATH}/clang_rt.builtins-aarch64.lib")
endif()

# Verify Windows SDK ARM64 library paths
if(EXISTS "${WindowsSdkDir}Lib/${WindowsSDKVersion}/um/arm64")
    message(STATUS "Windows SDK UM ARM64 libraries found")
else()
    message(WARNING "Windows SDK UM ARM64 libraries NOT found at: ${WindowsSdkDir}Lib/${WindowsSDKVersion}/um/arm64")
endif()

if(EXISTS "${WindowsSdkDir}Lib/${WindowsSDKVersion}/ucrt/arm64")
    message(STATUS "Windows SDK UCRT ARM64 libraries found")
else()
    message(WARNING "Windows SDK UCRT ARM64 libraries NOT found at: ${WindowsSdkDir}Lib/${WindowsSDKVersion}/ucrt/arm64")
endif()

# Check for specific libraries
set(ARM64_KERNEL32_PATH "${WindowsSdkDir}Lib/${WindowsSDKVersion}/um/arm64/kernel32.lib")
if(EXISTS "${ARM64_KERNEL32_PATH}")
    message(STATUS "kernel32.lib (ARM64) found")
else()
    message(WARNING "kernel32.lib (ARM64) NOT found at: ${ARM64_KERNEL32_PATH}")
endif()

set(ARM64_MSVCRT_PATH "${WindowsSdkDir}Lib/${WindowsSDKVersion}/ucrt/arm64/msvcrt.lib")
if(EXISTS "${ARM64_MSVCRT_PATH}")
    message(STATUS "msvcrt.lib (ARM64) found")
else()
    # Try alternative location
    set(ARM64_MSVCRT_ALT_PATH "${VS_PATH}/VC/Tools/MSVC/${MSVC_VERSION}/lib/arm64/msvcrt.lib")
    if(EXISTS "${ARM64_MSVCRT_ALT_PATH}")
        message(STATUS "msvcrt.lib (ARM64) found at MSVC location")
    else()
        message(WARNING "msvcrt.lib (ARM64) NOT found at either Windows SDK or MSVC locations")
    endif()
endif()