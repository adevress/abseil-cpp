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


set(SUPPORTED_COMPILER_LANGUAGE_LIST "C;CXX")

## detect compiler
foreach(COMPILER_LANGUAGE ${SUPPORTED_COMPILER_LANGUAGE_LIST})

    if(CMAKE_${COMPILER_LANGUAGE}_COMPILER_ID STREQUAL "XL")
        set(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_XLC ON)
    elseif(CMAKE_${COMPILER_LANGUAGE}_COMPILER_ID STREQUAL "Intel")
        set(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_ICC ON)
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        set(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_MSVC)
    elseif(${CMAKE_${COMPILER_LANGUAGE}_COMPILER_ID} STREQUAL "Clang")
        set(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_CLANG ON)
    else(CMAKE_${COMPILER_LANGUAGE}_COMPILER_ID STREQUAL "GNU")
        set(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_GCC ON)
    endif()

endforeach()




foreach(COMPILER_LANGUAGE ${SUPPORTED_COMPILER_LANGUAGE_LIST})

    set(CMAKE_${COMPILER_LANGUAGE}_WARNING_VLA "")
    set(CMAKE_${COMPILER_LANGUAGE}_WARNING_PEDANTIC "")

    # XLC compiler
    if(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_XLC)

        # XLC -qinfo=all is awfully verbose on any platforms that use the GNU STL
        # Enable by default only the relevant one
        set(CMAKE_${COMPILER_LANGUAGE}_WARNING_ALL "-qformat=all -qinfo=lan:trx:ret:zea:cmp:ret")

        set(CMAKE_${COMPILER_LANGUAGE}_DEBUGINFO_FLAGS "-g")

        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NONE "-O0")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NORMAL "-O2")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_AGGRESSIVE "-O3")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_FASTEST "-O5")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_MINSIZE "")

        set(CMAKE_${COMPILER_LANGUAGE}_NO_ASSERT "-DNDEBUG")

        set(CMAKE_${COMPILER_LANGUAGE}_STACK_PROTECTION "-qstackprotect")

        set(CMAKE_${COMPILER_LANGUAGE}_POSITION_INDEPENDENT "-qpic=small")

        set(CMAKE_${COMPILER_LANGUAGE}_VECTORIZE "-qhot")

    # Microsoft compiler
    elseif(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_MSVC)

        set(CMAKE_${COMPILER_LANGUAGE}_DEBUGINFO_FLAGS "/Zi")

        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NONE "")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NORMAL "/O2")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_AGGRESSIVE "/O2")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_FASTEST "/O2")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_MINSIZE "/Os")

        set(CMAKE_${COMPILER_LANGUAGE}_STACK_PROTECTION "/GS")

        set(CMAKE_${COMPILER_LANGUAGE}_EXCEPTIONS "/U_HAS_EXCEPTIONS /D_HAS_EXCEPTIONS=1 /EHsc")

        # enable by default on MSVC
        set(CMAKE_${COMPILER_LANGUAGE}_POSITION_INDEPENDENT "")


    ## GCC, CLANG, rest of the world
    else()

        set(CMAKE_${COMPILER_LANGUAGE}_WARNING_ALL "-Wall -Wextra")

        set(CMAKE_${COMPILER_LANGUAGE}_WARNING_VLA "-Wvla")
        set(CMAKE_${COMPILER_LANGUAGE}_WARNING_PEDANTIC "-Wpedantic")

        set(CMAKE_${COMPILER_LANGUAGE}_DEBUGINFO_FLAGS "-g")

        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NONE "-O0")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_NORMAL "-O2")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_AGGRESSIVE "-O3")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_FASTEST "-Ofast")
        set(CMAKE_${COMPILER_LANGUAGE}_OPT_MINSIZE "-Os")

        set(CMAKE_${COMPILER_LANGUAGE}_NO_ASSERT "-DNDEBUG")

        set(CMAKE_${COMPILER_LANGUAGE}_STACK_PROTECTION "-fstack-protector")

        set(CMAKE_${COMPILER_LANGUAGE}_EXCEPTIONS "-fexceptions")

        set(CMAKE_${COMPILER_LANGUAGE}_POSITION_INDEPENDENT "-fPIC")

        set(CMAKE_${COMPILER_LANGUAGE}_VECTORIZE "-ftree-vectorize")

        if(CMAKE_${COMPILER_LANGUAGE}_COMPILER_IS_GCC AND ( CMAKE_${COMPILER_LANGUAGE}_COMPILER_VERSION VERSION_GREATER "4.7.0") )
            set(CMAKE_${COMPILER_LANGUAGE}_LINK_TIME_OPT "-flto")
        endif()

    endif()



endforeach()

# CXX specific
if(CMAKE_CXX_COMPILER_IS_XLC)
    set(CMAKE_CXX_STD_CXX11 "-qlanglvl=extended0x")
    set(CMAKE_CXX_STD_CXX14 "${CMAKE_CXX_STD_CXX11}")
    set(CMAKE_CXX_STD_CXX17 "${CMAKE_CXX_STD_CXX11}")
elseif(CMAKE_CXX_COMPILER_IS_MSVC)
    set(CMAKE_CXX_STD_CXX11 "/std:c++14")   # c++11 flag does not exist for MSVC, enable 14 by default
    set(CMAKE_CXX_STD_CXX14 "/std:c++14")
    set(CMAKE_CXX_STD_CXX17 "/std:c++17")
else()
    set(CMAKE_CXX_STD_CXX11 "-std=c++11")
    set(CMAKE_CXX_STD_CXX14 "-std=c++14")
    set(CMAKE_CXX_STD_CXX17 "-std=c++17")
endif()
