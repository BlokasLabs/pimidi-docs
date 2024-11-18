# Amidiminder

## Introduction

[Amidiminder](https://github.com/mzero/amidiminder){target=_blank} is a tool used to manage and automate ALSA Sequencer MIDI connections on Linux systems. This tutorial will guide you through configuring Amidiminder and writing rules files.

## Installation

To install Amidiminder, use the following command:

```sh
sudo apt install amidiminder
```

## Configuration

Amidiminder uses a rules file to define its behavior. The default rules file is located at `/etc/amidiminder.rules`. You should edit this file to suit your needs:

```sh
sudo nano /etc/amidiminder.rules
```

Hit Ctrl+X, then Y to save and exit the editor.

## Writing Rules Files

Rules files define the MIDI connections that Amidiminder should manage. Edit the rules file in the Amidiminder configuration directory:

```sh
sudo nano /etc/amidiminder.rules
```

The port names follow the ALSA Sequencer naming convention describe [here](alsa.md#alsa-sequencer-device-identifiers) with the following extensions:

* `.hw` matches any Hardware port.
* `.app` matches any Software port.
* `...:*` matches all port indices on a named client.
* `*` matches all ports.

A rule is defined using 3 tokens in a line - the port, arrow and the other port.

Here are the possible arrows:

* `-->` - connect Source port to Destination port.
* `<--` - same as above, except Source and Destination positions are reversed.
* `<->` - make a bidirectional connection.
* `-x->` - don't automatically connect Source port to Destination port. Useful when using `.hw` and `.app` interconnection rule.
* `<-x-` - same as above, except Source and Destination positions are reversed.

Let's take a look at an example file which demonstrates every possibility of Amidiminder:

```ini
# Any text after a '#' symbol is a comment.

# Enable automatic bidirectional hardware and
# software ALSA MIDI port connections.
.hw <-> .app

# Disallow automatic MIDI connections to/from a generic
# client name that's used by RtMidi library.
RtMidiIn Client <-x- *
RtMidiOut Client -x-> *

# Connect Pimidi0's B input port to Pure Data.
pimidi0:1 --> Pure Data:0

# Connect Pure Data's output to Pimidi0's A output port.
pimidi0:0 <-- Pure Data:0
```

You can use the `-C` command-line switch to verify the syntax of your rules file for correctness:

```sh
amidiminder -C -f /etc/amidiminder.rules
```

For the rules to take effect, Amidiminder must be restarted using the following command:

```sh
sudo systemctl restart amidiminder.service
```

## Troubleshooting

If you encounter issues with Amidiminder, you can use `systemctl` and `journalctl` commands to troubleshoot.

First, check the status of the Amidiminder service:

```sh
sudo systemctl status amidiminder.service
```

This command will provide you with the current status and any error messages related to the service.

To view the logs for Amidiminder, use the `journalctl` command:

```sh
sudo journalctl -u amidiminder.service
```

This will display the log entries for the Amidiminder service, which can help you identify any issues. Hit the 'end' key to see the latest output. Add a `-f` flag to the above command to enable following the latest output automatically.

If you need to restart the service after making changes, use:

```sh
sudo systemctl restart amidiminder.service
```

To ensure Amidiminder starts automatically at boot, enable the service with:

```sh
sudo systemctl enable --now amidiminder.service
```

If you need to stop the service, use:

```sh
sudo systemctl stop amidiminder.service
```

If you need to completely disable Amidiminder, run these commands:

```sh
sudo systemctl disable --now amidiminder.service
sudo systemctl mask amidiminder.service
```
