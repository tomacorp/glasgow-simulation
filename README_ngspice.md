## NGSpice notes for partial simulation of glasgow
### Last update: Sat Dec 12 23:51:37 PST 2020

Run NGspice on linux machine at 192.168.2.38
The simulation is stored in /home/tomacorp/jitx/ngspice/ggsim
First export the display:
```
export DISPLAY=export DISPLAY=192.168.2.38:0.0
```
X-Windows already running with xhost perms set.

Command line looks like:
```
ngspice -a --output=ggsim.txt -b ggsim.cir
```

This was run on NGSpice on the tomacorp linux server at 192.168.2.38

The simulation there is stored in /home/tomacorp/jitx/ngspice/ggsim

First export the display:
```
export DISPLAY=192.168.2.38:0.0
```
On the local workstation, have X-Windows already running with xhost permissions set.

Run ngspice on the command line with this:
```
ngspice -a --output=ggsim.txt -b ggsim.cir
```

To see a graph, run:
ngnutmeg ggsim.raw

To show the available voltages and currents at the ngnutmeg prompt:
display

To plot something at the ngnutmeg prompt:
plot v(3)

Run it with:
```
ngspice -a -b --output=ggsim2.txt -r ggsim2.raw ggsim2.cir
```

To see a graph, run:
```
ngnutmeg ggsim.raw
```

The ASCII output file format is human readable.
The last timepoint at the end of the file is useful for stress analysis.
The power dissipation of all components can be calculated at this last timepoint.
The sum of the power in the power supplies should be equal and opposite to the power in the other components.
Any power in inductors and capacitors means that the circuit has not settled to a steady value.
This could be because the turn-on transient has not settled, or it could be that the circuit is oscillating.
