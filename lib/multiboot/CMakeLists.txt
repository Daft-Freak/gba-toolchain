#===============================================================================
#
# CMakeLists.txt for compiling libmultiboot
#
# Copyright (C) 2021-2022 gba-toolchain contributors
# For conditions of distribution and use, see copyright notice in LICENSE.md
#
#===============================================================================

cmake_minimum_required(VERSION 3.1)
project(multiboot ASM C)

add_library(multiboot STATIC crt0.s ../gba-sbrk.c)

if(CMAKE_C_COMPILER_ID STREQUAL "Clang")
    set(optimization -Oz)
else()
    set(optimization -Os)
endif()

target_compile_options(multiboot PRIVATE
    $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp>
    $<$<COMPILE_LANGUAGE:C>:${optimization} -mabi=aapcs -march=armv4t -mcpu=arm7tdmi -mthumb -ffunction-sections -fdata-sections -Wall -Wextra -Wno-unused-parameter>
)
target_link_options(multiboot PRIVATE -Wl,--gc-sections)
target_include_directories(multiboot PRIVATE .)

if(USE_DEVKITARM)
    target_compile_definitions(multiboot PUBLIC __DEVKITARM__)
else()
    set(specs "-specs=${ARM_GNU_TOOLCHAIN}/arm-none-eabi/lib/nano.specs" "-specs=${ARM_GNU_TOOLCHAIN}/arm-none-eabi/lib/nosys.specs")
endif()

target_link_options(multiboot INTERFACE
    -T ${CMAKE_CURRENT_LIST_DIR}/../ldscripts/multiboot.ld
    ${specs}
    -B ${CMAKE_CURRENT_BINARY_DIR}
)
