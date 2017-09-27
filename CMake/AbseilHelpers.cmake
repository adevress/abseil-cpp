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

include(CMakeParseArguments)

set(_ABSEIL_HELPERS_PATH "${CMAKE_CURRENT_LIST_DIR}")

#
# create a static library based on the following variable
#
# parameters
# SOURCES : sources files for the library
# PUBLIC_LIBRARIES: targets and flags for linking phase
# PRIVATE_COMPILE_FLAGS: compile flags for the library. Will not be exported.
# DISABLE_INSTALL: if set, disable the installation of the library
#
# create a target associated to <NAME>
# libraries are installed under CMAKE_INSTALL_FULL_LIBDIR by default
#
function(abseil_library)
    cmake_parse_arguments(ABSL_LIB
        "DISABLE_INSTALL"
        "TARGET"
        "SOURCES;PUBLIC_LIBRARIES;PRIVATE_COMPILE_FLAGS"
        ${ARGN}
    )

    set(_NAME ${ABSL_LIB_TARGET})
    string(TOUPPER ${_NAME} _UPPER_NAME)

    add_library(${_NAME} STATIC ${ABSL_LIB_SOURCES})

    target_compile_options(${_NAME} PRIVATE ${ABSL_COMPILE_CXXFLAGS} ${ABSL_LIB_PRIVATE_COMPILE_FLAGS} )
    target_link_libraries(${_NAME} ${ABSL_LIB_PUBLIC_LIBRARIES})



    if(${ABSL_LIB_DISABLE_INSTALL})
        # reserved for internal dep
    else()
        install(TARGETS ${_NAME}
            ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
            LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
        )
    endif()

endfunction()


#
# create an abseil unit_test and add it to the executed test list
#
# parameters
# TARGET: target name prefix
# SOURCES: sources files for the tests
# PUBLIC_LIBRARIES: targets and flags for linking phase.
# PRIVATE_COMPILE_FLAGS: compile flags for the test. Will not be exported.
#
# create a target associated to <NAME>_bin
#
# all tests will be register for execution with add_test()
#
# test compilation and execution is disable when BUILD_TESTING=OFF
#
function(abseil_test)

    cmake_parse_arguments(ABSL_TEST
        ""
        "TARGET"
        "SOURCES;PUBLIC_LIBRARIES;PRIVATE_COMPILE_FLAGS"
        ${ARGN}
    )


    if(BUILD_TESTING)

        set(_NAME ${ABSL_TEST_TARGET})
        string(TOUPPER ${_NAME} _UPPER_NAME)

        add_executable(${_NAME}_bin ${ABSL_TEST_SOURCES})

        target_compile_options(${_NAME}_bin PRIVATE ${ABSL_COMPILE_CXXFLAGS} ${ABSL_TEST_PRIVATE_COMPILE_FLAGS})
        target_link_libraries(${_NAME}_bin ${ABSL_TEST_PUBLIC_LIBRARIES} ${ABSL_TEST_COMMON_LIBRARIES})
        add_dependencies(${_NAME}_bin ${ABSEIL_PRE_DEPENDENCIES})

        add_test(${_NAME}_test ${_NAME}_bin)
    endif(BUILD_TESTING)

endfunction()


# generate pkgconfig file
function(abseil_pkgconf_generate)
    set(SRC_PKG_CONFIG_IN ${_ABSEIL_HELPERS_PATH}/absl.pc.in)
    set(SRC_PKG_CONFIG_OUT ${CMAKE_CURRENT_BINARY_DIR}/absl.pc)


    cmake_parse_arguments(PKGCONF
        ""
        "VERSION;URL;NAME;DESCRIPTION"
        "LIB_NAMES;PRIVATE_LIB_NAMES"
        ${ARGN}
    )

    set(PKGCONF_ALL_LIB_NAMES "")
    set(PKGCONF_ALL_PRIVATE_LIB_NAMES "")


    foreach(_PKG_TARGET_NAME ${PKGCONF_LIB_NAMES})
        set(PKGCONF_ALL_LIB_NAMES "${PKGCONF_ALL_LIB_NAMES} -l${_PKG_TARGET_NAME}")
    endforeach()

    foreach(_PKG_PRIVATE_NAME ${PKGCONF_PRIVATE_LIB_NAMES})
        set(PKGCONF_ALL_PRIVATE_LIB_NAMES "${PKGCONF_ALL_PRIVATE_LIB_NAMES} -l${_PKG_PRIVATE_NAME}")
    endforeach()

    # if absolute path are specified, use them
    if((IS_ABSOLUTE ${CMAKE_INSTALL_INCLUDEDIR}) OR (IS_ABSOLUTE ${CMAKE_INSTALL_LIBDIR}))
        set(PKGCONF_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
        set(PKGCONF_INSTALL_INCLUDEDIR "${CMAKE_INSTALL_FULL_LIBDIR}")
        set(PKGCONF_INSTALL_LIBDIR "${CMAKE_INSTALL_FULL_LIBDIR}")
    else()
        set(PKGCONF_INSTALL_PREFIX "\${pcfiledir}/../..")
        set(PKGCONF_INSTALL_INCLUDEDIR "\${prefix}/${CMAKE_INSTALL_INCLUDEDIR}")
        set(PKGCONF_INSTALL_LIBDIR "\${prefix}/${CMAKE_INSTALL_LIBDIR}")
    endif()

    configure_file(${SRC_PKG_CONFIG_IN} ${SRC_PKG_CONFIG_OUT} @ONLY)

    message(STATUS "create pkgconfig file ${SRC_PKG_CONFIG_OUT}")

    install(FILES ${SRC_PKG_CONFIG_OUT} DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/pkgconfig)

endfunction()
