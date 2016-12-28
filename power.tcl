if { $::argc > 0 } {
	for {set i 0} {$i < [llength $::argc]} {incr i} {
		set option [string trim [lindex $::argv $i]]
	}
}

# create project to specify part info (for IPs)
open_project vivadocompile/vivadocompile.xpr
read_checkpoint vivadocompile/vivadocompile.runs/impl_1/${argv}_routed.dcp
open_run impl_1
set_switching_activity -static_probability 0.5 -toggle_rate 1 -type bram -all
report_power
set_switching_activity -static_probability 0.5 -toggle_rate 10 -type bram -all
report_power
set_switching_activity -static_probability 0.5 -toggle_rate 20 -type bram -all
report_power
set_switching_activity -static_probability 0.5 -toggle_rate 50 -type bram -all
report_power
set_switching_activity -static_probability 0.5 -toggle_rate 100 -type bram -all
report_power
