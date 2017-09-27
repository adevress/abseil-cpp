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

include(ExternalProject)


#
## pthread
#
find_package(Threads REQUIRED)

#
## CCTZ
#
if(NOT TARGET cctz)
  find_package(CCTZ REQUIRED)
else(NOT TARGET cctz)
  message(STATUS "ABSL: use existing cctz target")
endif(NOT TARGET cctz)


if(BUILD_TESTING)

  if(NOT TARGET gmock)
    find_package(GMock REQUIRED)
  else(NOT TARGET gmock)
    message(STATUS "ABSL: use existing gmock target")
  endif(NOT TARGET gmock)

  if((NOT TARGET gtest) OR (NOT TARGET gtest_main))
    find_package(GTest REQUIRED)

    # we need to redefine gtest targets here due to the fact the
    # standard FindGTest.cmake under CMake 2.8.X does not define targets
    add_library(gtest STATIC IMPORTED)
    set_property(TARGET gtest PROPERTY IMPORTED_LOCATION ${GTEST_LIBRARIES})
    set_property(TARGET gtest APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INCLUDE_DIRS})
    add_library(gtest_main STATIC IMPORTED)
    set_property(TARGET gtest_main PROPERTY IMPORTED_LOCATION ${GTEST_MAIN_LIBRARIES})
    set_property(TARGET gtest_main APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${GTEST_INCLUDE_DIRS})

  else((NOT TARGET gtest) OR (NOT TARGET gtest_main))
    message(STATUS "ABSL: use existing gtest and gtest_main targets")
  endif((NOT TARGET gtest) OR (NOT TARGET gtest_main))

endif(BUILD_TESTING)


