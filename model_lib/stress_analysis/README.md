# Stress analysis from an NGSpice dataset

The NGSpice simulator saves its data in a raw file format.

The convention for the simulation is that all parts have a subcircuit.
Most stress analysis equations can be contructed from the netlist
of the simulation and the contents of the raw file.
By default, NGSpice does not store enough information to calculate
the component stress. The commands to save the required voltages
and currents have changed in recent versions of NGSpice. These
instructions are for NGSpice version 33.

To store the required voltages and currents, add these lines:
```
.options savecurrents filetype=ascii
.save all
```

## Example 1: Resistor and Voltage source

This example has one resistor and one voltage source.
The resistor value is 1k and the voltage is 5V.
The power should be P = V^2/R = 25 mW
The voltage stress is 5 V.
```
.title Resistor test circuit
*
* Voltage source on connector J1
.subckt J1 1 2
V1 1 2 EXP(0 5 10u 10u 20 20)
.ends
* Resistor, 1K component R1
.subckt R1K 1 2
R1 1 2 1k
.ends
XJ1 VIN 0 J1
XR1 VIN 0 R1K
*
.options savecurrents filetype=ascii
.tran 1u 100u 0 10u
*
.end
```

Run the netlist with:
```
ngspice -a -b -o res1.txt -r res1.raw res1.cir
```

This creates a file res1.raw.
In this file, the available variables are:

```
Variables:
	0	time	time
	1	v(vin)	voltage
	2	i(v.xj1.v1)	current
	3	i(@r.xr1.r1[i])	current
```

NGSpice reports the currents for two-pin devices as being positive when the current
is flowing into the first pin in the netlist.

The current i(@r.xr1.r1[i]) should be positive, as the positive
voltage causes a current to flow into the first pin of R1 in subcircuit R1K,
which is instantiated as the subcircuit call XR1.

The current i(v.xj1.v1) should be negative, because it flows out of the first
pin of V1 in subcircuit XJ1, which is instantiated as the subcircuit call XJ1.

The current flowing into the second pin of a two-pin device is the negative
of the current flowing into the first pin.

The final timepoint in the ASCII raw file is:
20		9.999999999999999e-05
	4.999382950979567e+00
	-4.999382950979567e-03
	4.999382950979567e-03

The first number is the value of time at the last time point.
Notice that because of rounding error, it is not at the requested 100e-6 seconds.

The next number is the input voltage. It is not quite 5 because the voltage
source is an exponential ramp that is still settling within the last millivolt.
Next is the 5 V voltage source, which has a negative current as expected.
The resistor has a positive current, also as expected.

The simulation conserves energy, so the sum of the power dissipations of all the
components is zero. This is true at every time point in the simulation, but for
purposes here, look at the last time point. To see the last time point in ngnutmeg,
an index can be defined with:
```
npt = length (time)-1
```

The power dissipation in a component is the sum of voltage times current at all
of its pins. Since the components are connected to ground, the second term is
zero, but it is shown here:

```
pxj1_ss = ( vin[npt] * i(v.xj1.v1)[npt] - 0 * i(v.xj1.v1)[npt] )
pxr1_ss = ( vin[npt] * i(@r.xr1.r1[i])[npt] - 0 * i(@r.xr1.r1[i])[npt] )
ptotal_ss = pxj1_ss + pxr1_ss
print pxj1_ss pxr1_ss ptotal_ss
```

Result:
```
pxj1_ss = -2.49938e-02
pxr1_ss = 2.499383e-02
ptotal_ss = 0.000000e+00
```

In general, the loads have positive power dissipation and the voltage sources
have negative power dissipation.

As far as I can tell, ngnutmeg does not use memoization or other speedups in these
calculations. Evaluation is done with macro substitution, and expressions like this
are not efficient. When the circuit size is large, the compute time for this type
of stress calculation can exceed the simulation time. It is worthwhile to look at
other environments for post processing. The ngspice output data is available as either
a simple ASCII format or a binary format with an ASCII header.


