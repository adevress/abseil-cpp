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


list(APPEND STRINGS_PUBLIC_HEADERS
  "ascii_ctype.h"
  "ascii.h"
  "escaping.h"
  "match.h"
  "numbers.h"
  "str_cat.h"
  "string_view.h"
  "strip.h"
  "str_join.h"
  "str_replace.h"
  "str_split.h"
  "substitute.h"
)


list(APPEND STRINGS_INTERNAL_HEADERS
  "internal/char_map.h"
  "internal/memutil.h"
  "internal/ostringstream.h"
  "internal/resize_uninitialized.h"
  "internal/str_join_internal.h"
  "internal/str_split_internal.h"
  "internal/utf8.h"
)



# add string library
list(APPEND STRINGS_SRC
    "ascii.cc"
    "escaping.cc"
    "internal/memutil.cc"
    "internal/memutil.h"
    "internal/utf8.cc"
    "match.cc"
    "numbers.cc"
    "str_cat.cc"
    "str_replace.cc"
    "str_split.cc"
    "string_view.cc"
    "substitute.cc"
    ${STRINGS_PUBLIC_HEADERS}
    ${STRINGS_INTERNAL_HEADERS}
)
set(STRINGS_PUBLIC_LIBRARIES base throw_delegate)
abseil_library(strings)

install(FILES ${STRINGS_PUBLIC_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/strings)
install(FILES ${STRINGS_INTERNAL_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/strings/internal)

#
## TESTS
#



# test match_test
set(MATCH_TEST_SRC "match_test.cc")
set(MATCH_TEST_PUBLIC_LIBRARIES strings)

abseil_test(match_test)


# test escaping_test
set(ESCAPING_TEST_SRC "escaping_test.cc")
set(ESCAPING_TEST_PUBLIC_LIBRARIES strings base)

abseil_test(escaping_test)


# test ascii_test
set(ASCII_TEST_SRC "ascii_test.cc")
set(ASCII_TEST_PUBLIC_LIBRARIES strings)

abseil_test(ascii_test)


# test memutil_test
set(MEMUTIL_TEST_SRC "internal/memutil_test.cc")
set(MEMUTIL_TEST_PUBLIC_LIBRARIES strings)

abseil_test(memutil_test)


# test utf8_test
set(UTF8_TEST_SRC "internal/utf8_test.cc")
set(UTF8_TEST_PUBLIC_LIBRARIES strings base)

abseil_test(utf8_test)


# test string_view_test
set(STRING_VIEW_TEST_SRC "string_view_test.cc")
set(STRING_VIEW_TEST_PUBLIC_LIBRARIES strings throw_delegate base)

abseil_test(string_view_test)


# test substitute_test
set(SUBSTITUTE_TEST_SRC "substitute_test.cc")
set(SUBSTITUTE_TEST_PUBLIC_LIBRARIES strings base)

abseil_test(substitute_test)


# test str_replace_test
set(STR_REPLACE_TEST_SRC "str_replace_test.cc")
set(STR_REPLACE_TEST_PUBLIC_LIBRARIES strings base throw_delegate)

abseil_test(str_replace_test)


# test str_split_test
set(STR_SPLIT_TEST_SRC "str_split_test.cc")
set(STR_SPLIT_TEST_PUBLIC_LIBRARIES strings base throw_delegate)

abseil_test(str_split_test)


# test ostringstream_test
set(OSTRINGSTREAM_TEST_SRC "internal/ostringstream_test.cc")

abseil_test(ostringstream_test)


# test resize_uninitialized_test
set(RESIZE_UNINITIALIZED_TEST_SRC "internal/resize_uninitialized_test.cc")

abseil_test(resize_uninitialized_test)


# test str_join_test
set(STR_JOIN_TEST_SRC "str_join_test.cc")
set(STR_JOIN_TEST_PUBLIC_LIBRARIES strings)

abseil_test(str_join_test)


# test str_cat_test
set(STR_CAT_TEST_SRC "str_cat_test.cc")
set(STR_CAT_TEST_PUBLIC_LIBRARIES strings)

abseil_test(str_cat_test)


# test numbers_test
set(NUMBERS_TEST_SRC "numbers_test.cc")
set(NUMBERS_TEST_PUBLIC_LIBRARIES strings)

abseil_test(numbers_test)


# test strip_test
set(STRIP_TEST_SRC "strip_test.cc")
set(STRIP_TEST_PUBLIC_LIBRARIES strings)

abseil_test(strip_test)


# test char_map_test
set(CHAR_MAP_TEST_SRC "internal/char_map_test.cc")
set(CHAR_MAP_TEST_PUBLIC_LIBRARIES strings)

abseil_test(char_map_test)




