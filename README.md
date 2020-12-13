# Sun Dec 13 00:11:06 PST 2020

# glasgow-simulation
Developing SPICE generators for the Glasgow FPGA board.
Current version of the stanza simulator environment is 0.3.1

## File organization
generator.stanza contains the design generator from the glasgow. Run this file with `jitpcb repl generator.stanza`

### imported-glasgow 

Contains code generated from importing the glasgow. 
The imported files need some cleanup to be useful, and match the coding conventions for ocdb.

### model_lib
Contains the model library used in the simulation

### model_lib/bom_analysis
Extracted BOM data from the KiCad design

### model_lib/datasheets
PDF datasheets for parts in the design

### model_lib/part_db.sqlite3
Database containing research done for original bom analysis and gathering datasheets

### model_lib/models
Directory of model development, with one subdirectory for each part.
Each part subdirectory has files for the tools ltspice, ngspice, stanza. There is also a
documentation directory.

### model_lib/models/LM3880
Example directory for this documentation, using part LM3880

### model_lib/models/LM3880/ltspice/
LTspice simulation used for developing the LM3880 model.

### model_lib/models/LM3880/ltspice/LM3880.asc	
Native format for LTspice simulation schematic

### model_lib/models/LM3880/ltspice/LM3880.cir	
Exported spice netlist format from LTspice. 
This is the input to the program ltspice_to_subckt.py from LTSpiceNetlist.

### model_lib/models/LM3880/ltspice/LM3880.png
Screen capture of LTspice simulation schematic and graph of simulation results.

<a href="model_lib/models/LM3880/stanza/LM3880.cir">NGSpice spice model<a/> and test circuit. 
This is translated from the LTspice version using the program ltspice_to_subckt.py from LTSpiceNetlist.

### model_lib/models/LM3880/stanza
<a href="model_lib/models/LM3880/stanza/LM3880.tmpl">Stanza spice model section<a/> translated from the LTspice version using the program LTSpiceNetlist
<a href="model_lib/models/LM3880/stanza/LM3880.stanza">Stanza model<a/> for LM3880.

### model_lib/models/LM3880/doc
<a href="model_lib/models/LM3880/doc/README.md">Documentation</a> to help understand the LM3880 models.

