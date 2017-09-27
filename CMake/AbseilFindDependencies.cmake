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
if(NOT ABSL_ENABLE_BUNDLE)

    find_package(CCTZ REQUIRED)

else(NOT ABSL_ENABLE_BUNDLE)

    find_package(CCTZ)
    # embedded dep
    if(NOT CCTZ_FOUND)
        # if not found, try to bundle it
        message(STATUS "No External CCTZ found, Use bundle CCTZ package")

        set(CCTZ_BUNDLE_INTERNAL_INSTALLDIR "${CMAKE_CURRENT_BINARY_DIR}/CCTZ_BUNDLE-prefix/install")
        set(CCTZ_BUNDLE_INTERNAL_SRCDIR "${CMAKE_CURRENT_BINARY_DIR}/CCTZ_BUNDLE-prefix/src/CCTZ_BUNDLE")

        ExternalProject_Add(CCTZ_BUNDLE
            URL "https://github.com/google/cctz/archive/master.zip"
            CONFIGURE_COMMAND ""                            #  pure makefile, no configure
            BUILD_COMMAND "make" "PREFIX=${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}"
                "SRC=${CCTZ_BUNDLE_INTERNAL_SRCDIR}/" "-f" "${CCTZ_BUNDLE_INTERNAL_SRCDIR}/Makefile"
                "CXX=${CMAKE_CXX_COMPILER}" "CC=${CMAKE_C_COMPILER}"
            INSTALL_DIR "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}"
            INSTALL_COMMAND "make" "install"
                "PREFIX=${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}" "SRC=${CCTZ_BUNDLE_INTERNAL_SRCDIR}/" "-f" "${CCTZ_BUNDLE_INTERNAL_SRCDIR}/Makefile"
                "CXX=${CMAKE_CXX_COMPILER}" "CC=${CMAKE_C_COMPILER}"
         )


        list(APPEND ABSEIL_PRE_DEPENDENCIES CCTZ_BUNDLE)

        set(CCTZ_INCLUDE_DIRS "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}/include")
        set(CCTZ_LIBRARIES "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}/lib/libcctz.a")

        add_library(cctz STATIC IMPORTED)
        set_property(TARGET cctz PROPERTY IMPORTED_LOCATION "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}/lib/libcctz.a")
        add_dependencies(cctz CCTZ_BUNDLE)

        install(FILES "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}/lib/libcctz.a" DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR})
        install(DIRECTORY "${CCTZ_BUNDLE_INTERNAL_INSTALLDIR}/include/cctz" DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR})
    endif(NOT CCTZ_FOUND)

endif(NOT ABSL_ENABLE_BUNDLE)


if(BUILD_TESTING)


    if(NOT ABSL_ENABLE_BUNDLE)

        find_package(GTest REQUIRED)
        find_package(GMock REQUIRED)

    else(NOT ABSL_ENABLE_BUNDLE)
        # check for GTest
        find_package(GTest)
        find_package(GMock)

        # embedded dep
        if((NOT GTEST_FOUND) OR (NOT GMOCK_FOUND))
            # if not found, try to bundle it
            message(STATUS "No External GTest found, Use bundle GTest package")

            set(GTEST_BUNDLE_INTERNAL_INSTALLDIR "${CMAKE_CURRENT_BINARY_DIR}/GTEST_BUNDLE-prefix/install")

            ExternalProject_Add(GTEST_BUNDLE
                URL "https://github.com/google/googletest/archive/master.zip"
                CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${GTEST_BUNDLE_INTERNAL_INSTALLDIR}"
                INSTALL_DIR "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}"
                LOG_DOWNLOAD 1
                LOG_BUILD 1
             )

             list(APPEND ABSEIL_PRE_DEPENDENCIES GTEST_BUNDLE)

             set(GTEST_INCLUDE_DIRS "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}/include")
             set(GMOCK_INCLUDE_DIRS "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}/include")

             set(GTEST_LIBRARIES "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}/lib/libgtest.a")
             set(GTEST_MAIN_LIBRARIES "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}/lib/libgtest_main.a")
             set(GMOCK_LIBRARIES "${GTEST_BUNDLE_INTERNAL_INSTALLDIR}/lib/libgmock.a")

        endif((NOT GTEST_FOUND) OR (NOT GMOCK_FOUND))

    endif(NOT ABSL_ENABLE_BUNDLE)

endif()


