
## Abseil CMake build instructions



### Setup and Install
Suppose you want to build abseil, install abseil in the directory ${ABSEIL_DIR} and use it
with your favorite new project. The fastest way to do it is to compile and install abseil in bundle mode,
and use it throught pkg-config in your project.


    git clone --recursive https://github.com/abseil/abseil-cpp.git
    cd abseil-cpp 

    configure
    mkdir -p build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=${ABSEIL_DIR} 

    # build
    make -j

    # test
    ctest -V

    # install
    make install

    # absl provides a pkgconfig ( .pc ) file for convenience
    # before usage, setup your pkgconfig path
    # to the abseil install directory
    export PKG_CONFIG_PATH=${ABSEIL_DIR}/lib/pkgconfig:$PKG_CONFIG_PATH


### Example: Use abseil in a manually compiled project

    g++ -pthread -std=c++11 -o my_project_bin $(pkg-config --libs --cflags --static absl) my_project_src.cpp

### Example: Use abseil in a cmake project

    # Add in CMakeLists.txt
    pkg_check_modules(ABSL absl)
    add_executable(my_bin proj.cpp)
    target_link_libraries(my_bin ${ABSL_STATIC_LINK_LIBRARIES})
    target_include_directories(my_bin ${ABSL_STATIC_INCLUDE_DIRS})

### Example: Use abseil in a meson project

    # Add in meson.build
    abseil = dependency('absl')
    exe = executable('my_project', 'prog.cpp', dependencies : abseil)

### Example: Use abseil in an autotools project
    
    # Add in configure.ac
    PKG_CHECK_MODULES([ABSEIL], [absl])



### Other use case : incorporating into an existing CMake project

    In an existing CMake project, it might be easier for you to use
    abseil by incorporating it directly in your project.

    * Download abseil and copy it in a sub-directory in your project.

    * Or add abseil as a git-submodule in your project


    You can then use the cmake `add_subdirectory()` command to include
    abseil directly and use ${ABSL_ALL_LIBRARIES} and ${ABSL_INCLUDE_DIRS}
    to reference abseil targets and include directories at your convenience

    # short CMake example
    # add in your project file
    add_subdirectory(abseil-cpp)

    add_executable(my_exe source.cpp)
    target_link_libraries(my_exe ${ABSL_ALL_LIBRARIES})
    target_include_directories(my_exe ${ABSL_INCLUDE_DIRS})


### For packager and package manager user

Due to the restrictions applying to some package managers and some organisations, it is
possible to compile abseil without using its embedded dependencies ( no bundle mode ).
the Standard CMake `find_package` feature will be used for the dependency resolution.


    cmake -DABSL_NO_BUNDLE=ON -DCMAKE_INSTALL_PREFIX=${ABSEIL_DIR}


