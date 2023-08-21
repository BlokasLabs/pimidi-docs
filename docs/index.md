# Getting Started

Pimidi is a compact and stackable 2x2 MIDI interface for Raspberry Pi and compatible Single Board Computers. The 3.5mm stereo port jacks follow the MIDI standard (Type A) and can be used with DIN-5 MIDI cables via an adapter.

Pimidi makes use of a minimal set of GPIO pins, and duplicates all of the 40 GPIO pins for easy access to integrate additional boards and external circuitry.

## Hardware Setup

Simply power off your Raspberry Pi or compatible SBC, mount the Pimidi on top of it, and power it back on.

// todo: extender instructions

## Software Setup

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

## Verifying It Works

Run `amidi -l` in a terminal, you should see the Pimidi device(s) listed among other MIDI devices available on the system.
