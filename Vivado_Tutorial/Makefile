# Top-level testbench module name
TOP = tb

# Snapshot name for xsim
SNAPSHOT = tb_sim

# SystemVerilog source files
SRC = design.sv tb.sv

# Default target
all: sim

# 1️⃣ Compile SystemVerilog
compile:
	xvlog -sv $(SRC)

# 2️⃣ Elaborate design
elaborate:
	xelab $(TOP) -s $(SNAPSHOT)

# 3️⃣ Run simulation and open waveform GUI
sim: compile elaborate
	xsim $(SNAPSHOT) -gui

# 4️⃣ Run simulation without GUI (optional)
run:
	xsim $(SNAPSHOT) -runall

# 5️⃣ Clean generated files
clean:
	rm -rf xsim.dir $(SNAPSHOT).wdb xvlog.pb xelab.pb


#| **Makefile Target / Option** || **Purpose / Effect**                                                                                    |
#| ---------------------------- || ------------------------------------------------------------------------------------------------------- |
#| `make` / `make sim`          || Compile SystemVerilog files, elaborate testbench, and open waveform GUI. This is the full workflow.     |
#| `make compile`               || Only compiles the SV files (`design.sv` + `tb.sv`). No elaboration or simulation.                       |
#| `make elaborate`             || Only elaborates the design/testbench snapshot. Must compile first.                                      |
#| `make run`                   || Runs simulation to the end without opening GUI. Useful for automated scripts or CI.                     |
#| `make clean`                 || Deletes all generated simulation files to reset workspace.                                              |
