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
rm -rf ../$1.prj
touch ../$1.prj
for i in ../*.v
do
	echo "verilog work $i" >> ../$1.prj
done
#for i in ../*.vhd
#do
#	echo "vhdl work $i" >> ../$1.prj
#done
#for i in ../*.vhdl
#do
#	echo "vhdl work $i" >> ../$1.prj
#done

# eval synth script (really stupid and needles...)
cp -f ~/.oh-my-xilinx/xilinxcompile.scr ../$1.scr
sed -i "s/\$1/$1/g"  ../$1.scr
cp -f ~/.oh-my-xilinx/xilinxcompile.xcf ../$1.xcf
sed -i "s/\$2/$2/g"  ../$1.xcf

# copy any Coregen cores
cp ../*.ngc .

# compile and map through the steps of xilinx flow..
xst -ifn ../$1.scr 
touch ../$1.ucf
ngdbuild -verbose $1.ngc -uc ../$1.ucf
map -w -u -timing -ol high -pr b -o mapped.ncd $1.ngd mapped.pcf
par -ol std -w mapped.ncd $1.ncd mapped.pcf
cp mapped.pcf $1.pcf
trce -u -v 100 $1.ncd

cd ..
