# Python

## pimidipy API Reference

### PimidiPy

::: pimidipy.PimidiPy
	options:
		members: [__init__, open_input, open_output, drain_output, quit, run, parse_port_name]

### InputPort

::: pimidipy.InputPort
	options:
		members: [add_callback, remove_callback, close]

### OutputPort

::: pimidipy.OutputPort
	options:
		members: [write, close]

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
