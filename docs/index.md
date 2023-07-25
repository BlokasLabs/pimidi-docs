# Getting Started

Pimidi is a compact and stackable 2x2 MIDI interface for Raspberry Pi and compatible Single Board Computers. The 3.5mm stereo port jacks follow the MIDI standard (Type A) and can be used with DIN-5 MIDI cables via an adapter.

Pimidi makes use of a minimal set of GPIO pins, and duplicates all of the 40 GPIO pins for easy access to integrate additional boards and external circuitry.

## Quick Start

### Hardware

Simply power off your Raspberry Pi or compatible SBC, mount the Pimidi on top of it, and power it back on.

// todo: extender instructions

### Software

The device driver can be loaded at runtime by issuing `sudo dtoverlay pimidi` command in a terminal.

To get the driver loaded automatically on system startup, edit your `/boot/config.txt` file as root (see the below collapsed section) within the `[all]` section at the bottom, add the following lines:

```
dtoverlay=pimidi
dtparam=i2c_arm=on,i2c_arm_baudrate=400000
```

??? "Editing Files as Root User"

    Some files are protected and not editable by regular users, here's one way to edit them as `root`, run this command in a terminal:

    ```
    sudo nano /boot/config.txt
    ```

    Use the keyboard arrows, page up, page down button, etc... to navigate around the text, apply the necessary text changes. Then hit **Ctrl+X**, then **Y** to exit and save your changes. If instead of **Y** you press **N**, the changes will get discarded.

Reboot the system for changes to take effect (`sudo reboot`)

### Verifying It Works

Run `amidi -l` in a terminal, you should see the Pimidi device(s) listed among other MIDI devices available on the system.

## Thorough Start

### Changing the Address & Data Pin

In most cases, you don't even have to worry about the solder jumpers on Pimidi and stick to the factory defaults, but changing the configuration can be useful when combining Pimidi with additional floors of Pimidi boards, other boards or external circuitry.

The default I²C address and Data Pin used by Pimidi can be changed by adjusting the *d\** solder jumpers near the 40 pin GPIO connector. Some cases when you would want to do that include solving an I²C address conflict, and/or making use of a different Data Pin.

By default, Pimidi comes with **d0** solder jumper closed.

The solder jumpers are modifiable using a soldering iron and some solder. To open the solder jumper, you should heat up both pads of a jumper at once and break the bridge to open the jumper. Closing the jumper is done by heating up both pads, adding some solder until a bridge is formed, then moving away the soldering iron. Building the bridge can be easier at lower soldering temperatures. If your soldering iron does not provide temperature control, you may heat it up and disconnect it from the power source, wait for it to cool off a little.

### Specifying the d* Param for Software

If you're using something else than *d0*, say, *d4*, use the following command to load the driver:

```
sudo dtoverlay pimidi d=4
```

or in `/boot/config.txt`:

```
dtoverlay=pimidi,d=4
```

Add an appropriate line for each Pimidi board you have stacked.

### Solder Jumper Positions

There must be exactly one solder jumper closed on Pimidi.

Below is a table of the possible solder jumper configurations:

| Closed Jumper | I²C Address | Data Pin Name | Data Pin Number |
|---------------|-------------|---------------|-----------------|
| d0            | 0x20        | GPIO17        | 11              |
| d1            | 0x21        | GPIO27        | 13              |
| d2            | 0x22        | GPIO23        | 16              |
| d3            | 0x23        | GPIO24        | 18              |
| d4            | 0x24        | GPIO25        | 22              |
| d5            | 0x25        | GPIO05        | 29              |
| d6            | 0x26        | GPIO06        | 31              |
| d7            | 0x27        | GPIO12        | 32              |

### Pm-util Program

If there's ever a need to know more about your Pimidi board and upgrade the firmware, there's `pm-util` program available on [Blokas APT server](https://apt.blokas.io/), here's how to add the server:

```
curl https://blokas.io/apt-setup.sh | sh
```

Then install the program by running:

```
sudo apt-get install pm-util
```

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
