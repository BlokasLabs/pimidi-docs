# Advanced Configuration

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

For use with Pimidi, the following baud rates are recommended:

| Baud Rate | Stack Size (Up To) |
| --------- | ------------------ |
| 100000    | 1                  |
| 400000    | 2                  |
| 1000000   | 4                  |

Using higher baud rates will result in a very slightly lower latency. Other rates are possible, 3.4MHz is the absolute limit for Pimidi. Not all Raspberry Pi models are capable of baud rates above 1MHz.

## Firmware Upgrade

Upgrading the firmware of your Pimidi board is possible via the `pm-util` program available on [Blokas APT Server](https://apt.blokas.io/){target=_blank}, here's how to add the APT server:

```
curl https://blokas.io/apt-setup.sh | sh
```

Then install the program by running:

```
sudo apt-get install pm-util
```

Check `pm-util --help` for up to date usage:

```
pm-util usage:

    pm-util [--sel id] --flash  <firmware.bin>
    pm-util            --hash   <firmware.bin>
    pm-util [--sel id] --verify <firwmare.bin>
    pm-util [--sel id] --read-hash
    pm-util [--sel id] --read-serial
    pm-util [--sel id] --read-bootloader-version
    pm-util [--sel id] --read-firmware-version
    pm-util [--sel id] --read-hwrev

    --sel <id>                  Device id, as selected by the rotary selector (factory default: 0)
    --flash  <firmware.bin>     Flash firmware
    --hash   <firmware.bin>     Print CRC32 hash of the firmware file
    --verify <firmware.bin>     Verify the checksum of the firmware file and the device memory contents
    --read-hash                 Read CRC32 hash of the firmware in the device
    --read-serial               Read serial number
    --read-bootloader-version   Read bootloader version
    --read-firmware-version     Read firmware version
    --read-hwrev                Read hardware revision
    --help                      Print this help
    --version                   Print version

pm-util version 1.0.0 © Blokas https://blokas.io/
```

Any new firmware releases get announced on our forums: [https://community.blokas.io/](https://community.blokas.io/){target=_blank}
