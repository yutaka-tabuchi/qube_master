set project_dir    "./prj"

write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "bin/top.bit" } -file "bin/top.mcs"
write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "bin/0e1c42.bit" } -file "bin/0e1c42.mcs"
write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "bin/0e1cb8.bit" } -file "bin/0e1cb8.mcs"
write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "bin/0e1cc0.bit" } -file "bin/0e1cc0.mcs"
write_cfgmem -force -format mcs -size 128 -interface SPIx4 -loadbit {up 0x01002000 "bin/0d50a4.bit" } -file "bin/0d50a4.mcs"
