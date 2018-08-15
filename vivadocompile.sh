#!/bin/zsh

# --- Assumptions ---
#	Clock:		clock = 2ns
#	File:		*.vhd, *.vhdl, *.v all in same directory..
#	Results:	stored in ./results_$1
#	Board:		PYNQ Z-1

# test if we're passing argument to script..
if ((${+1}))
then
else
	echo "Usage: vivadocompile.sh <top-level-entity-name> <clk-name (optional)> <fpga-part (optional)>";
	echo "<top-level-entity-name> should not contain the .v or .vhd extension";
	exit;
fi

# use clk as default name for clock signal if not supplied.
echo ${2:=clk}
echo ${3:=xc7z020clg400-1}

# clean results..
rm -rf results_$1
mkdir results_$1
cd results_$1

# put all files in a prf file..
cp ../*.vhd .
cp ../*.v .
cp ../*.h .
cp ../*.xdc .

#put FPGA part to be used into the project compile tcl script
echo "set fpga_part \"$3\"" > $1.tcl
cat $OHMYXILINX/vivadocompile.tcl >> $1.tcl
touch dummy_nachiket_fooling_zsh_for_loops.h

echo "set files [list \\" > sources.tcl
for i in *.h
do
	echo "\"[file normalize \"\$origin_dir/$i\"]\"\\" >> sources.tcl
done
for i in *.v
do
	echo "\"[file normalize \"\$origin_dir/$i\"]\"\\" >> sources.tcl
done
for i in *.vhd
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

# caution: this overwrites the local $1.xdc file if that exists
cat $OHMYXILINX/vivadocompile.xdc >> $1.xdc
sed -i "s/clk/$2/g" $1.xdc

for i in *.xdc
do
	cat $i >> $1.xdc
done

# compile and map through the steps of xilinx flow..
# my Ubuntu install doesn't like this
export LC_ALL=C
vivado -mode tcl -source $1.tcl -tclargs $1

cd ..
