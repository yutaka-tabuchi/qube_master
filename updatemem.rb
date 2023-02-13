# -*- coding: utf-8 -*-

require 'fileutils'

TARGET = ARGV.map{|arg| arg.gsub(/.*\/config_/, "").gsub(/\.mem/, "")}

MMIFILE="_confrom.mmi"
BITFILE="./prj/qube_master.runs/impl_1/top.bit"
LTXFILE="./prj/qube_master.runs/impl_1/top.ltx"
SOURCES="./resources/"

# get ROM location
def get_ram_location()
  system("vivado -mode batch -source ./get_rom.tcl")
  loc = ""
  open("ram.loc"){|f|
    loc = f.read().strip().split("_")[1]
  }
  return loc
end

def gen_confrom_mmi(loc)
  str = <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<MemInfo Version="1" Minor="0">
  <Processor Endianness="Little" InstPath="dummy">
    <AddressSpace Name="config_memory" Begin="0" End="4095">
      <BusBlock>
    <BitLane MemType="RAMB32" Placement="#{loc}">
          <DataWidth MSB="31" LSB="0"/>
          <AddressRange Begin="0" End="4095"/>
          <Parity ON="false" NumBits="0"/>
    </BitLane>
      </BusBlock>
    </AddressSpace>
  </Processor>
  <Config>
    <Option Name="Part" Val="xcu200-fsgd2104-2-e"/>
  </Config>
</MemInfo>
EOS
  return str
end

loc = get_ram_location()

open(MMIFILE, "w"){|f|
  str = gen_confrom_mmi(loc)
  f.puts(str)
}

TARGET.each{|mac|
  mac = mac.downcase
  config_file = "#{SOURCES}/config_#{mac}.mem"
  if not File.exists?(config_file)
    puts("#{config_file} is not acceptable")
    next
  end
  puts("TARGET=#{mac}")
  puts("MEMFILE=#{config_file}")
  puts("MMI=#{MMIFILE}")
  puts("BITFILE=#{BITFILE}")
  system("updatemem -force -meminfo #{MMIFILE} -data #{config_file} -bit #{BITFILE} -proc dummy -out bin/#{mac}.bit")
}

FileUtils.copy(LTXFILE, './bin')

# record updated timestamp
open("./bin/UPDATE", "w"){|f| f.puts(Time.now.to_s) }
