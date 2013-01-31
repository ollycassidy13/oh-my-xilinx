#!/bin/zsh

#$1 is the name of the netlist
#$2 is name of clock signal

cp ~/bin/power.xpa $1.xpa
sed -i "s/\$1/$1/g" $1.xpa
sed -i "s/\$2/$2/g" $1.xpa

xpwr -v -x $1.xpa $1.ncd &> /tmp/$1.pwr

Logic=`cat /tmp/$1.pwr | grep "^| Logic"   | cut -d "|" -f 3 | sed "s/\ //g"`
Signals=`cat /tmp/$1.pwr | grep "^| Signals" | cut -d "|" -f 3 | sed "s/\ //g"`
Clocks=`cat /tmp/$1.pwr | grep "^| Clocks"  | cut -d "|" -f 3 | sed "s/\ //g"`
DSPs=`cat /tmp/$1.pwr | grep "^| DSPs"    | cut -d "|" -f 3 | sed "s/\ //g"`
Total=`cat /tmp/$1.pwr | grep "^| Total" | head -n 1 | cut -d "|" -f 3 | sed "s/\ //g"`

echo ${Logic:=0} ${Signals:=0} ${Clocks:=0} ${DSPs:=0}
power=`perl -e "print $Logic+$Signals+$Clocks+$DSPs;"`;
echo $1 ${power}mW ${Total}mW

