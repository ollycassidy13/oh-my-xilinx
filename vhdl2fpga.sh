#!/bin/zsh

cp $1.vhd /tmp/$1.vhd

echo "NET \"clk\" TNM_NET = \"clk\";" > /tmp/project.ucf
echo "TIMESPEC \"TS_clk\" = PERIOD \"clk\" 5 ns HIGH 50%;" >> /tmp/project.ucf

echo "vhdl work $1.vhd" > /tmp/project.prj
echo "run 
-ifn /tmp/project.prj 
-ifmt vhdl 
-bufg 0 
-p xc5vlx110t-ff1136-1 
-top $1 
-ofn $1.ngc 
-opt_mode SPEED 
-opt_level 2 
-ofmt NGC
-write_timing_constraints yes" > /tmp/project.scr

pushd /tmp
xst -ifn /tmp/project.scr 
ngdbuild -uc /tmp/project.ucf /tmp/$1.ngc 
map -w -u -timing -pr b -o $1.ncd $1.ngd $1.pcf
par -ol high -w $1.ncd $1.routed.ncd $1.pcf
trce -u -v 100 $1.routed.ncd $1.pcf

# copied from Autopilot!
echo ""
echo ""
echo "=================== FINAL REPORT ================="
echo ""
echo ""
cat ${1}_usage.xml | tr -d '\n' | perl -lane 'if(/.*AGG_SLICE.+?value=\"(\d+)\".*/) { print "slices=$1";}'
cat ${1}.routed.twr | perl -lane 'if(/.*Minimum\ period.+?Maximum\ frequency:\ ((\d+).(\d+)).*/) { print "freq=$1";}'
popd
echo ""
echo ""
echo "=================== FINAL REPORT ================="
echo ""
echo ""
