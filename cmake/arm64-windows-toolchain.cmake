# ARM64 Windows cross-compilation toolchain file (x64 host).
# Usage: cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=cmake/arm64-windows-toolchain.cmake
#
# Its only job is to tell CMake that the target is Windows ARM64 and to use
# clang-cl as the compiler. All tool/library path discovery lives in
# cmake/WinArm64Tools.cmake, which is shared with the ARM64 native build.

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR ARM64)

# Find Visual Studio (defines VS_PATH) and use the x64-host clang-cl as the
# compiler driver for CMake's own checks and for building tests/samples.
include("${CMAKE_CURRENT_LIST_DIR}/FindVisualStudio.cmake")
if(NOT VS_PATH OR NOT EXISTS "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
  message(FATAL_ERROR "Visual Studio with the C++ Clang tools (LLVM x64) not found.")
endif()

set(CMAKE_C_COMPILER   "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
set(CMAKE_CXX_COMPILER "${VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")

# clang-cl is Clang with an MSVC-compatible interface.
set(CMAKE_C_COMPILER_ID "Clang")
set(CMAKE_CXX_COMPILER_ID "Clang")
set(CMAKE_C_SIMULATE_ID "MSVC")
set(CMAKE_CXX_SIMULATE_ID "MSVC")

# Skip the cross-compiler test executable check.
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
