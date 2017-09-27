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

## default configuration
if(NOT CMAKE_BUILD_TYPE AND (NOT CMAKE_CONFIGURATION_TYPES))
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)
    message(STATUS "Setting build type to '${CMAKE_BUILD_TYPE}' as none was specified.")
endif()


# Different configuration types:
#
# Debug : Optimized for debugging, include symbols
# Release : Release mode, no debuginfo 
# RelWithDebInfo : Distribution mode, basic optimizations for potable code with debuginfos

include(CompilerFlagsHelpers)


set(CMAKE_C_FLAGS_RELEASE  "${CMAKE_C_WARNING_ALL} ${CMAKE_CXX_NO_ASSERT} ${CMAKE_C_OPT_NORMAL}")
set(CMAKE_C_FLAGS_DEBUG  "${CMAKE_C_DEBUGINFO_FLAGS} ${CMAKE_C_WARNING_ALL} ${CMAKE_C_OPT_NONE} ${CMAKE_C_STACK_PROTECTION}")
set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_DEBUGINFO_FLAGS} ${CMAKE_C_WARNING_ALL} ${CMAKE_C_OPT_NORMAL} ${CMAKE_C_NO_ASSERT}")
set(CMAKE_C_FLAGS_MINSIZEREL "${CMAKE_C_WARNING_ALL} ${CMAKE_CXX_NO_ASSERT} ${CMAKE_C_OPT_MINSIZE}")




set(CMAKE_CXX_FLAGS_RELEASE  "${CMAKE_CXX_WARNING_ALL} ${CMAKE_CXX_NO_ASSERT} ${CMAKE_CXX_OPT_NORMAL}")
set(CMAKE_CXX_FLAGS_DEBUG  "${CMAKE_CXX_DEBUGINFO_FLAGS} ${CMAKE_CXX_WARNING_ALL} ${CMAKE_CXX_OPT_NONE} ${CMAKE_CXX_STACK_PROTECTION}")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_DEBUGINFO_FLAGS} ${CMAKE_CXX_WARNING_ALL} ${CMAKE_CXX_OPT_NORMAL} ${CMAKE_CXX_NO_ASSERT}")
set(CMAKE_CXX_FLAGS_MINSIZEREL "${CMAKE_C_WARNING_ALL} ${CMAKE_CXX_NO_ASSERT} ${CMAKE_CXX_OPT_MINSIZE}")

