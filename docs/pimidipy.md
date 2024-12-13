# Python pimidipy Library

## Introduction

If you'd visit the homepage of [Python](https://python.org/){target=_blank}, you'd be greeted with a message saying "*Python is a programming language that lets you work quickly and integrate systems more effectively.*" Indeed - with just a few lines of code we can make it do wild things with MIDI.

To make it as smooth as possible, we've created the `pimidipy` library which makes processing MIDI data a breeze!

We recommend using the pimidipy [Patchbox Module](pimidipy-patchbox-module.md) to run your scripts in the background automatically, but executing your scripts on their own will work just fine as well.

`pimidipy` library makes interacting with MIDI devices through Python extremely simple, while it takes care of all the low level details for you. On this page we'll walk you through the setup and basic usage of the library.

For more detailed information on various classes, types and methods, take a glance at the [pimidipy Reference](pimidipy-reference.md) page.

## Example Scripts

For some example scripts, see the [Patchbox Module](pimidipy-patchbox-module.md#example-scripts) documentation.

## Setup

First things first, we must have the `pimidipy` library installed and ready to go. If you have followed the Getting Started steps, chances are, you already have `pimidipy` set up via our APT server and may skip to the [next section](#basics).

### Via APT

This method is the one for making `pimidipy` available system-wide. First make sure our APT server is set up:

`curl https://blokas.io/apt-setup.sh | sh`

Then to install the package, run:

`sudo apt install -y python3-pimidipy`

### Via PIP

For installing via [`pip`](https://pip.pypa.io/){target=_blank} (Package Installer for Python), you should use a Virtual Environment, which isolates the Python you run from the system-wide environment. If you haven't got one already, set up a Virtual Environment for your Python:

`python3 -m venv ~/my_venv`

Now you must activate it. It must be done once every time you restart your system or terminal and want to work within the Virtual Environment:

`source ~/my_venv/bin/activate`

And finally, install the `pimidipy` library:

`pip install --upgrade pimidipy`

## Basics

Every script you write, you'll want to start off with initializing the `pimidipy` library:

```py3
#!/usr/bin/env python3
from pimidipy import *
pimidipy = PimidiPy()
```

This creates a global `pimidipy` instance which is our gateway from Python to the MIDI world.

Once you save your script to a file with `.py` extension, you have to enable the 'execute' flag on your script.
Assuming we've named the file as `pimidipy_example.py`, you can enable the flag using the following command, it's enough to do this once per file:

`chmod +x pimidipy_example.py`

Then you may run it like this:

`./pmidipy_example.py`

### Listing MIDI Ports

The [PimidiPy](pimidipy-reference.md#pimidipy) class has a [`list_ports`](pimidipy-reference.md#pimidipy.PimidiPy.list_ports) method that gives us an iterable list of ports currently available:

```py3
#!/usr/bin/env python3
from pimidipy import *
pimidipy = PimidiPy()

for port in pimidipy.list_ports():
	print(f'{port.address} {port.client_name} {port.port_name} {repr(port.direction)}')
```

This script produces output like this:

```text
28:0 pimidi0 pimidi-a <PortDirection.BOTH: 3>
28:1 pimidi0 pimidi-b <PortDirection.BOTH: 3>
```

Listing of ports is optional, as `pimidipy` provides a mechanism for getting default ports and overriding the ports without having to hardcode the port names in your script, see below sections for more on this.

### ALSA Sequencer MIDI Port Names

ALSA Sequencer MIDI Port Names are made up of two parts - the Client Name/ID and the Port Name/ID separated by a colon (:).

Based on the output from previous section, we can see the `28:0` and `28:1` addresses are referring to Pimidi's (with `sel=0`) A and B ports.
However, there's no guarantees that the assigned Client ID will be the same after a system restart or even within the same session, especially
for removable devices, such as USB MIDI controllers. Therefore, as ALSA Sequencer also accepts text names, the most stable way to refer to the
device is using identifiers like `pimidi0:0` for Pimidi's port A and `pimidi0:1` for port B.

Furthermore, when using a Client Name, ALSA actually treats it as a prefix - it does not have to be an exact match, it's enough to match partially. For example, using `pimidi:1` would match `pimidi0:1` port as well. If the prefix matches multiple clients, one of them gets picked.

See also: [Configuring pimidipy Ports](#configuring-pimidipy-ports)

### Outputting One-Off MIDI Data

You may produce MIDI events at will from your script, simply by using the `write` method on an OutputPort object:

```py3
#!/usr/bin/env python3
from pimidipy import *
pimidipy = PimidiPy()

with pimidipy.open_output("pimidi0:1") as output:
	output.write(ProgramChangeEvent(channel=0, program=20))
```

<small>__Note:__ Prefer using `pimidipy.open_output(1)` or `pimidipy.get_output_port(1)` instead of hardcoding the name string, see the [below section](#configuring-pimidipy-ports).</small>

This will send a ProgramChange event to Pimidi `sel=0` output port B on Channel 1, Program Number 20. Note that the channel numbers are expected to be within 0 - 15 range, they refer to channels 1 - 16 as seen on MIDI devices and software.

### Configuring pimidipy Ports

Referring to MIDI ports by name in your scripts requires editing the script every time you want to remap the code to use a different set of ports. To avoid having to hardcode the MIDI port names into the scripts, `pimidipy` library offers a mechanism for default port names and overriding them through environment variables or `/etc/pimidipy.conf` file. The [PimidiPy](pimidipy-reference.md#pimidipy) class offers [`get_input_port`](pimidipy-reference.md#pimidipy.PimidiPy.get_input_port) and [`get_output_port`](pimidipy-reference.md#pimidipy.PimidiPy.get_output_port) static methods that take a 0 based positive integer number and return a string port name that can be used with the [`open_input`](pimidipy-reference.md#pimidipy.PimidiPy.open_input) and [`open_output`](pimidipy-reference.md#pimidipy.PimidiPy.open_output) methods. The `open_...` methods may take an integer ID directly for quicker access.

By default, the ID number provided to the functions refer to these ports:

| ID Number | Port Name   | ID Number | Port Name   |
| --------- | ----------- | --------- | ----------- |
| `0`       | `pimidi0:0` | `4`       | `pimidi2:0` |
| `1`       | `pimidi0:1` | `5`       | `pimidi2:1` |
| `2`       | `pimidi1:0` | `6`       | `pimidi3:0` |
| `3`       | `pimidi1:1` | `7`       | `pimidi3:1` |

Using ID number above 7 will result in an exception raised, unless there's an override for that number in `/etc/pimidipy.conf`.

If we'd want to use `pimidi2:1` input instead of the default `pimidi0:0` input (ID 0) and use `pimidi1:1` output instead of the default `pimidi2:1` output (ID 5), we can add these lines to `/etc/pimidipy.conf`:

```
PORT_IN_0=pimidi2:1
PORT_OUT_5=pimidi1:1
```

If using the pimidipy Patchbox Module, the currently active `pimidipy` script is automatically restarted every time there are changes in `/etc/pimidipy.conf`, so changes take effect immediately.

See also: [ALSA Sequencer MIDI Port Names](#alsa-sequencer-midi-port-names)

### Forwarding MIDI Data Between Ports

Let's say we want whatever MIDI message that arrives on the Pimidi's MIDI Input Port A to be sent out as is from the MIDI Output Port B.
To achieve that, we must open the required ports by name and register a callback on the Input that will forward data to the Output
and start the `pimidipy` main loop.

```py3
#!/usr/bin/env python3
from pimidipy import *
pimidipy = PimidiPy()

input = pimidipy.open_input(0)
output = pimidipy.open_output(1)

def forward(event):
	print(f'Forwarding event {event} from {input.name} to {output.name}')
	output.write(event)

input.add_callback(forward)

pimidipy.run()
```

The `forward` function will get called any time a MIDI event is received on the input.

### Discarding Events and Forwarding Only Note On and Off Events

Now let's say we want to selectively forward the Note On and Note Off events, but discard the rest kinds of events, we may write a callback function such as this:

```py3
#!/usr/bin/env python3
from pimidipy import *
pimidipy = PimidiPy()

input = pimidipy.open_input(0)
output = pimidipy.open_output(0)

def discard_non_note_events(event):
	if type(event) in [NoteOnEvent, NoteOffEvent]:
		print(f'Passing event {event} from {input.name} along to {output.name}.')
		output.write(event)
	else:
		print(f'Discarding event {event} from {input.name}')

input.add_callback(discard_non_note_events)

pimidipy.run()
```

### Producing a Chord

Now that we know how to detect Note On and Note Off events, let's see how we can produce some modified events to produce a major chord:

```py3
#!/usr/bin/env python3
from functools import partial
from pimidipy import *
pimidipy = PimidiPy()

input = pimidipy.open_input(0)
output = pimidipy.open_output(0)

def produce_chord(event, semitones: list[int]):
	if type(event) == NoteOnEvent:
		print(f'Producing chord for {event} from {input.name} to {output.name}')
		for semitone in semitones:
			output.write(NoteOnEvent(
				event.channel,
				event.note + semitone,
				event.velocity)
				)
	elif type(event) == NoteOffEvent:
		print(f'Producing note offs for {event} from {input.name} to {output.name}')
		for semitone in semitones:
			output.write(NoteOffEvent(
				event.channel,
				event.note + semitone,
				event.velocity)
				)
	else:
		print(f'Discarding event {event}  from {input.name}')

input.add_callback(partial(produce_chord, semitones=[0, 4, 7]))

pimidipy.run()
```

You may get different kinds of chords playing by modifying the `semitones` argument.
