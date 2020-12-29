## ICE40HXBK-BG121 model

This model has
  - Static power supply dissipation
  - One IO test pin with a pullup resistor and output capacitance
  - Clamp diodes still need to be added to the IO pin model.

The pin list is from an Excel spreadsheet from the Lattice web site.

I tried to make a subcircuit for an IO pin but failed to get it working.
This should be possible, based on the example model
jitpcb/open-components-database/designs/class-a.stanza

The power-up sequence is that VCC needs to be > 0.7V before the other supplies start to come up.
There is a power-on reset until these lines get to a minimum of 0.86V:
  - VCCIO_2
  - VOO_2V5
  - VCC_SER
At this point, VCC needs to be > 0.75V.

Comparators should all go to a NAND gate to run the Power On Reset (POR) signal.
After POR, the output pins can be set with their defined static logic levels.

To implement POR and bringing up the output pin drivers, 
there will need to be logic gates and comparators:
  - Start to work at 0.7V
  - Function properly at 0.75V.
  - Have a comparator with a fixed reference voltage of 0.86V

