# Advanced Configuration

## Changing the Address & Data Pin

In most cases, you don't even have to worry about the solder jumpers on Pimidi and stick to the factory defaults, but changing the configuration can be useful when using multiple Pimidi boards stacked together, or combining with other boards or external circuitry.

The default I²C address and Data Pin used by Pimidi can be changed by adjusting the *d\** solder jumpers near the 40 pin GPIO connector. Some cases when you would want to do that include solving an I²C address conflict, and/or making use of a different Data Pin.

By default, Pimidi comes with **d0** solder jumper closed.

The solder jumpers are modifiable using a soldering iron and some solder. To open the solder jumper, you should heat up both pads of a jumper at once and break the bridge to open the jumper. Closing the jumper is done by heating up both pads, adding some solder until a bridge is formed, then moving away the soldering iron. Building the bridge can be easier at lower soldering temperatures. If your soldering iron does not provide temperature control, you may heat it up and disconnect it from the power source, wait for it to cool off a little.

## Specifying the d* Param for Software

If you're using something else than *d0*, say, *d4*, use the following command to load the driver:

```
sudo dtoverlay pimidi d=4
```

or in `/boot/config.txt`:

```
dtoverlay=pimidi,d=4
```

Add an appropriate line for each Pimidi board you have stacked.

## Solder Jumper Positions

There must be exactly one solder jumper closed on Pimidi.

Below is a table of the possible solder jumper configurations:

| Closed Jumper | I²C Address | Data Pin Name | Data Pin Number |
| ------------- | ----------- | ------------- | --------------- |
| d0            | 0x20        | GPIO17        | 11              |
| d1            | 0x21        | GPIO27        | 13              |
| d2            | 0x22        | GPIO23        | 16              |
| d3            | 0x23        | GPIO24        | 18              |
| d4            | 0x24        | GPIO25        | 22              |
| d5            | 0x25        | GPIO05        | 29              |
| d6            | 0x26        | GPIO06        | 31              |
| d7            | 0x27        | GPIO12        | 32              |

## Stacking Multiple Pimidi Boards

In order to stack and use multiple Pimidi boards on a single host board, each Pimidi board should have a unique solder jumper setting. Maximum recommended stack of boards is 6.

For every board stacked, you should run the appropriate `sudo dtoverlay pimidi d=...` command at runtime, or have `dtoverlay=pimidi,d=...` lines for every board in `/boot/config.txt`.

If stacking multiple boards, you should increase the I²C bus baud rate to a higher one, this is done by setting the following parameter in your `/boot/config.txt`:

```
dtparam=i2c_arm=on,i2c_arm_baudrate=17000000
```

Keep in mind if you're using other I²C devices on the same bus, they may not be compatible with high baud rates.

For use with Pimidi, the following baud rates are recommended:

| Baud rate | Stack size (up to) |
| --------- | ------------------ |
| 100000    | 1                  |
| 400000    | 2                  |
| 1700000   | 4                  |
| 3000000   | 6                  |

Using higher baud rates will result in a very slightly lower latency. Other rates are possible, 3.4MHz is the absolute limit for Pimidi, we wouldn't recommend going above 3MHz.

## Firmware Upgrade

If there's ever a need to know more about your Pimidi board and upgrade the firmware, there's `pm-util` program available on [Blokas APT Server](https://apt.blokas.io/){target=_blank}, here's how to add the APT server:

```
curl https://blokas.io/apt-setup.sh | sh
```

Then install the program by running:

```
sudo apt-get install pm-util
```

Check `pm-util --help` for usage:

```
pm-util usage:

    pm-util [-d id] --flash <firmware.bin>
    pm-util         --hash <firmware.bin>
    pm-util [-d id] --verify-firmware <firwmare.bin>
    pm-util [-d id] --read-serial
    pm-util [-d id] --read-bootloader-version
    pm-util [-d id] --read-firmware-version
    pm-util [-d id] --read-hwrev

    -d <id>                     Device id, as selected by solder jumper (factory default: 0)
    --flash <firmware.bin>      Flash firmware
    --hash <firmware.bin>       Print CRC32 hash of the firmware file
    --verify-firmware           Verify the checksum of the firmware file and the device memory contents
    --read-serial               Read serial number
    --read-bootloader-version   Read bootloader version
    --read-firmware-version     Read firmware version
    --read-hwrev                Read hardware revision
    --help                      Print this help
    --version                   Print version

pm-util version 1.0.1 © Blokas https://blokas.io/
```

Any new firmware releases get announced on our forums: [https://community.blokas.io/](https://community.blokas.io/){target=_blank}
