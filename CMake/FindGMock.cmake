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

include(FindPackageHandleStandardArgs)


find_path(GMOCK_INCLUDE_DIRS NAMES  gmock/gmock.h)
find_library(GMOCK_LIBRARIES NAMES gmock )

find_package_handle_standard_args(GMOCK DEFAULT_MSG GMOCK_INCLUDE_DIRS GMOCK_LIBRARIES)

mark_as_advanced(GMOCK_FOUND GMOCK_INCLUDE_DIRS GMOCK_LIBRARIES)


if(GMOCK_FOUND AND (NOT TARGET gmock))
  add_library(gmock STATIC IMPORTED)
  set_property(TARGET gmock PROPERTY IMPORTED_LOCATION ${GMOCK_LIBRARIES})
  set_property(TARGET gmock APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${GMOCK_INCLUDE_DIRS})
endif()
