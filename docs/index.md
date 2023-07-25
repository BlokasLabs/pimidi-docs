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

    Use the keyboard arrows, page up, page down buttons, etc... to navigate around the text, apply the necessary text changes. Then hit **Ctrl+X**, then **Y** to exit and save your changes. If instead of **Y** you press **N**, the changes will get discarded.

Reboot the system for changes to take effect (`sudo reboot`)

### Verifying It Works

Run `amidi -l` in a terminal, you should see the Pimidi device(s) listed among other MIDI devices available on the system.

## Advanced Configuration

### Changing the Address & Data Pin

In most cases, you don't even have to worry about the solder jumpers on Pimidi and stick to the factory defaults, but changing the configuration can be useful when using multiple Pimidi boards stacked together, or combining with other boards or external circuitry.

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
| ------------- | ----------- | ------------- | --------------- |
| d0            | 0x20        | GPIO17        | 11              |
| d1            | 0x21        | GPIO27        | 13              |
| d2            | 0x22        | GPIO23        | 16              |
| d3            | 0x23        | GPIO24        | 18              |
| d4            | 0x24        | GPIO25        | 22              |
| d5            | 0x25        | GPIO05        | 29              |
| d6            | 0x26        | GPIO06        | 31              |
| d7            | 0x27        | GPIO12        | 32              |

### Stacking Multiple Pimidi Boards

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

### Firmware Upgrade

If there's ever a need to know more about your Pimidi board and upgrade the firmware, there's `pm-util` program available on [Blokas APT server](https://apt.blokas.io/){target=_blank}, here's how to add the APT server:

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

## Detailed Specs

| Parameter | Value |
| --------- | ----- |
| MIDI Inputs | 2 |
| MIDI Outputs | 2 |
| Input/Output Connectors | 4x 3.5mm stereo jack (MIDI Type A) |
| MIDI Loopback Latency | 1.3ms |
| Minimum I²C Baud Rate | 100kHz |
| Maximum I²C Baud Rate | 3.0MHz |
| Activity LEDs | Input & Output on each port |
| Current Draw | 50mA @ 5.1VDC |
| Dimensions | 58mm x 65mm x 18.5mm |
| Weight | 50g |

### GPIO Pins used

Pimidi make use of the following GPIO pins:

| Pin Name   | Pin Number | Usage         |
| ---------- | ---------- | ------------- |
| GPIO02/SDA | 3          | I²C SDA       |
| GPIO03/SCL | 5          | I²C SCL       |
| GPIO22     | 15         | Reset         |

Additionally, one of the following pins is used, as selected by the *d\** jumper:

| Pin Name   | Pin Number | Closed Jumper |
| ---------- | ---------- | ------------- |
| GPIO17     | 11         | d0            |
| GPIO27     | 13         | d1            |
| GPIO23     | 16         | d2            |
| GPIO24     | 18         | d3            |
| GPIO25     | 22         | d4            |
| GPIO05     | 29         | d5            |
| GPIO06     | 31         | d6            |
| GPIO12     | 32         | d7            |

### Latency

On average, the roundtrip latency, which is the measure of a Note On message going from software through ALSA sequencer, the driver, firmware to physical data output and back all the way to the receiving port, the firmware, the driver, the ALSA sequencer and the software program is around **1.3ms** (if I²C baud rate is set to 3MHz) and **1.4ms** (if I²C baud rate is set to 400kHz). More detailed test results by [`alsa-midi-latency-test`](https://github.com/koppi/alsa-midi-latency-test){target=_blank} program:

??? "3MHz I²C Baud Rate Test Results"

    ```
    alsa-midi-latency-test -i pimidi:0 -o pimidi:0 -R -1
    > alsa-midi-latency-test 0.0.5
    > running on Linux release 5.15.36-rt41-v7l+ (version #1 SMP PREEMPT_RT Mon May 9 12:16:02 EEST 2022) on armv7l
    > set_realtime_priority(SCHED_FIFO, 99).. done.
    > clock resolution: 0.000000001 s

    > sampling 10000 midi latency values - please wait ...
    > press Ctrl+C to abort test

    sample; latency_ms; latency_ms_worst
         0;      1.306;      1.306
       800;      1.451;      1.451
      1440;      1.456;      1.456
      3447;      1.674;      1.674

    > done.

    > latency distribution:
    ...
      1.2 -  1.3 ms:     5667 ##################################################
      1.3 -  1.4 ms:     4317 ######################################
      1.4 -  1.5 ms:        7 #
      1.5 -  1.6 ms:        5 #
      1.6 -  1.7 ms:        3 #
      1.7 -  1.8 ms:        1 #

    > SUCCESS

     best latency was 1.2 ms
     mean latency was 1.3 ms
     worst latency was 1.7 ms, which is great.

    ```

??? "400kHz I²C Baud Rate Test Results"

    ```
    alsa-midi-latency-test -i pimidi:0 -o pimidi:0 -R -1
    > alsa-midi-latency-test 0.0.5
    > running on Linux release 5.15.36-rt41-v7l+ (version #1 SMP PREEMPT_RT Mon May 9 12:16:02 EEST 2022) on armv7l
    > set_realtime_priority(SCHED_FIFO, 99).. done.
    > clock resolution: 0.000000001 s

    > sampling 10000 midi latency values - please wait ...
    > press Ctrl+C to abort test

    sample; latency_ms; latency_ms_worst
         0;      1.585;      1.585

    > done.

    > latency distribution:
    ...
      1.4 -  1.5 ms:     7678 ##################################################
      1.5 -  1.6 ms:     2321 ###############
      1.6 -  1.7 ms:        1 #

    > SUCCESS

     best latency was 1.4 ms
     mean latency was 1.4 ms
     worst latency was 1.6 ms, which is great.
    ```