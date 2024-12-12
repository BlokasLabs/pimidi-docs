# Advanced Configuration

## Manual System Setup

The device driver can be loaded at runtime by executing `sudo dtoverlay pimidi sel=0` command in a terminal. Change the `0` into the `sel` switch's current position if needed. You have to run this command for every Pimidi in your stack with appropriate `sel` values.

To get the driver loaded automatically on system startup, edit your `/boot/firmware/config.txt` file as the root user within the `[all]` section at the bottom, add the following lines:

```
dtparam=i2c_arm=on,i2c_arm_baudrate=1000000
dtoverlay=pimidi,sel=0
```

Change the `sel=` value as needed. Add multiple `dtoverlay=pimidi,sel=...` lines for every Pimidi in your stack.

??? "Editing Files as Root User"

    Some files are protected and not editable by regular users, here's one way to edit them as `root`, run this command in a terminal:

    `sudo nano /boot/firmware/config.txt`

    Use the keyboard arrows, page up, page down buttons, etc... to navigate around the text, apply the necessary text changes. Then hit **Ctrl+X**, then **Y** to exit and save your changes. If instead of **Y** you press **N**, the changes will get discarded.

Reboot the system for changes to take effect (`sudo reboot`)

## Changing the Address & Data Pin

In most cases, you don't even have to worry about changing the `sel` position on Pimidi and stick to the factory default 0, but changing the configuration is useful when using multiple Pimidi boards stacked together, or combining with other boards or external circuitry.

The default I²C address and Data Pin used by Pimidi can be changed by adjusting the `sel` rotary switch located close to the 40 pin GPIO header. Some cases when you would want to do that include solving an I²C address conflict, and/or making use of a different Data Pin.

By default, Pimidi comes with `sel` set to 0.

Use a slotted (-) screw driver to rotate the `sel` rotary switch to make the arrow point at the desired position.

The matching `sel` parameter must be provided in system configuration.

## `sel` Positions

Below is a table of the possible `sel` configurations:

| `sel` Position | I²C Address | Data Pin Name | Data Pin Number |
| -------------- | ----------- | ------------- | --------------- |
| 0 (default)    | 0x20        | GPIO23        | 16              |
| 1              | 0x21        | GPIO05        | 29              |
| 2              | 0x22        | GPIO06        | 31              |
| 3              | 0x23        | GPIO27        | 13              |

## Specifying the `sel` Param for Software

If you're using something else than `sel=0`, say, `sel=3`, use the following command to load the driver:

```
sudo dtoverlay pimidi sel=3
```

or in `/boot/firmware/config.txt`:

```
dtoverlay=pimidi,sel=3
```

Add an appropriate line for each Pimidi board you have stacked.

## Stacking Multiple Pimidi Boards

In order to stack and use multiple Pimidi boards on a single host board, each Pimidi board should have a unique `sel` setting. The maximum stack of Pimidi boards is 4.

For every board stacked, you should run the appropriate `sudo dtoverlay pimidi sel=...` command at runtime, or have `dtoverlay=pimidi,sel=...` lines for every board in `/boot/firmware/config.txt`.

If the I²C bus is used with other I²C devices than Pimidi, check their specifications for the supported I²C baud rates, and set the baud rate to one supported by all devices on the same bus. The baud rate parameter can be configured in your `/boot/firmware/config.txt`:

```
dtparam=i2c_arm=on,i2c_arm_baudrate=1000000
```

Depending on the Pimidi stack size, the following minimum baud rates are recommended:

| Baud Rate | Stack Size (Up To) |
| --------- | ------------------ |
| 100000    | 1                  |
| 400000    | 2                  |
| 1000000   | 4                  |

Using higher baud rates will result in a very slightly lower latency. Other rates are possible. 3.4MHz is the absolute limit for Pimidi. Not all Raspberry Pi models are capable of baud rates above 1MHz.
