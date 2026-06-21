# Shared helper to locate the tools and library paths needed to build
# Windows ARM64 binaries (both x64-host cross build and ARM64 native build).
#
# Requires VS_PATH (set by FindVisualStudio.cmake). Sets:
#   MCL_CLANG          - clang++.exe   (used to compile *.ll; cl driver cannot)
#   MCL_CLANG_CL       - clang-cl.exe  (used to compile fp.cpp and link the DLL)
#   MCL_LLVM_LIB       - llvm-lib.exe  (used to create the static library)
#   MCL_CLANG_RT       - full path to clang_rt.builtins-aarch64.lib
#   MCL_WINSDK_LIBDIRS - list of Windows SDK ARM64 lib dirs (um/arm64, ucrt/arm64)
#
# The same '--target=arm64-pc-windows-msvc' command works on either host, so the
# only host-dependent part is which LLVM bin directory holds runnable binaries.

include_guard(GLOBAL)

if(NOT WIN32)
  return()
endif()

include("${CMAKE_CURRENT_LIST_DIR}/FindVisualStudio.cmake")
if(NOT VS_PATH)
  message(FATAL_ERROR "Visual Studio not found. FindVisualStudio must locate VS for Windows ARM64 builds.")
endif()

# Pick the host-runnable LLVM bin directory (ARM64 on an ARM64 host, x64 otherwise).
if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "ARM64|aarch64")
  set(_llvm_bin "${VS_PATH}/VC/Tools/Llvm/ARM64/bin")
else()
  set(_llvm_bin "${VS_PATH}/VC/Tools/Llvm/x64/bin")
endif()

set(MCL_CLANG    "${_llvm_bin}/clang++.exe")
set(MCL_CLANG_CL "${_llvm_bin}/clang-cl.exe")
set(MCL_LLVM_LIB "${_llvm_bin}/llvm-lib.exe")
foreach(_tool MCL_CLANG MCL_CLANG_CL MCL_LLVM_LIB)
  if(NOT EXISTS "${${_tool}}")
    message(FATAL_ERROR "${_tool} not found at '${${_tool}}'. Install Visual Studio with the C++ Clang tools (LLVM).")
  endif()
endforeach()

# clang_rt.builtins for aarch64 ships under the ARM64 LLVM tree regardless of host.
file(GLOB _clang_rt_cand "${VS_PATH}/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows/clang_rt.builtins-aarch64.lib")
if(_clang_rt_cand)
  list(GET _clang_rt_cand 0 MCL_CLANG_RT)
else()
  message(FATAL_ERROR "clang_rt.builtins-aarch64.lib not found under ${VS_PATH}/VC/Tools/Llvm/ARM64/lib/clang/*/lib/windows")
endif()

# Locate the Windows SDK (root + version) via the registry, then derive the
# ARM64 import-library directories. kernel32.lib/msvcrt.lib/ucrt.lib live here;
# the MSVC toolset lib dir is not needed (matching mklib_arm64.bat).
execute_process(
  COMMAND reg query "HKLM\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0" /v InstallationFolder
  OUTPUT_VARIABLE _sdk_root_raw ERROR_QUIET)
if(_sdk_root_raw MATCHES "InstallationFolder[ ]+REG_SZ[ ]+([^\r\n]+)")
  set(_winsdk_dir "${CMAKE_MATCH_1}")
endif()

execute_process(
  COMMAND reg query "HKLM\\SOFTWARE\\WOW6432Node\\Microsoft\\Microsoft SDKs\\Windows\\v10.0" /v ProductVersion
  OUTPUT_VARIABLE _sdk_ver_raw ERROR_QUIET)
if(_sdk_ver_raw MATCHES "ProductVersion[ ]+REG_SZ[ ]+([^\r\n]+)")
  set(_winsdk_ver "${CMAKE_MATCH_1}.0")
endif()

if(NOT _winsdk_dir OR NOT _winsdk_ver)
  message(FATAL_ERROR "Windows SDK (v10) not found in the registry; cannot locate ARM64 import libraries.")
endif()

set(MCL_WINSDK_LIBDIRS
  "${_winsdk_dir}Lib/${_winsdk_ver}/um/arm64"
  "${_winsdk_dir}Lib/${_winsdk_ver}/ucrt/arm64")
foreach(_d ${MCL_WINSDK_LIBDIRS})
  if(NOT EXISTS "${_d}")
    message(WARNING "Windows SDK ARM64 lib dir not found: ${_d}")
  endif()
endforeach()

message(STATUS "Win ARM64 tools: clang++=${MCL_CLANG}")
message(STATUS "Win ARM64 tools: clang-cl=${MCL_CLANG_CL}")
message(STATUS "Win ARM64 tools: llvm-lib=${MCL_LLVM_LIB}")
message(STATUS "Win ARM64 tools: clang_rt=${MCL_CLANG_RT}")
message(STATUS "Win ARM64 tools: SDK lib dirs=${MCL_WINSDK_LIBDIRS}")
