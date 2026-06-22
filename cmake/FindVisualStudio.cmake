# Shared helper to locate a Visual Studio installation that ships the LLVM
# (clang-cl) tools. Sets:
#   VS_PATH         - Visual Studio installation root (string)
#   VS_PATH_CACHE   - Same as VS_PATH, cached (INTERNAL)
# VS_PATH is left empty when nothing suitable is found.

include_guard(GLOBAL)

if(NOT WIN32)
  # Non-Windows: nothing to do
  return()
endif()

# The marker we require under a VS root (host x64 clang-cl).
set(_vs_marker "VC/Tools/Llvm/x64/bin/clang-cl.exe")

# Reuse a valid cached result.
if(DEFINED VS_PATH_CACHE AND EXISTS "${VS_PATH_CACHE}/${_vs_marker}")
  set(VS_PATH "${VS_PATH_CACHE}")
  return()
endif()

set(VS_PATH "")

# 1) Ask vswhere directly (most reliable, version independent).
# Note: do not reference $ENV{ProgramFiles(x86)} -- the parentheses are an
# invalid variable name under policy CMP0053. vswhere always lives under the
# x86 Program Files installer directory, so use the literal path.
find_program(_vswhere NAMES vswhere.exe
  PATHS
    "C:/Program Files (x86)/Microsoft Visual Studio/Installer"
    "$ENV{ProgramFiles}/Microsoft Visual Studio/Installer"
  NO_DEFAULT_PATH)

if(_vswhere)
  execute_process(
    COMMAND "${_vswhere}" -latest -products * -property installationPath
    OUTPUT_VARIABLE _vs_install
    OUTPUT_STRIP_TRAILING_WHITESPACE
    ERROR_QUIET
    RESULT_VARIABLE _vs_rc)
  if(_vs_rc EQUAL 0 AND _vs_install AND EXISTS "${_vs_install}/${_vs_marker}")
    set(VS_PATH "${_vs_install}")
  endif()
endif()

# 2) Fallback: glob any installed version/edition (e.g. 2019, 2022, 18, ...).
if(NOT VS_PATH)
  file(GLOB _vs_cands
    "C:/Program Files/Microsoft Visual Studio/*/*/${_vs_marker}"
    "C:/Program Files (x86)/Microsoft Visual Studio/*/*/${_vs_marker}")
  if(_vs_cands)
    # Prefer the lexicographically greatest path (newest numbered dir).
    list(SORT _vs_cands)
    list(REVERSE _vs_cands)
    list(GET _vs_cands 0 _vs_clangcl)
    string(REGEX REPLACE "/${_vs_marker}$" "" VS_PATH "${_vs_clangcl}")
  endif()
endif()

if(VS_PATH)
  set(VS_PATH_CACHE "${VS_PATH}" CACHE INTERNAL "Visual Studio Installation Path")
  message(STATUS "Found Visual Studio with clang-cl: ${VS_PATH}")
endif()
