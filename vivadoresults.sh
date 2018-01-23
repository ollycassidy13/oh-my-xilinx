#!/bin/zsh

# --- Assumptions ---
#	Clock:		clock@3ns 
#	File:		*.vhd, *.vhdl, *.v all in same directory..
#	Results:	stored in ./results_$1
#	Board:		VC707 - Virtex-7 VX485T FPGA

# test if we're passing argument to script..
if ((${+1}))
then
else
	echo "Usage: vivadoresults.sh <top-level-entity-name>";
	exit;
fi

cat results_$1/vivado.log | grep LUTs
cat results_$1/vivado.log | grep "Slice Registers"
cat results_$1/vivado.log | grep DSPs 
cat results_$1/vivado.log | grep "Block RAM Tile" -m 1
cat results_$1/vivado.log | grep "Slack (MET)"
cat results_$1/vivado.log | grep "Slack (VIOLATED)"
cat results_$1/vivado.log | grep "Requirement"
cat results_$1/vivado.log | grep "Total On-Chip Power (W)"
