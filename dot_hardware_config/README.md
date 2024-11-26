# Information
These are the build files for the bakeneko65 keyboard. There are two sets of files:
- default
- hrm (home row mods)

They were compiled with QMK and flashed with the QMK toolbox. Here's a brief history of how this came to be so I don't make the same decisions again:

1. Tried Via by using the `MT()` mod-tap function, but it introduced massive delays in normal typing. My WPM basically halved.
2. Tried Kanata and it was the same thing.
3. Lastly, tried QMK with the [sm_td](https://github.com/stasmarkin/sm_td) library, which allowed me to quickly set timeouts so that the delay is reduced significantly.

## Flashing the Firmware
Since I've already done the compilation, it should mean these build files can be reused indefinitely.

1. Install qmk-toolbox with homebrew.
    ```
    brew install qmk-toolbox
    ```

2. Launch the QMK Toolbox application.
3. Click "Add" and browse to the `.bin` file of your choosing. Alternatively, you can drag and drop the `.bin` file into the textbox and it'll paste the path automatically.
4. This is the fun part. Pull the PCB board out of the casing. Look on the underside on the left (opposite side of the arrow keys), there's a binary switch and button.

    `0` on the switch indicates the normal mode. `1` on the switch indicates bootloader mode.

    The button is a reboot button.

5. Keep the keyboard plugged into the computer the entire time. Flip the switch to `1` (bootloader mode) and press the reboot button. QMK Toolbox should recognize that your keyboard is now in bootloader mode by outputting something like:
    ```
    APM32 DFU device connected: Geehy APM32 DFU ISP Mode
    ```
    More importantly, the "Flash" button on the top right should now be active.
6. Click the "Flash" button to flash your firmware. It should run through its log and give a successful output. 

    Oddly enough, during my run it logged an error about sending an exit signal that timed out, but it still flashed successfully.
    
7. Flip the switch back to `0`, press the reboot button, and the keyboard should turn back on with the newly flashed firmware.

## Remapping and Compilation
If for whatever reason I need to remember to how recompile the the firmware, try this:
1. Install QMK with homebrew
    ```
    brew install qmk/qmk/qmk
    ```
2. cd into the `qmk_firmware` directory and initialize QMK. It should be installed in the home folder.
    ```
    cd ~/qmk_firmware
    qmk setup
    ```
3. Browse to `keyboards/cannonkeys/instant65/keymaps` for your bakeneko configurations. Or browse to `keyboards/gmmk/pro/rev1/ansi/keymaps` for your GMMK Pro keyboard. There you will find their respective default configuration files.

4. Duplicate the "default" folder and rename it to your choosing. You'll need this name later in step 5. Make changes to the new configuration as needed.

5. Make sure you're still running this next command in the `qmk_firmware` directory. This command will now compile your configuration to flash.

    ```
    qmk compile -kb cannonkeys/instant65 -km <name_of_custom_config>
    ```

    This should produce new files in the hidden folder `qmk_firmware/.build`. Use the `.bin` to flash the firmare.