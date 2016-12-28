#!/bin/zsh

cp ~/bin/power.tcl .
vivado -mode batch -source power.tcl -tclargs $1

