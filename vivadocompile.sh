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
	echo "Usage: vivadocompile.sh <top-level-entity-name> <clk-name>";
	exit;
fi

export PATH=$PATH:/opt/Xilinx/Vivado/2015.4/bin

echo ${2:=clk}

# clean results..
rm -rf results_$1
mkdir results_$1
cd results_$1

# put all files in a prf file..
cp ../*.vhd .
cp ../*.v .
cp ../*.h .
cp ../*.xdc .

cp ~/.oh-my-xilinx/vivadocompile.tcl $1.tcl

echo "set files [list \\" > sources.tcl
for i in *.v
do
	echo "\"[file normalize \"\$origin_dir/$i\"]\"\\" >> sources.tcl
done
for i in *.h
do
	echo "\"[file normalize \"\$origin_dir/$i\"]\"\\" >> sources.tcl
done
echo "]" >> sources.tcl
echo "add_files -norecurse -fileset \$obj \$files" >> sources.tcl

for i in *.h
do
	echo "set file \"\$origin_dir/$i\"" >> headers.tcl
	echo "set file [file normalize \$file]" >> headers.tcl
	echo "set file_obj [get_files -of_objects [get_filesets sources_1] [list \"*\$file\"]]" >> headers.tcl
	echo "set_property \"file_type\" \"Verilog Header\" \$file_obj" >> headers.tcl

done

cp -f ~/.oh-my-xilinx/vivadocompile.xdc $1.xdc
sed -i "s/clk/$2/g" $1.xdc

for i in *.xdc
do
	echo "source $i" >> $1.xdc
done

# compile and map through the steps of xilinx flow..
# my Ubuntu install doesn't like this
export LC_ALL=C
vivado -mode tcl -source $1.tcl -tclargs $1

cd ..
