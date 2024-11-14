# ALSA

The Advanced Linux Sound Architecture (ALSA) provides audio and MIDI functionality to the Linux operating system.
It provides two distinct methods of communicating MIDI between software and hardware - RawMIDI and ALSA Sequencer.

If possible, prefer configuring your software to use ALSA Sequencer over RawMIDI, as this provides more flexibility
when sharing the same software and hardware MIDI ports.

## RawMIDI

RawMIDI interface gives a software application exclusive access to a hardware MIDI port, allowing raw MIDI data read/write access.
Communication between software programs using RawMIDI is only possible through using a virtual RawMIDI loopback device.

### RawMIDI Device Identifiers

Run `amidi -l` to see the list of RawMIDI devices available to your system:

```bash
patch@patchbox:~ $ amidi -l
Dir Device    Name
IO  hw:0,0,0  pimidi0-a
IO  hw:0,0,1  pimidi0-b
```

The `hw:0,0,0` and `hw:0,0,1` refer to Pimidi's (which has `sel` set to 0) input & output ports A and B respectively.

However, the `hw:0` part may change unpredictably as you connect more devices and restart your system, it is better to use hardware
identifiers that are persistent. Instead of the `hw:0` prefix, we may use `hw:pimidi0`, and it will stay the same, as long as the `sel`
rotary switch is not changed on the board.

Therefore, prefer using `hw:pimidi0,0,0` and `hw:pimidi0,0,1` to refer to its A and B ports.

If you have a 2nd Pimidi board with `sel` set to 3, you can use `hw:pimidi3,0,0` and `hw:pimidi3,0,1` as persistent identifiers.

### RawMIDI Pimidi Identifiers

Here are all the possible Pimidi RawMIDI persistent identifiers:

| `sel` Position | RawMIDI Identifier for Port A | RawMIDI Identifier for Port B |
| -------------- | ----------------------------- | ----------------------------- |
| 0              | `hw:pimidi0,0,0`              | `hw:pimidi0,0,1`              |
| 1              | `hw:pimidi1,0,0`              | `hw:pimidi1,0,1`              |
| 2              | `hw:pimidi2,0,0`              | `hw:pimidi2,0,1`              |
| 3              | `hw:pimidi3,0,0`              | `hw:pimidi3,0,1`              |

Run `cat /proc/asound/cards` and inspect the output to find the prefixes of other RawMIDI ports:

```text
patch@patchbox:~ $ cat /proc/asound/cards
 0 [pimidi0        ]: snd-pimidi - pimidi0
                      pimidi0 PM-197PEJ5
 1 [MH1RSEMAR      ]: USB-Audio - Midihub MH-1RSEMAR
                      Blokas Midihub MH-1RSEMAR at usb-xhci-hcd.0-2, full speed
...
```

Note the name part in between the `[` and `]`.

### ALSA RawMIDI Utilities

#### amidi

#### 

### RawMIDI Code Examples

* C language: [https://github.com/alsa-project/alsa-lib/blob/master/test/rawmidi.c](https://github.com/alsa-project/alsa-lib/blob/master/test/rawmidi.c){target=_blank}

## ALSA Sequencer

## Hardware 
asdf


zxcv


zxcv