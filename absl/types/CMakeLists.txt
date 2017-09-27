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

list(APPEND TYPES_PUBLIC_HEADERS
  "any.h"
  "bad_any_cast.h"
  "bad_optional_access.h"
  "optional.h"
  "span.h"
)



list(APPEND BAD_ANY_CAST_SRC
    "bad_any_cast.cc"
    ${TYPES_PUBLIC_HEADERS}
)
set(BAD_ANY_CAST_PUBLIC_LIBRARIES base)

abseil_library(bad_any_cast)



set(OPTIONAL_SRC "optional.cc")
set(OPTIONAL_PUBLIC_LIBRARIES base)

abseil_library(optional)


set(BAD_OPTIONAL_ACCESS_SRC "bad_optional_access.cc")
set(BAD_OPTIONAL_ACCESS_LIBRARIES base)

abseil_library(bad_optional_access)

install(FILES ${TYPES_PUBLIC_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/types)


#
## TESTS
#


# test any_test
set(ANY_TEST_SRC "any_test.cc")
set(ANY_TEST_PUBLIC_LIBRARIES base throw_delegate bad_any_cast test_instance_tracker_lib)

abseil_test(any_test)


# test any_test_noexceptions
set(ANY_TEST_NOEXCEPTIONS_SRC "any_test.cc")
set(ANY_TEST_NOEXCEPTIONS_PUBLIC_LIBRARIES base throw_delegate bad_any_cast test_instance_tracker_lib)

abseil_test(any_test_noexceptions)


# test span_test
set(SPAN_TEST_SRC "span_test.cc")
set(SPAN_TEST_PUBLIC_LIBRARIES base strings throw_delegate bad_any_cast test_instance_tracker_lib)

abseil_test(span_test)


# test span_test_noexceptions
set(SPAN_TEST_NOEXCEPTIONS_SRC "span_test.cc")
set(SPAN_TEST_NOEXCEPTIONSPUBLIC_LIBRARIES base throw_delegate bad_any_cast test_instance_tracker_lib)



# test optional_test
set(OPTIONAL_TEST_SRC "optional_test.cc")
set(OPTIONAL_TEST_PUBLIC_LIBRARIES base throw_delegate optional bad_optional_access)

abseil_test(optional_test)


