/*
Copyright 2015 Jun Wako <wakojun@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

#define BACKLIGHT_PWM_DRIVER    PWMD3
#define BACKLIGHT_PWM_CHANNEL   1
#define BACKLIGHT_PAL_MODE      1

#define WS2812_SPI_DRIVER SPID2
#define WS2812_SPI_MOSI_PAL_MODE 0
#define WS2812_SPI_SCK_PAL_MODE 0
#define WS2812_SPI_SCK_PIN B13
#define MAX_DEFERRED_EXECUTORS 10

/*
 * === SM_TD Global Configurations ===
 * More info here <https://github.com/stasmarkin/sm_td/wiki/2.2:-Customization-guide:-Timeouts-per-key>
 * If you have a weak finger, that gets stuck on a key press, so it counts as being held, try to increase SMTD_TIMEOUT_TAP.
 * If you notice, that in quick typing you sometimes get false hold interpretations, try to decrease SMTD_TIMEOUT_RELEASE.
 * If you don't have enough time to make a tap sequence and it resets too early, try to increase SMTD_TIMEOUT_SEQUENCE
 */
#define SMTD_GLOBAL_TAP_TERM 250
#define SMTD_GLOBAL_FOLLOWING_TAP_TERM 200
#define SMTD_GLOBAL_SEQUENCE_TERM 100
#define SMTD_GLOBAL_RELEASE_TERM 20

/* 
 * Removing PERMISSIVE_HOLD helps you type faster.
 * Permissive hold activates the modifier when another key is pressed and 
 * released while the mod-tap is held, regardless of the tapping term. It means
 * that this option allows the user to trigger a keyboard shortcut with a mod-tap
 * key before the end of the tapping term.
 */
#undef PERMISSIVE_HOLD

/*
 * Feature disable options
 *  These options are also useful to firmware size reduction.
 */

/* disable debug print */
//#define NO_DEBUG

/* disable print */
//#define NO_PRINT

/* disable action features */
//#define NO_ACTION_LAYER
//#define NO_ACTION_TAPPING
//#define NO_ACTION_ONESHOT
