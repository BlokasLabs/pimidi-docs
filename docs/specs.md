# Detailed Specs

## General Info

| Parameter               | Value                              |
| ----------------------- | ---------------------------------- |
| MIDI Inputs             | 2                                  |
| MIDI Outputs            | 2                                  |
| Input/Output Connectors | 4x 3.5mm stereo jack (MIDI Type A) |
| MIDI Loopback Latency   | 1.3ms                              |
| Minimum I²C Baud Rate   | 100kHz                             |
| Maximum I²C Baud Rate   | 3.0MHz                             |
| Activity LEDs           | 4                                  |
| Current Draw            | 50mA @ 5.1VDC                      |
| Dimensions              | 58mm x 65mm x 18.5mm               |
| Weight                  | 50g                                |

## GPIO Pins Used

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

## Latency

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