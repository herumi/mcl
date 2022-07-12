cmake_minimum_required(VERSION 3.9)

project(mcljava LANGUAGES CXX)

# build and link the shared libaries first
option(MCL_LINK_DIR "Absolute path where mcl static or dynamic library resides")

option(GMP_LINK_DIR "Absolute path where GMP static or dynamic library resides")

option(MCL_USE_XBYAK "Use the XBYAK JIT Assembler" ON)

# Windows linkage problem, see https://stackoverflow.com/a/68375079/13719349
if(MSVC)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
endif()

if(NOT MCL_USE_XBYAK)
	add_definitions(-DMCL_DONT_USE_XBYAK)
endif()

add_library(mcljava SHARED mcl_wrap.cxx)
add_library(mclelgamaljava SHARED elgamal_wrap.cxx)

find_package(JNI REQUIRED)

if (JNI_FOUND)
    message (STATUS "JNI_INCLUDE_DIRS=${JNI_INCLUDE_DIRS}")
    message (STATUS "JNI_LIBRARIES=${JNI_LIBRARIES}")
endif()

# make sure to always link mcl statically, so only one library needs to be installed by users
set(CMAKE_FIND_LIBRARY_SUFFIXES .a .lib)

# cybozulib_ext holds headers e.g. for GMP on Windows, should be empty on Linux / Mac
include_directories(${JNI_INCLUDE_DIRS} ../../include/ ../../include/cybozu)

find_library(MCL_LIBRARY NAMES mcl HINTS ${MCL_LINK_DIR} REQUIRED)

target_link_libraries(mcljava ${MCL_LIBRARY})
target_link_libraries(mclelgamaljava ${MCL_LIBRARY})

message (STATUS "MCL_LIBRARY=${MCL_LIBRARY}")

# finally, compile the test Java classes
find_package(Java REQUIRED)
# provide add_jar etc.
include(UseJava)


add_jar(ElgamalTest ElgamalTest.java)
add_jar(MclTest MclTest.java)

get_target_property(elgamal_jar ElgamalTest JAR_FILE)
get_target_property(elgamal_classdir ElgamalTest CLASSDIR)

get_target_property(mcl_jar MclTest JAR_FILE)
get_target_property(mcl_classdir MclTest CLASSDIR)

enable_testing()
add_test(NAME TestMcl COMMAND ${Java_JAVA_EXECUTABLE} -cp ${mcl_jar} -Djava.library.path=$<TARGET_FILE_DIR:mcljava> MclTest)
add_test(NAME TestElgamal COMMAND ${Java_JAVA_EXECUTABLE} -cp ${elgamal_jar} -Djava.library.path=$<TARGET_FILE_DIR:mclelgamaljava> ElgamalTest)
