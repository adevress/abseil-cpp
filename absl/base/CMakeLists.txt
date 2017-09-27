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

list(APPEND BASE_PUBLIC_HEADERS
  "attributes.h"
  "call_once.h"
  "casts.h"
  "config.h"
  "dynamic_annotations.h"
  "macros.h"
  "optimization.h"
  "policy_checks.h"
  "port.h"
  "thread_annotations.h"
)


list(APPEND BASE_INTERNAL_HEADERS
  "internal/atomic_hook.h"
  "internal/cycleclock.h"
  "internal/endian.h"
  "internal/exception_testing.h"
  "internal/identity.h"
  "internal/invoke.h"
  "internal/log_severity.h"
  "internal/low_level_alloc.h"
  "internal/low_level_scheduling.h"
  "internal/malloc_extension_c.h"
  "internal/malloc_extension.h"
  "internal/malloc_hook_c.h"
  "internal/malloc_hook.h"
  "internal/malloc_hook_invoke.h"
  "internal/per_thread_tls.h"
  "internal/raw_logging.h"
  "internal/scheduling_mode.h"
  "internal/spinlock.h"
  "internal/spinlock_wait.h"
  "internal/sysinfo.h"
  "internal/thread_identity.h"
  "internal/throw_delegate.h"
  "internal/tsan_mutex_interface.h"
  "internal/unaligned_access.h"
  "internal/unscaledcycleclock.h"
)


# base main library
list(APPEND BASE_SRC 
    "internal/cycleclock.cc"
    "internal/raw_logging.cc"
    "internal/spinlock.cc"
    "internal/sysinfo.cc"
    "internal/thread_identity.cc"
    "internal/unscaledcycleclock.cc"
    "internal/spinlock_wait.cc"
    "internal/low_level_alloc.cc"
    "internal/malloc_hook.cc"
    "dynamic_annotations.cc"
    ${BASE_PUBLIC_HEADERS}
    ${BASE_INTERNAL_HEADERS}
)

abseil_library(base)

# malloc extension library
set(MALLOC_EXTENSION_SRC "internal/malloc_extension.cc")
set(MALLOC_EXTENSION_PUBLIC_LIBRARIES base)

abseil_library(malloc_extension)

# throw delegate library
set(THROW_DELEGATE_SRC "internal/throw_delegate.cc")

abseil_library(throw_delegate)


install(FILES ${BASE_PUBLIC_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/base)
install(FILES ${BASE_INTERNAL_HEADERS}
        DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/base/internal)

#
## TESTS
#

# call once test
set(CALL_ONCE_TEST_SRC "call_once_test.cc")
set(CALL_ONCE_TEST_PUBLIC_LIBRARIES base synchronization)

abseil_test(call_once_test)


# test bit_cast_test
set(BIT_CAST_TEST_SRC "bit_cast_test.cc")

abseil_test(bit_cast_test)


# test throw_delegate_test
set(THROW_DELEGATE_TEST_SRC "throw_delegate_test.cc")
set(THROW_DELEGATE_TEST_PUBLIC_LIBRARIES base throw_delegate)

abseil_test(throw_delegate_test)


# test invoke_test
set(INVOKE_TEST_SRC "invoke_test.cc")
set(INVOKE_TEST_PUBLIC_LIBRARIES strings)

abseil_test(invoke_test)


# test spinlock_test_common
set(SPINLOCK_TEST_COMMON_SRC "spinlock_test_common.cc")
set(SPINLOCK_TEST_COMMON_PUBLIC_LIBRARIES base synchronization)

abseil_test(spinlock_test_common)


# test spinlock_test
set(SPINLOCK_TEST_SRC "spinlock_test_common.cc")
set(SPINLOCK_TEST_PUBLIC_LIBRARIES base synchronization)

abseil_test(spinlock_test)


# test endian_test
set(ENDIAN_TEST_SRC "internal/endian_test.cc")

abseil_test(endian_test)


# test config_test
set(CONFIG_TEST_SRC "config_test.cc")
set(CONFIG_TEST_PUBLIC_LIBRARIES base synchronization)
abseil_test(config_test)


# test raw_logging_test
set(RAW_LOGGING_TEST_SRC "raw_logging_test.cc")
set(RAW_LOGGING_TEST_PUBLIC_LIBRARIES base)

abseil_test(raw_logging_test)


# test sysinfo_test
set(SYSINFO_TEST_SRC "internal/sysinfo_test.cc")
set(SYSINFO_TEST_PUBLIC_LIBRARIES base synchronization)

abseil_test(sysinfo_test)


# test low_level_alloc_test
set(LOW_LEVEL_ALLOC_TEST_SRC "internal/low_level_alloc_test.cc")
set(LOW_LEVEL_ALLOC_TEST_PUBLIC_LIBRARIES base)

abseil_test(low_level_alloc_test)


# test thread_identity_test
set(THREAD_IDENTITY_TEST_SRC "internal/thread_identity_test.cc")
set(THREAD_IDENTITY_TEST_PUBLIC_LIBRARIES base synchronization)

abseil_test(thread_identity_test)


# test malloc_extension_system_malloc_test
set(MALLOC_EXTENSION_SYSTEM_MALLOC_TEST_SRC "internal/malloc_extension_test.cc")
set(MALLOC_EXTENSION_SYSTEM_MALLOC_TEST_PUBLIC_LIBRARIES base malloc_extension)
set(MALLOC_EXTENSION_SYSTEM_MALLOC_TEST_PRIVATE_COMPILE_FLAGS "-DABSL_MALLOC_EXTENSION_TEST_ALLOW_MISSING_EXTENSION=1")

abseil_test(malloc_extension_system_malloc_test)




