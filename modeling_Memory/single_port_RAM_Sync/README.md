# single_port_RAM_Sync

This directory contains a simple Verilog model of a synchronous single-port RAM.

## Files

- `design.v` – Verilog source implementing a 1024x8-bit RAM with independent read/write control signals and a bidirectional data bus.

The module uses a clocked process for read and write operations, with chip‑select, read, and write inputs.  The Verilog is written for simulation and synthesis, and demonstrates basic memory modeling.

No testbench or additional scripts are provided; this is a minimal design example.