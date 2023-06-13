open_project prj/qube_master.xpr
open_run impl_1

append ram \
    "config_memory_wrapper_i/" \
    "config_memory_i/" \
    "U0/" \
    "inst_blk_mem_gen/" \
    "gnbram.gnativebmg.native_blk_mem_gen/" \
    "valid.cstr/" \
    "ramloop[0].ram.r/" \
    "prim_noinit.ram/" \
    "DEVICE_8SERIES.NO_BMM_INFO.SP.SIMPLE_PRIM36.ram"

set loc [get_property Site [get_cells $ram]]
puts $loc

set f [open "ram.loc" w]
puts -nonewline $f $loc
close $f

close_project
quit
