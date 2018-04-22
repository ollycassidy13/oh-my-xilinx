#!/bin/zsh

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

cp ../$1.vhd .
cp ../$1.v .

cp $OHMYXILINX/testing.tcl $1.tcl

if [[ -f $1.vhd  ]]; then
	sed -i "s/\$1/$1.vhd/g"  $1.tcl
fi

if [[ -f $1.v  ]]; then
	sed -i "s/\$1/$1.v/g"  $1.tcl
fi

sed -i "s/\$2/$1/g"  $1.tcl
touch sources.tcl

cp -f $OHMYXILINX/xilinxsolocompile.ucf constraint.ucf
sed -i "s/\$1/$1/g" constraint.ucf

# copy any Coregen cores
cp ../*.ngc .

# compile and map through the steps of xilinx flow..
xtclsh $1.tcl rebuild_project

cd ..
