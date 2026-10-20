#!/usr/bin/env bash
set -euo pipefail

# Examples are off: they install demo executables and topology scripts
# that are not part of the library. Tests need the bundled googletest and
# a shared-memory capable runner; they are off as in other hep-forge
# feedstocks.
#
# PicoSHA2 is a bundled header-only submodule in extern/. conda's CMAKE_ARGS
# set CMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY, which re-roots find_path()
# under $PREFIX, so FairMQ's own lookup of the source tree never matches;
# hand CMake the directory directly.
cmake -S . -B build \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_FAIRMQ=ON \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_TIDY_TOOL=OFF \
    -DPicoSHA2_INCLUDE_DIR="${SRC_DIR}/extern/PicoSHA2"

cmake --build build --parallel "${CPU_COUNT}"
cmake --install build
