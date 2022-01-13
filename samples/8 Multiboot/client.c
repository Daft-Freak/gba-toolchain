/*
===============================================================================

 "hello world" for Multiboot

 Copyright (C) 2021-2022 gba-toolchain contributors
 For conditions of distribution and use, see copyright notice in LICENSE.md

===============================================================================
*/

#include <tonc.h>

int main() {
    REG_DISPCNT = DCNT_MODE0 | DCNT_BG0;

    tte_init_chr4c_default(0, BG_CBB(0) | BG_SBB(31));
    tte_set_pos(92, 68);
    tte_write("Hello, Multiboot!");

    irq_init(NULL);
    irq_enable(II_VBLANK);

    while (1) {
        VBlankIntrWait();
    }
}