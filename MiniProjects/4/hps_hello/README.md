# AutoDeploy

## Usage
The tool uses a Makefile to deploy and run the firmware.

To compile, copy to the FPGA and run, use
```sh
$ make run IP=<ip_attributed_to_fpga>
```
You can then exit (Ctrl-C) and the process will continue to run in the SoC.

To kill the process, use:
```sh
$ make kill IP=<ip_attributed_to_fpga>
```
