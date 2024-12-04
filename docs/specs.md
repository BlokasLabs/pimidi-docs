# Detailed Specs

Pimidi is a MIDI interface for the Raspberry Pi that adheres to the Hardware Attached on Top (HAT) specification. It features 2 MIDI inputs and outputs using 3.5mm stereo jacks (MIDI Type A), and utilizes standard GPIO pins for communication. With a low average roundtrip latency of around 1.3ms at a 1MHz I²C baud rate, Pimidi is suitable for real-time MIDI applications. This document provides detailed specifications, GPIO pin usage, and latency performance to assist in integrating Pimidi into your projects.

## General Info

| Parameter               | Value                              |
| ----------------------- | ---------------------------------- |
| MIDI Inputs             | 2                                  |
| MIDI Outputs            | 2                                  |
| Input/Output Connectors | 4x 3.5mm stereo jack (MIDI Type A) |
| MIDI Loopback Latency   | 1.3ms                              |
| Minimum I²C Baud Rate   | 100kHz                             |
| Maximum I²C Baud Rate   | 3.4MHz                             |
| Activity LEDs           | 4                                  |
| Input LED Color         | Orange                             |
| Output LED Color        | Yellow                             |
| Current Draw            | 22mA @ 5.1VDC                      |
| Dimensions              | 65mm x 58.5mm x 18.5mm             |
| Weight                  | 21g                                |

## GPIO Pins Used

Pimidi makes use of the following GPIO pins:

| Pin Name   | Pin Number | Usage         |
| ---------- | ---------- | ------------- |
| GPIO02/SDA | 3          | I²C SDA       |
| GPIO03/SCL | 5          | I²C SCL       |
| GPIO22     | 15         | Reset         |

Additionally, *one* of the following pins is used, as selected by the `sel` rotary switch, for the Data Ready line:

| Pin Name   | Pin Number | `sel` Position |
| ---------- | ---------- | -------------- |
| GPIO23     | 16         | 0 (default)    |
| GPIO05     | 29         | 1              |
| GPIO06     | 31         | 2              |
| GPIO27     | 13         | 3              |

## Latency

On average, the roundtrip latency, which is the measure of a 3 byte Note On message going from software through ALSA sequencer, the driver, firmware to physical data output and back all the way to the receiving port, the firmware, the driver, the ALSA sequencer and the software program is around **1.3ms** (if I²C baud rate is set to 1MHz). More detailed test results by [`alsa-midi-latency-test`](https://github.com/koppi/alsa-midi-latency-test){target=_blank} program:

??? "1MHz I²C Baud Rate Test Results"

    ```
    patch@patchbox:~ $ alsa-midi-latency-test -i pimidi0:0 -o pimidi0:0 -1
    > alsa-midi-latency-test 0.0.5
    > running on Linux release 6.6.63-v8-16k+ (version #1821 SMP PREEMPT Mon Nov 25 13:51:58 GMT 2024) on aarch64
    > clock resolution: 0.000000001 s
    
    > sampling 10000 midi latency values - please wait ...
    > press Ctrl+C to abort test
    
    sample; latency_ms; latency_ms_worst
         0;      1.281;      1.281
      9999;      1.255;      1.281
    > done.
    
    > latency distribution:
    ...
      1.2 -  1.3 ms:      434 ##
      1.3 -  1.4 ms:     9566 ##################################################
    
    > SUCCESS
    
     best latency was 1.2 ms
     mean latency was 1.3 ms
     worst latency was 1.3 ms, which is great.

    ```

??? "400kHz I²C Baud Rate Test Results"

    ```
    patch@patchbox:~ $ alsa-midi-latency-test -i pimidi0:0 -o pimidi0:0 -1
    > alsa-midi-latency-test 0.0.5
    > running on Linux release 6.6.63-v8-16k+ (version #1821 SMP PREEMPT Mon Nov 25 13:51:58 GMT 2024) on aarch64
    > clock resolution: 0.000000001 s
    
    > sampling 10000 midi latency values - please wait ...
    > press Ctrl+C to abort test
    
    sample; latency_ms; latency_ms_worst
         0;      1.430;      1.430
      9999;      1.390;      1.430
    > done.
    
    > latency distribution:
    ...
      1.4 -  1.5 ms:    10000 ##################################################
    
    > SUCCESS
    
     best latency was 1.4 ms
     mean latency was 1.4 ms
     worst latency was 1.4 ms, which is great.
    ```

??? "100kHz I²C Baud Rate Test Results"

    ```
    patch@patchbox:~ $ alsa-midi-latency-test -i pimidi0:0 -o pimidi0:0 -1
    > alsa-midi-latency-test 0.0.5
    > running on Linux release 6.6.63-v8-16k+ (version #1821 SMP PREEMPT Mon Nov 25 13:51:58 GMT 2024) on aarch64
    > clock resolution: 0.000000001 s
    
    > sampling 10000 midi latency values - please wait ...
    > press Ctrl+C to abort test
    
    sample; latency_ms; latency_ms_worst
         0;      2.332;      2.332
      9999;      2.273;      2.332
    > done.
    
    > latency distribution:
    ...
      2.2 -  2.3 ms:     3037 ######################
      2.3 -  2.4 ms:     6963 ##################################################
    
    > SUCCESS
    
     best latency was 2.2 ms
     mean latency was 2.3 ms
     worst latency was 2.3 ms, which is great.
    ```
