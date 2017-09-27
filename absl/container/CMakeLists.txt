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


list(APPEND CONTAINER_PUBLIC_HEADERS
  "fixed_array.h"
  "inlined_vector.h"
)


list(APPEND CONTAINER_INTERNAL_HEADERS
  "internal/test_instance_tracker.h"
)



install(FILES ${CONTAINER_PUBLIC_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/container)
install(FILES ${CONTAINER_INTERNAL_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/container/internal)


#
## TESTS
#

list(APPEND TEST_INSTANCE_TRACKER_LIB_SRC
    "internal/test_instance_tracker.cc"
    ${CONTAINER_PUBLIC_HEADERS}
    ${CONTAINER_INTERNAL_HEADERS}
)
set(TEST_INSTANCE_TRACKER_LIB_DISABLE_INSTALL TRUE)

abseil_library(test_instance_tracker_lib)



# test fixed_array_test
set(FIXED_ARRAY_TEST_SRC "fixed_array_test.cc")
set(FIXED_ARRAY_TEST_PUBLIC_LIBRARIES base throw_delegate test_instance_tracker_lib)

abseil_test(fixed_array_test)


# test fixed_array_test_noexceptions
set(FIXED_ARRAY_TEST_NOEXCEPTIONS_SRC "fixed_array_test.cc")
set(FIXED_ARRAY_TEST_NOEXCEPTIONS_PUBLIC_LIBRARIES base throw_delegate test_instance_tracker_lib)

abseil_test(fixed_array_test_noexceptions)


# test inlined_vector_test
set(INLINED_VECTOR_TEST_SRC "inlined_vector_test.cc")
set(INLINED_VECTOR_TEST_PUBLIC_LIBRARIES base throw_delegate test_instance_tracker_lib)

abseil_test(inlined_vector_test)


# test inlined_vector_test_noexceptions
set(INLINED_VECTOR_TEST_NOEXCEPTIONS_SRC "inlined_vector_test.cc")
set(INLINED_VECTOR_TEST_NOEXCEPTIONS_PUBLIC_LIBRARIES base throw_delegate test_instance_tracker_lib)

abseil_test(inlined_vector_test_noexceptions)


# test test_instance_tracker_test
set(TEST_INSTANCE_TRACKER_TEST_SRC "internal/test_instance_tracker_test.cc")
set(TEST_INSTANCE_TRACKER_TEST_PUBLIC_LIBRARIES base throw_delegate test_instance_tracker_lib)


abseil_test(test_instance_tracker_test)


