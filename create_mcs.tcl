set project_dir    "./prj"

write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "prj/qube_master.runs/impl_1/top.bit" } -file "top.mcs"
