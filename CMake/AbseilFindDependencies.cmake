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
if(ABSL_NO_BUNDLE)
    find_package(CCTZ REQUIRED)
else(ABSL_NO_BUNDLE)

    # if not found, try to bundle it
    message(STATUS "Use bundle CCTZ package")

    ## CCTZ has no cmake support YET
    ## for flags compatibility reason and to avoid to mess
    ## with cmake 2.8.11 target dependencies
    ## we compile cctz here with cmake instead of calling cctz Makefile
    # TODO : Add CMake support to CCTZ

    set(CCTZ_SRCDIR "${PROJECT_SOURCE_DIR}/third_party/cctz")

    list(APPEND CCTZ_SOURCES_FILES
        "${CCTZ_SRCDIR}/src/civil_time_detail.cc"
        "${CCTZ_SRCDIR}/src/time_zone_fixed.cc"
        "${CCTZ_SRCDIR}/src/time_zone_format.cc"
        "${CCTZ_SRCDIR}/src/time_zone_if.cc"
        "${CCTZ_SRCDIR}/src/time_zone_impl.cc"
        "${CCTZ_SRCDIR}/src/time_zone_info.cc"
        "${CCTZ_SRCDIR}/src/time_zone_libc.cc"
        "${CCTZ_SRCDIR}/src/time_zone_lookup.cc"
        "${CCTZ_SRCDIR}/src/time_zone_posix.cc"
    )

    add_library(cctz STATIC ${CCTZ_SOURCES_FILES})
    target_compile_options(cctz PRIVATE ${ABSL_COMPILE_CXXFLAGS})
    target_include_directories(cctz PUBLIC ${PROJECT_SOURCE_DIR}/third_party/cctz/include)


    set(CCTZ_INCLUDE_DIRS "${CCTZ_SRCDIR}/include")
    set(CCTZ_LIBRARIES cctz)

    install(TARGETS cctz
        ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
    )
    install(DIRECTORY "${CCTZ_INCLUDE_DIRS}/cctz" DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR})

endif(ABSL_NO_BUNDLE)


if(BUILD_TESTING)

    if(ABSL_NO_BUNDLE)
        find_package(GTest REQUIRED)
        find_package(GMock REQUIRED)
    else(ABSL_NO_BUNDLE)

        message(STATUS "Use bundle GTest package")

        set(GOOGLETEST_SRC "${PROJECT_SOURCE_DIR}/third_party/googletest")

        add_subdirectory(${GOOGLETEST_SRC})

        set(GTEST_INCLUDE_DIRS "${GOOGLETEST_SRC}/googletest/include")
        set(GMOCK_INCLUDE_DIRS "${GOOGLETEST_SRC}/googlemock/include")

        set(GTEST_LIBRARIES gtest)
        set(GTEST_MAIN_LIBRARIES gtest_main)
        set(GMOCK_LIBRARIES gmock)

    endif(ABSL_NO_BUNDLE)

endif()


