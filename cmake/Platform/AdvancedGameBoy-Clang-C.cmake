#===============================================================================
#
# Copyright (C) 2021-2023 gba-toolchain contributors
# For conditions of distribution and use, see copyright notice in LICENSE.md
#
#===============================================================================

include(Compiler/CMakeCommonCompilerMacros)
include(${CMAKE_ROOT}/Modules/CMakeDetermineCompileFeatures.cmake)
cmake_determine_compile_features(C)

set(CMAKE_C_FLAGS_RELEASE_INIT          "-O3 -DNDEBUG")
set(CMAKE_C_FLAGS_DEBUG_INIT            "-O0 -g -D_DEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT   "-Og -g -DNDEBUG")
set(CMAKE_C_FLAGS_MINSIZEREL_INIT       "-Os -DNDEBUG")
