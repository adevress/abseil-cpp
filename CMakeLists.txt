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
option(ABSL_ENABLE_PIC "Enable / disable position-independent code generation" OFF)
option(ABSL_ENABLE_BUNDLE "Enable / disable embbedded dependencies" ON)
set(ABSL_STD_CXX_FLAG "${CMAKE_CXX_STD_CXX11}" CACHE STRING "c++ std flag (default: c++11)")


include(AbseilFindDependencies)


# include current path
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# -std=X
set(CMAKE_CXX_FLAGS "${ABSL_STD_CXX_FLAG} ${CMAKE_CXX_FLAGS}") 
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_WARNING_VLA} ${CMAKE_CXX_FLAGS} ")

# -fPIC
if(ABSL_ENABLE_PIC)
    list(APPEND ABSL_COMPILE_CXXFLAGS
            "${CMAKE_CXX_POSITION_INDEPENDENT}"
    )
endif(ABSL_ENABLE_PIC)


list(APPEND ABSL_TEST_COMMON_LIBRARIES
    ${GTEST_MAIN_LIBRARIES}
    ${GTEST_LIBRARIES}
    ${GMOCK_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
)

add_subdirectory(absl)

# generate pkgconfig
list(APPEND ABSEIL_TARGET_NAMES
        base
        malloc_extension
        throw_delegate
        synchronization
        time
        stacktrace
        int128
        strings
        time
        bad_any_cast
        utility
)
abseil_pkgconf_generate(
    NAME "Abseil"
    VERSION "master"
    DESCRIPTION "Abseil - C++ Common Libraries"
    URL "https://abseil.io/"
    LIB_NAMES ${ABSEIL_TARGET_NAMES}
    PRIVATE_LIB_NAMES "cctz"
)
