# coding: utf-8

def gen_config(macaddr0, ipaddr0, macaddr1, ipaddr1, target_addr1="0100000a")

  str = "@00000000\n"

  macaddr0.gsub!("-", ":")
  mac0 = macaddr0.split(":").map{|a| format("%02x", a.to_i(16))}.reverse
  mac0_str = mac0.join("")

  addrs0 = ipaddr0.split(".").map{|a| format("%02x", a.to_i)}.reverse
  addr0_str = addrs0.join("")
  
  macaddr1.gsub!("-", ":")
  mac1 = macaddr1.split(":").map{|a| format("%02x", a.to_i(16))}.reverse
  mac1_str = mac1.join("")

  addrs1 = ipaddr1.split(".").map{|a| format("%02x", a.to_i)}.reverse
  addr1_str = addrs1.join("")
  
  str += addr0_str + "\n"
  str += "000000ff" + "\n" # Netmask
  str += "0100000a" + "\n" # default gateway
  str += "0100000a" + "\n" # target server
  str += mac0_str[4..-1] + "\n"
  str += "0000" + mac0_str[0..3] + "\n"
  str += addr1_str  + "\n"
  str += "000000ff" + "\n" # Netmask
  str += "0100000a" + "\n" # default gateway
  str += target_addr1 + "\n" # target server
  str += mac1_str[4..-1] + "\n"
  str += "0000" + mac1_str[0..3] + "\n"
  str += "00000000" + "\n"
  str += "00000000" + "\n"
  str += "00000000" + "\n"
  str += "00000000" + "\n"
  return str
end

def gen_filename(macaddr)
  macaddr.gsub!("-", ":")
  mac = macaddr.split(":").map{|a| format("%02x", a.to_i(16))}
  return "config_#{mac[3..5].join("")}.mem" # 下位24bit
end

def write_file(filename, str)
  open(filename, "w"){|f|
    f.puts(str)
  }
end

$stdin.read.split("\n").each{|l|
  d = l.strip.split(/\s+/)
  p d
  ret = gen_config(d[0], d[1], d[2], d[3])
  filename = gen_filename(d[0])
  p filename
  puts ret
  write_file(filename, ret)
}
