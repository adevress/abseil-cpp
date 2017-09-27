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
include(AbseilHelpers)


# config options
set(ABSL_STD_CXX_FLAG "-std=c++11" CACHE STRING "c++ std flag (default: c++11)")


# include current path
list(APPEND ABSL_COMMON_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR})

# -std=X
set(CMAKE_CXX_FLAGS "${ABSL_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}") 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_WARNING_VLA} ${CMAKE_CXX_FLAGS} ")


# find dependencies
## pthread
find_package(Threads REQUIRED)

# commented: used only for standalone test
#add_subdirectory(cctz)
#add_subdirectory(googletest)

## check targets
check_target(cctz)
check_target(gtest)
check_target(gtest_main)
check_target(gmock)

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


#
#
## public exported target absl::
## please use these targets in your project
#
#
add_library(absl::algorithm ALIAS absl_algorithm)
add_library(absl::base ALIAS absl_base)
add_library(absl::container ALIAS absl_container)
add_library(absl::debugging ALIAS absl_debugging)
add_library(absl::memory ALIAS absl_memory)
add_library(absl::meta ALIAS absl_meta)
add_library(absl::numeric ALIAS absl_numeric)
add_library(absl::strings ALIAS absl_strings)
add_library(absl::synchronization ALIAS absl_synchronization)
add_library(absl::time ALIAS absl_time)
add_library(absl::types ALIAS absl_types)
add_library(absl::utility ALIAS absl_utility)
