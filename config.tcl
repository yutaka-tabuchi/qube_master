open_hw_manager
connect_hw_server -allow_non_jtag

set adapter ""
append adapter "*/" $::env(ADAPTER)
set target [get_hw_targets -quiet $adapter]; # 以降 $target で参照できる
if {[string equal $target ""]} {
  disconnect_hw_server
  close_hw_manager
  quit
}
open_hw_target $target; # これでターゲットに接続
set dev [current_hw_device [get_hw_devices -quiet {*200*}]]; # 念の為にAlveo U200を選別できるように
                                                          ; # 以降 $dev で参照できる
if {[string equal $dev ""]} {
  close_hw_target $target
  disconnect_hw_server
  close_hw_manager
  quit
}
refresh_hw_device -update_hw_probes false [lindex $dev 0]
set_property PROGRAM.FILE $::env(BITFILE) $dev
program_hw_device $dev
disconnect_hw_server localhost:3121
close_hw_manager
