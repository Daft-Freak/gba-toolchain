#===============================================================================
#
# Sample GBA project with custom linker script + specs
# This project demonstrates enabling C++ exceptions via newlib specs
#
# Copyright (C) 2021-2022 gba-toolchain contributors
# For conditions of distribution and use, see copyright notice in LICENSE.md
#
#===============================================================================

cmake_minimum_required(VERSION 3.18)

project(linker-script-sample ASM C CXX)

if(USE_DEVKITARM)
    message(FATAL_ERROR "This sample is not compatible with USE_DEVKITARM")
endif()

gba_add_library_subdirectory(tonc)

add_executable(helloLinker crt0.s main.cpp sbrk.c)
set_target_properties(helloLinker PROPERTIES SUFFIX ".elf")

target_compile_options(helloLinker PRIVATE -mthumb -fexceptions -ffunction-sections -fdata-sections -Wall -Wextra)

# Link options for linker script and .specs file
target_link_options(helloLinker PRIVATE
    -T ${CMAKE_SOURCE_DIR}/gba-rom.ld
    -specs=${CMAKE_SOURCE_DIR}/gba-exceptions.specs -specs=${ARM_GNU_TOOLCHAIN}/arm-none-eabi/lib/nosys.specs
    -Wl,--gc-sections
)

target_link_libraries(helloLinker PRIVATE tonc)

gba_target_objcopy(helloLinker FIX_HEADER)
