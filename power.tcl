source ./settings.tcl
source ./extraction.tcl

set targetPart ${device}${package}${speed}
set outputBaseName $top_module
set outputDir ./report 

#file mkdir $outputDir
# create project to specify part info (for IPs)
open_project project
read_checkpoint $outputDir/${outputBaseName}_routed.dcp
report_power
report_power -file $outputDir/${outputBaseName}_power.rpt
