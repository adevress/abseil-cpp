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
# <NAME>_SRC : sources files for the library
# <NAME>_PUBLIC_LIBRARIES: targets and flags for linking phase
# <NAME>_PRIVATE_COMPILE_FLAGS: compile flags for the library. Will not be exported.
# <NAME>_DISABLE_INSTALL: if set, disable the installation of the library
#
# create a target associated to <NAME>
# libraries are installed under CMAKE_INSTALL_FULL_LIBDIR by default
#
function(abseil_library Name)
    string(TOUPPER ${Name} UPPER_NAME)

    add_library(${Name} STATIC ${${UPPER_NAME}_SRC})

    target_compile_options(${Name} PRIVATE ${ABSL_COMPILE_CXXFLAGS} ${${UPPER_NAME}_PRIVATE_COMPILE_FLAGS} )
    target_link_libraries(${Name} ${${UPPER_NAME}_PUBLIC_LIBRARIES})



    if(${${UPPER_NAME}_DISABLE_INSTALL})
        # reserved for internal dep
    else()
        install(TARGETS ${Name}
            ARCHIVE DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
            LIBRARY DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}
        )
    endif()

endfunction()


#
# create an abseil unit_test and add it to the executed test list
#
# <NAME>_SRC : sources files for the tests
# <NAME>_PUBLIC_LIBRARIES: targets and flags for linking phase.
# <NAME>_PRIVATE_COMPILE_FLAGS: compile flags for the test. Will not be exported.
#
# create a target associated to <NAME>_bin
#
# all tests will be register for execution with add_test()
#
# test compilation and execution is disable when BUILD_TESTING=OFF
#
function(abseil_test Name)

    if(BUILD_TESTING)

        string(TOUPPER ${Name} UPPER_NAME)

        add_executable(${Name}_bin ${${UPPER_NAME}_SRC})

        target_compile_options(${Name}_bin PRIVATE ${ABSL_COMPILE_CXXFLAGS} ${${UPPER_NAME}_PRIVATE_COMPILE_FLAGS})
        target_link_libraries(${Name}_bin ${${UPPER_NAME}_PUBLIC_LIBRARIES} ${ABSL_TEST_COMMON_LIBRARIES})
        add_dependencies(${Name}_bin ${ABSEIL_PRE_DEPENDENCIES})

        add_test(${Name}_test ${Name}_bin)
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

    configure_file(${SRC_PKG_CONFIG_IN} ${SRC_PKG_CONFIG_OUT} @ONLY)

    message(STATUS "create pkgconfig file ${SRC_PKG_CONFIG_OUT}")

    install(FILES ${SRC_PKG_CONFIG_OUT} DESTINATION ${CMAKE_INSTALL_FULL_LIBDIR}/pkgconfig)

endfunction()
