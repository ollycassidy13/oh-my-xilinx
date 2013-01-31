#!/bin/zsh

#$1 is the name of the netlist

pushd $1\_batch.prj/solution1/impl/vhdl

cp ./report/$1_power.rpt /tmp/$1.pwr

Logic=`cat /tmp/$1.pwr | grep "^| Logic"   | cut -d "|" -f 3 | sed "s/\ //g"`
Signals=`cat /tmp/$1.pwr | grep "^| Signals" | cut -d "|" -f 3 | sed "s/\ //g"`
Clocks=`cat /tmp/$1.pwr | grep "^| Clocks"  | cut -d "|" -f 3 | sed "s/\ //g"`
DSPs=`cat /tmp/$1.pwr | grep "^| DSPs"    | cut -d "|" -f 3 | sed "s/\ //g"`
Total=`cat /tmp/$1.pwr | grep "^| Total" | head -n 1 | cut -d "|" -f 3 | sed "s/\ //g"`

echo Assign: ${Logic:=0} ${Signals:=0} ${Clocks:=0} ${DSPs:=0} > /dev/null
power=`perl -e "print $Logic+$Signals+$Clocks+$DSPs;"`;
popd

if [[ $2 -eq 0 ]] ; then
	echo $1 ${power}mW ${Total}mW
else
	echo \'$power\', \'$Total\'
fi
