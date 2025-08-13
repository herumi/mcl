# Shared helper to locate Visual Studio installation path with LLVM tools
# Sets the following variables when found:
#   VS_PATH           - Visual Studio installation root (string)
#   VS_PATH_CACHE     - Same as VS_PATH, cached (INTERNAL)

include_guard(GLOBAL)

if(NOT WIN32)
  # Non-Windows: nothing to do
  return()
endif()

# If already cached and looks valid, reuse
if(DEFINED VS_PATH_CACHE AND EXISTS "${VS_PATH_CACHE}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
  set(VS_PATH "${VS_PATH_CACHE}")
  return()
endif()

# Try vswhere first
set(_vswhere_cmd "for /f \"usebackq tokens=*\" %i in (`\"%ProgramFiles(x86)%\\Microsoft Visual Studio\\Installer\\vswhere.exe\" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do @echo %i")
execute_process(
  COMMAND cmd /c ${_vswhere_cmd}
  OUTPUT_VARIABLE _VS_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
  RESULT_VARIABLE _VS_RESULT
  ERROR_QUIET
)

# Validate vswhere result
set(_VS_FOUND FALSE)
if(_VS_RESULT EQUAL 0 AND _VS_PATH)
  if(EXISTS "${_VS_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
    set(VS_PATH "${_VS_PATH}")
    set(_VS_FOUND TRUE)
  endif()
endif()

if(NOT _VS_FOUND)
  # Fallback: check common install locations (VS 2019/2022)
  set(_VS_COMMON_PATHS
    "C:/Program Files/Microsoft Visual Studio/2022/Enterprise"
    "C:/Program Files/Microsoft Visual Studio/2022/Professional"
    "C:/Program Files/Microsoft Visual Studio/2022/Community"
    "C:/Program Files (x86)/Microsoft Visual Studio/2019/Enterprise"
    "C:/Program Files (x86)/Microsoft Visual Studio/2019/Professional"
    "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community"
  )
  foreach(_VS_TEST_PATH ${_VS_COMMON_PATHS})
    if(EXISTS "${_VS_TEST_PATH}/VC/Tools/Llvm/x64/bin/clang-cl.exe")
      set(VS_PATH "${_VS_TEST_PATH}")
      set(_VS_FOUND TRUE)
      break()
    endif()
  endforeach()
endif()

if(_VS_FOUND)
  set(VS_PATH_CACHE "${VS_PATH}" CACHE INTERNAL "Visual Studio Installation Path")
else()
  set(VS_PATH "")
endif()
