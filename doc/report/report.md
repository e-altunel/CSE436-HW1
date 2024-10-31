# CSE436 Assignment 1 Report

> Name: Emirhan Altunel
> Student ID: 200104004035

## How you designed the layouts?

### Not

Rules for the `not` gate are as follows:

- | input | output | pdiff | ndiff |
  | ----- | ------ | ----- | ----- |
  | 0     | 1      | +     | -     |
  | 1     | 0      | -     | +     |

- When the input is `0`, ndiff does not conduct but pdiff conducts. So, the output only connects to the vdd.
- When the input is `1`, ndiff conducts but pdiff does not conduct. So, the output only connects to the gnd.
- Pdiff width is 2 times the ndiff width.
- Top metal connects to the vdd and bottom metal connects to the gnd.
- Poly connects to the input.
- Left center metal connects to the output.

<img src="./assets/not_mag.png" style="width: 25%">

<div style="page-break-after: always;"></div>

### Nand

Rules for the `nand` gate are as follows:

- | input1 | input2 | output | pdiff | ndiff |
  | ------ | ------ | ------ | ----- | ----- |
  | 0      | 0      | 1      | +     | -     |
  | 1      | 0      | 1      | +     | -     |
  | 0      | 1      | 1      | +     | -     |
  | 1      | 1      | 0      | -     | +     |

- When the both inputs are `0`, pdiff condancts but ndiff does not conduct. So, the output only connects to the vdd.
- When the first input is `1` and the second input is `0`, pdiff condancts because of parallel connection but ndiff does not conduct due to series connection. So, the output only connects to the vdd.
- Same for the second input is `1` and the first input is `0`.
- When both inputs are `1`, ndiff conducts but pdiff does not conduct. So, the output only connects to the gnd.
- Pdiff width is 2 times the ndiff width.
- Top metal connects to the vdd and bottom metal connects to the gnd.
- Poly1 connects to the input1.
- Poly2 connects to the input2.
- Left center metal connects to the output.

<img src="./assets/nand_mag.png" style="width: 25%">

<div style="page-break-after: always;"></div>

### Nor

Rules for the `nor` gate are as follows:

- | input1 | input2 | output | pdiff | ndiff |
  | ------ | ------ | ------ | ----- | ----- |
  | 0      | 0      | 1      | +     | -     |
  | 1      | 0      | 0      | -     | +     |
  | 0      | 1      | 0      | -     | +     |
  | 1      | 1      | 0      | -     | +     |

- When the both inputs are `0`, pdiff condancts but ndiff does not conduct. So, the output only connects to the vdd.
- When the first input is `1` and the second input is `0`, ndiff condancts because of parallel connection but pdiff does not conduct due to series connection. So, the output only connects to the vdd.
- Same for the second input is `1` and the first input is `0`.
- When both inputs are `1`, ndiff conducts but pdiff does not conduct. So, the output only connects to the gnd.
- Pdiff width is 2 times the ndiff width.
- Top metal connects to the vdd and bottom metal connects to the gnd.
- Poly1 connects to the input1.
- Poly2 connects to the input2.
- Left center metal connects to the output.

<img src="./assets/nor_mag.png" style="width: 25%">

<div style="page-break-after: always;"></div>

## How you extracted the netlist and set up the simulation?

When i finished my design, i use these command in magic layout tool to extract:

```bash
extract all
ext2spice nand
```

Then, i add these lines to the extracted spice file:

```spice
* Include the technology file
.include /output/tsmc_cmos025

* Set the voltage difference between vdd and gnd
V0 vdd gnd 2.5V


* Set the input1 as a pulse signal with
* 0-2.5V 40ns period 20ns positive 20ns negative
V1 a gnd PULSE(0 2.5 0ns 0ns 0ns 20ns 40ns)


* Set the input2 as a pulse signal with
* 0-2.5V 80ns period 40ns positive 40ns negative
V2 b gnd PULSE(0 2.5 0ns 0ns 0ns 40ns 80ns)

* Add capacitors to the output
CL y 0 1fF

* Set the simulation length as 100ns
.TRAN 1ns 100ns

* Add models otherwise it doesnt work
.model nfet NMOS
.model pfet PMOS

* Export the data to file, i use python to plot the data
* But ngspice can plot the data too
* .plot v(a) v(b) v(y)
.control
run
wrdata output_file.dat v(a) v(b) v(y)
.endc
```

<div style="page-break-after: always;"></div>

## Your interpretation of the simulation results.

I exported the data to a file, after that i used python to see plots. Also we can determine the delays by using raw data.
Example:
Delay is too low to see

| Time           | Input | Output |                    |
| -------------- | ----- | ------ | ------------------ |
| 0              | 0     | 2.5    | <- Initial state   |
| 1.e-11         | 0     | 2.5    |                    |
| 2.e-11         | 0     | 2.5    |                    |
| 4.e-11         | 0.1   | 2.5    | <- Input increased |
| 8.e-11         | 0.2   | 2.5    |                    |
| 1.6e-10        | 0.4   | 2.48   | <- Output changed  |
| 3.2e-10        | 0.8   | 2.40   |                    |
| 6.4e-10        | 1.6   | 0.8    |                    |
| 1.e-09         | 2.5   | 0      |                    |
| 1.04361511e-09 | 2.5   | 0      |                    |
| 1.13084532e-09 | 2.5   | 0      |                    |
| 1.30530574e-09 | 2.5   | 0      |                    |

## Plots

<img src="./assets/not.png" style="width: 30%">

<img src="./assets/nand.png" style="width: 30%">

<img src="./assets/nor.png" style="width: 30%">
