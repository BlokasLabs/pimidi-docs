# Getting Started

Pimidi is a compact and stackable 2x2 MIDI interface for Raspberry Pi and compatible Single Board Computers (SBCs). The 3.5mm stereo port jacks follow the MIDI standard (Type A) and can be used with DIN-5 MIDI cables via an adapter.

Pimidi makes use of a minimal set of GPIO pins, and duplicates all of the 40 GPIO pins for easy access to integrate additional boards and external circuitry.

## Hardware Setup

Simply power off your Raspberry Pi or compatible SBC, mount the Pimidi on top of it. Adjust the `sel` position if desired and make note of its current position. The default `sel` value is 0. You may want to pick other `sel` values when stacking multiple Pimidi boards or to make it use an alternative set of GPIO pins. See [here](advanced-configuration.md) for more on this.

// todo: extender instructions

Power up your system and continue with the Software setup below.

## Software Setup

To install the Pimidi software on Debian compatible distributions like <a href="https://www.raspberrypi.org/downloads/raspberry-pi-os/" target="_blank">Raspberry Pi OS</a>, open a terminal (command) window and run:

```
curl https://blokas.io/pimidi/install.sh | sh
```

This will set up the Blokas APT server, install all the software packages for Pimidi, scan for connected Pimidis, load the kernel module, and make the changes in `config.txt` so the Pimidis are ready to go every time the system starts.

**Note:** It can also be used for updating the software or update the `config.txt` if the number of boards or `sel` positions changed.

## Verifying It Works

Run `amidi -l` in a terminal, you should see the Pimidi device(s) listed among other MIDI devices available on the system.
