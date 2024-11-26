// Copyright 2024 QMK
// SPDX-License-Identifier: GPL-2.0-or-later

/*******************************************************************************
  88888888888 888      d8b                .d888 d8b 888               d8b
      888     888      Y8P               d88P"  Y8P 888               Y8P
      888     888                        888        888
      888     88888b.  888 .d8888b       888888 888 888  .d88b.       888 .d8888b
      888     888 "88b 888 88K           888    888 888 d8P  Y8b      888 88K
      888     888  888 888 "Y8888b.      888    888 888 88888888      888 "Y8888b.
      888     888  888 888      X88      888    888 888 Y8b.          888      X88
      888     888  888 888  88888P'      888    888 888  "Y8888       888  88888P'
                                                        888                 888
                                                        888                 888
                                                        888                 888
     .d88b.   .d88b.  88888b.   .d88b.  888d888 8888b.  888888 .d88b.   .d88888
    d88P"88b d8P  Y8b 888 "88b d8P  Y8b 888P"      "88b 888   d8P  Y8b d88" 888
    888  888 88888888 888  888 88888888 888    .d888888 888   88888888 888  888
    Y88b 888 Y8b.     888  888 Y8b.     888    888  888 Y88b. Y8b.     Y88b 888
     "Y88888  "Y8888  888  888  "Y8888  888    "Y888888  "Y888 "Y8888   "Y88888
         888
    Y8b d88P
     "Y88P"
*******************************************************************************/

#pragma once

#ifndef BACKLIGHT_BREATHING
#    define BACKLIGHT_BREATHING
#endif // BACKLIGHT_BREATHING

#ifndef BACKLIGHT_LEVELS
#    define BACKLIGHT_LEVELS 6
#endif // BACKLIGHT_LEVELS

#ifndef BACKLIGHT_PIN
#    define BACKLIGHT_PIN A6
#endif // BACKLIGHT_PIN

#ifndef LOCKING_SUPPORT_ENABLE
#    define LOCKING_SUPPORT_ENABLE
#endif // LOCKING_SUPPORT_ENABLE

#ifndef LOCKING_RESYNC_ENABLE
#    define LOCKING_RESYNC_ENABLE
#endif // LOCKING_RESYNC_ENABLE

#ifndef DIODE_DIRECTION
#    define DIODE_DIRECTION COL2ROW
#endif // DIODE_DIRECTION

#ifndef RGBLIGHT_LED_COUNT
#    define RGBLIGHT_LED_COUNT 20
#endif // RGBLIGHT_LED_COUNT

#ifndef WS2812_DI_PIN
#    define WS2812_DI_PIN B15
#endif // WS2812_DI_PIN

#ifndef DEVICE_VER
#    define DEVICE_VER 0x0001
#endif // DEVICE_VER

#ifndef MANUFACTURER
#    define MANUFACTURER "CannonKeys"
#endif // MANUFACTURER

#ifndef PRODUCT
#    define PRODUCT "Instant65"
#endif // PRODUCT

#ifndef PRODUCT_ID
#    define PRODUCT_ID 0x1565
#endif // PRODUCT_ID

#ifndef VENDOR_ID
#    define VENDOR_ID 0xCA04
#endif // VENDOR_ID

#ifndef MATRIX_COLS
#    define MATRIX_COLS 15
#endif // MATRIX_COLS

#ifndef MATRIX_ROWS
#    define MATRIX_ROWS 5
#endif // MATRIX_ROWS

#ifndef MATRIX_COL_PINS
#    define MATRIX_COL_PINS { A8, C13, B9, B8, B7, B6, B5, B4, B3, A7, A5, A4, A3, A2, A1 }
#endif // MATRIX_COL_PINS

#ifndef MATRIX_ROW_PINS
#    define MATRIX_ROW_PINS { A14, A15, A0, B1, B0 }
#endif // MATRIX_ROW_PINS

#ifndef RGBLIGHT_EFFECT_BREATHING
#    define RGBLIGHT_EFFECT_BREATHING
#endif // RGBLIGHT_EFFECT_BREATHING

#ifndef RGBLIGHT_EFFECT_RAINBOW_MOOD
#    define RGBLIGHT_EFFECT_RAINBOW_MOOD
#endif // RGBLIGHT_EFFECT_RAINBOW_MOOD

#ifndef RGBLIGHT_EFFECT_RAINBOW_SWIRL
#    define RGBLIGHT_EFFECT_RAINBOW_SWIRL
#endif // RGBLIGHT_EFFECT_RAINBOW_SWIRL

#ifndef RGBLIGHT_EFFECT_SNAKE
#    define RGBLIGHT_EFFECT_SNAKE
#endif // RGBLIGHT_EFFECT_SNAKE

#ifndef RGBLIGHT_EFFECT_KNIGHT
#    define RGBLIGHT_EFFECT_KNIGHT
#endif // RGBLIGHT_EFFECT_KNIGHT

#ifndef RGBLIGHT_EFFECT_CHRISTMAS
#    define RGBLIGHT_EFFECT_CHRISTMAS
#endif // RGBLIGHT_EFFECT_CHRISTMAS

#ifndef RGBLIGHT_EFFECT_STATIC_GRADIENT
#    define RGBLIGHT_EFFECT_STATIC_GRADIENT
#endif // RGBLIGHT_EFFECT_STATIC_GRADIENT

#ifndef RGBLIGHT_EFFECT_RGB_TEST
#    define RGBLIGHT_EFFECT_RGB_TEST
#endif // RGBLIGHT_EFFECT_RGB_TEST

#ifndef RGBLIGHT_EFFECT_ALTERNATING
#    define RGBLIGHT_EFFECT_ALTERNATING
#endif // RGBLIGHT_EFFECT_ALTERNATING

#ifndef RGBLIGHT_EFFECT_TWINKLE
#    define RGBLIGHT_EFFECT_TWINKLE
#endif // RGBLIGHT_EFFECT_TWINKLE
