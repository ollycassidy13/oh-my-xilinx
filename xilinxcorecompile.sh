#!/bin/zsh

# --- Assumptions ---
#	Clock:		clock@3ns 
#	File:		*.ngc all in same directory..
#	Results:	stored in ./results
#	Board:		ML605 - Virtex-6 LX240T FPGA

# test if we're passing argument to script..
if ((${+1}))
then
else
	echo "Usage: xilinxcorecompile.sh <top-level-entity-name> <clk-name>";
	exit;
fi

${2:=clk}

# clean results..
rm -rf results
mkdir results
cd results

rm -f $1.scr
cp -f ~/bin/xilinxcompile.xcf ../$1.xcf
sed -i "s/\$2/$2/g"  ../$1.xcf

# copy any Coregen cores
cp ../*.ngc .

# compile and map through the steps of xilinx flow..
ngdbuild -verbose $1.ngc #-uc ../$1.ucf
map -u -timing -ol high -pr b -o mapped.ncd $1.ngd mapped.pcf
par -ol high -w mapped.ncd $1.ncd mapped.pcf
trce -u -v 100 $1.ncd

cd ..
