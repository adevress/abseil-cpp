#
# Copyright 2017 The Abseil Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
cmake_minimum_required(VERSION 2.8.12)
project(absl)

# enable ctest
include(CTest)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMake)

include(GNUInstallDirs)
include(ReleaseDebugAutoFlags)
include(AbseilHelpers)


# config options
option(ABSL_ENABLE_PIC "Enable position-independent code generation" ON)
option(ABSL_DISABLE_INSTALL "Disable installation of absl components" OFF)

set(ABSL_STD_CXX_FLAG "${CMAKE_CXX_STD_CXX11}" CACHE STRING "c++ std flag (default: c++11)")


# include current path
list(APPEND ABSL_COMMON_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR})
include(AbseilFindDependencies)


# -std=X
set(CMAKE_CXX_FLAGS "${ABSL_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}") 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_WARNING_VLA} ${CMAKE_CXX_FLAGS} ")

# -fPIC
if(ABSL_ENABLE_PIC)
  list(APPEND ABSL_COMPILE_CXXFLAGS
    "${CMAKE_CXX_POSITION_INDEPENDENT}"
  )
endif(ABSL_ENABLE_PIC)

# -fexceptions
set(ABSL_EXCEPTIONS_FLAG "${CMAKE_CXX_EXCEPTIONS}")

# fix stuff
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FIX_MSVC} ${CMAKE_CXX_FLAGS}") 

list(APPEND ABSL_TEST_COMMON_LIBRARIES
  gtest_main
  gtest
  gmock
  ${CMAKE_THREAD_LIBS_INIT}
)



add_subdirectory(absl)


# generate pkgconfig
#
# order matters for static linking
#
# -lsynchronization -lmalloc_extension -lstrings
# -ltime -lint128 -lbad_any_cast -lutility
# -lbase -lthrow_delegate  -lstacktrace  -lcctz
#
list(APPEND ABSL_TARGET_NAMES
  synchronization
  malloc_extension
  strings
  time
  int128
  bad_any_cast
  utility
  base
  throw_delegate
  stacktrace
)

absl_pkgconf_generate(
  NAME "Abseil"
  VERSION "master"
  DESCRIPTION "Abseil - C++ Common Libraries"
  URL "https://abseil.io/"
  LIB_NAMES ${ABSL_TARGET_NAMES}
  PRIVATE_LIB_NAMES "cctz"
)


## export two cache variables for
## simple stupid embedded usage
set(ABSL_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "abseil header directory")
set(ABSL_ALL_LIBRARIES "${ABSL_TARGET_NAMES}" CACHE STRING "targets of all abseil libraries")
