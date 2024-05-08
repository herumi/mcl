#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "mcl::mcl" for configuration ""
set_property(TARGET mcl::mcl APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(mcl::mcl PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libmcl.so.1.74"
  IMPORTED_SONAME_NOCONFIG "libmcl.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS mcl::mcl )
list(APPEND _IMPORT_CHECK_FILES_FOR_mcl::mcl "${_IMPORT_PREFIX}/lib/libmcl.so.1.74" )

# Import target "mcl::mcl_st" for configuration ""
set_property(TARGET mcl::mcl_st APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(mcl::mcl_st PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "ASM;CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libmcl.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS mcl::mcl_st )
list(APPEND _IMPORT_CHECK_FILES_FOR_mcl::mcl_st "${_IMPORT_PREFIX}/lib/libmcl.a" )

# Import target "mcl::mclbn256" for configuration ""
set_property(TARGET mcl::mclbn256 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(mcl::mclbn256 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libmclbn256.so.1.74"
  IMPORTED_SONAME_NOCONFIG "libmclbn256.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS mcl::mclbn256 )
list(APPEND _IMPORT_CHECK_FILES_FOR_mcl::mclbn256 "${_IMPORT_PREFIX}/lib/libmclbn256.so.1.74" )

# Import target "mcl::mclbn384" for configuration ""
set_property(TARGET mcl::mclbn384 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(mcl::mclbn384 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libmclbn384.so.1.74"
  IMPORTED_SONAME_NOCONFIG "libmclbn384.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS mcl::mclbn384 )
list(APPEND _IMPORT_CHECK_FILES_FOR_mcl::mclbn384 "${_IMPORT_PREFIX}/lib/libmclbn384.so.1.74" )

# Import target "mcl::mclbn384_256" for configuration ""
set_property(TARGET mcl::mclbn384_256 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(mcl::mclbn384_256 PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libmclbn384_256.so.1.74"
  IMPORTED_SONAME_NOCONFIG "libmclbn384_256.so.1"
  )

list(APPEND _IMPORT_CHECK_TARGETS mcl::mclbn384_256 )
list(APPEND _IMPORT_CHECK_FILES_FOR_mcl::mclbn384_256 "${_IMPORT_PREFIX}/lib/libmclbn384_256.so.1.74" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
