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

find_path(CCTZ_INCLUDE_DIRS NAMES  cctz/civil_time.h)
find_library(CCTZ_LIBRARIES NAMES cctz )

find_package_handle_standard_args(CCTZ DEFAULT_MSG CCTZ_INCLUDE_DIRS CCTZ_LIBRARIES)

mark_as_advanced(CCTZ_FOUND CCTZ_INCLUDE_DIRS CCTZ_LIBRARIES)


if(CCTZ_FOUND AND (NOT DEFINED cctz))
    add_library(cctz STATIC IMPORTED)
    set_property(TARGET cctz PROPERTY IMPORTED_LOCATION ${CCTZ_LIBRARIES})
    set_property(TARGET cctz APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${CCTZ_INCLUDE_DIRS})
endif()

