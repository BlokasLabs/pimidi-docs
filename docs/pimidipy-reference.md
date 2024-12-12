# pimidipy API Reference

In this section you'll find the entire API Reference for the `pimidipy` library.

## pimidipy Classes

### PimidiPy

::: pimidipy.PimidiPy
	options:
		members: [__init__, list_ports, resolve_port_name, get_port, get_input_port, get_output_port, open_input, open_output, drain_output, quit, run]

### PortDirection

::: pimidipy.PortDirection

### PortInfo

::: pimidipy.PortInfo

### InputPort

::: pimidipy.InputPort
	options:
		inherited_members: true
		members: [name, is_input, is_output, add_callback, remove_callback, close]

### OutputPort

::: pimidipy.OutputPort
	options:
		inherited_members: true
		members: [name, is_input, is_output, write, close]

## pimidipy Channel Events

### NoteOnEvent

::: pimidipy.NoteOnEvent

### NoteOffEvent

::: pimidipy.NoteOffEvent

### ControlChangeEvent

::: pimidipy.ControlChangeEvent

### AftertouchEvent

::: pimidipy.AftertouchEvent

### ProgramChangeEvent

::: pimidipy.ProgramChangeEvent

### ChannelPressureEvent

::: pimidipy.ChannelPressureEvent

### PitchBendEvent

::: pimidipy.PitchBendEvent

### Control14BitChangeEvent

::: pimidipy.Control14BitChangeEvent

### NRPNChangeEvent

::: pimidipy.NRPNChangeEvent

### RPNChangeEvent

::: pimidipy.RPNChangeEvent

## pimidipy System Common Events

### SongPositionPointerEvent

::: pimidipy.SongPositionPointerEvent

### SongSelectEvent

::: pimidipy.SongSelectEvent

### TuneRequestEvent

::: pimidipy.TuneRequestEvent

### SysExEvent

::: pimidipy.SysExEvent

## pimidipy System Real Time Events

### StartEvent

::: pimidipy.StartEvent

### ContinueEvent

::: pimidipy.ContinueEvent

### StopEvent

::: pimidipy.StopEvent

### ClockEvent

::: pimidipy.ClockEvent

### ResetEvent

::: pimidipy.ResetEvent

### ActiveSensingEvent

::: pimidipy.ActiveSensingEvent

## Other Events

### MidiBytesEvent

::: pimidipy.MidiBytesEvent
