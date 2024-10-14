#!/bin/zsh

source $OHMYXILINX/vivadoprojgen.sh

# compile and map through the steps of xilinx flow..
# my Ubuntu install doesn't like this
# -nojournal -nolog extra
export LC_ALL=C
vivado -mode batch -source $1.tcl -tclargs $1

cd ..
