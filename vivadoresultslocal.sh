#!/bin/zsh

# --- Assumptions ---
#	Clock:		clock@3ns 
#	Results:	stored in ./
#	Board:		VC707 - Virtex-7 VX485T FPGA

cat vivado.log | grep LUTs | grep -v SLR
cat vivado.log | grep "Slice Registers"
cat vivado.log | grep DSPs | grep -v SLR 
cat vivado.log | grep "Slack (MET)"
cat vivado.log | grep "Slack (VIOLATED)"
cat vivado.log | grep "Requirement"
cat vivado.log | grep "Total On-Chip Power (W)"
