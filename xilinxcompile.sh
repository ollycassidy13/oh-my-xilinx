#!/bin/zsh

# --- Assumptions ---
#	Clock:		clock@3ns 
#	File:		*.vhd, *.vhdl, *.v all in same directory..
#	Results:	stored in ./results_$1
#	Board:		ML605 - Virtex-6 LX240T FPGA

# test if we're passing argument to script..
if ((${+1}))
then
else
	echo "Usage: xilinxcompile.sh <top-level-entity-name> <clk-name>";
	exit;
fi

export PATH=$PATH:/opt/Xilinx/14.7/ISE_DS/ISE/bin/lin64

echo ${2:=clk}

# clean results..
rm -rf results_$1
mkdir results_$1
cd results_$1

# put all files in a prf file..
cp ../*.vhd .
cp ../*.v .
cp ../*.h .

cp ~/bin/xilinxcompile.tcl $1.tcl

for i in *.v
do
	echo "xfile add \"$i\"" >> sources.tcl
done

sed -i "s/\$2/$1/g"  $1.tcl

cp -f ~/bin/xilinxsolocompile.ucf constraint.ucf
sed -i "s/\$1/$1/g" constraint.ucf

# copy any Coregen cores
cp ../*.ngc .


# compile and map through the steps of xilinx flow..
xtclsh $1.tcl rebuild_project

cd ..
