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

list(APPEND SYNCHRONIZATION_PUBLIC_HEADERS
  "barrier.h"
  "blocking_counter.h"
  "mutex.h"
  "notification.h"
)


list(APPEND SYNCHRONIZATION_INTERNAL_HEADERS
  "internal/create_thread_identity.h"
  "internal/graphcycles.h"
  "internal/kernel_timeout.h"
  "internal/per_thread_sem.h"
  "internal/thread_pool.h"
  "internal/waiter.h"
)



# syncrhonisation library
list(APPEND SYNCHRONIZATION_SRC 
    "barrier.cc"
    "blocking_counter.cc"
    "internal/create_thread_identity.cc"
    "internal/per_thread_sem.cc"
    "internal/waiter.cc"
    "internal/graphcycles.cc"
    "notification.cc"
    "mutex.cc"
)
set(SYNCHRONIZATION_PUBLIC_LIBRARIES base malloc_extension time)

abseil_library(synchronization)


install(FILES ${SYNCHRONIZATION_PUBLIC_HEADERS}
    DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/synchronization)
install(FILES ${SYNCHRONIZATION_INTERNAL_HEADERS}
    DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}/absl/synchronization/internal)

#
## TESTS
#


# test barrier_test
set(BARRIER_TEST_SRC "barrier_test.cc")
set(BARRIER_TEST_PUBLIC_LIBRARIES synchronization)

abseil_test(barrier_test)


# test blocking_counter_test
set(BLOCKING_COUNTER_TEST_SRC "blocking_counter_test.cc")
set(BLOCKING_COUNTER_TEST_PUBLIC_LIBRARIES synchronization)

abseil_test(blocking_counter_test)


# test graphcycles_test
set(GRAPHCYCLES_TEST_SRC "internal/graphcycles_test.cc")
set(GRAPHCYCLES_TEST_PUBLIC_LIBRARIES synchronization)

abseil_test(graphcycles_test)


# test mutex_test
set(MUTEX_TEST_SRC "mutex_test.cc")
set(MUTEX_TEST_PUBLIC_LIBRARIES synchronization)

abseil_test(mutex_test)


# test notification_test
set(NOTIFICATION_TEST_SRC "notification_test.cc")
set(NOTIFICATION_TEST_PUBLIC_LIBRARIES synchronization)

abseil_test(notification_test)


# test per_thread_sem_test_common
set(PER_THREAD_SEM_TEST_COMMON_SRC "internal/per_thread_sem_test.cc")
set(PER_THREAD_SEM_TEST_COMMON_PUBLIC_LIBRARIES synchronization strings)

abseil_test(per_thread_sem_test_common)







