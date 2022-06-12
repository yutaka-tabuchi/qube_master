require './vivado_util.rb'

def main()
  dir="prj"
  name="qube_master"
  
  vivado = Vivado.new(dir: dir, name: name, top: "top")
  #vivado.add_parameters({"general.maxThreads" => 1})
  
  vivado.set_target("xcu250-figd2104-2L-e")
  vivado.set_board("xilinx.com:au200:part0:1.3")

  vivado.add_sources(["sources/top.vhd",
                      "sources/command_parser.vhd",
                      "sources/config_memory_wrapper.v",
                      "sources/simple_dualportram.vhd",
                      "time_synch/synch_sender.sv",
                      "time_synch/synch_pkg.vh",
                     ])
  vivado.add_sources(["sources/e7udpip10g_au200.vhd"])
  vivado.add_sources(["lib/e7udpip10G_independent_clk.edn"])

  vivado.add_constraints(["sources/top.xdc"])
  vivado.add_testbenchs([])
  vivado.add_ipcores(["ipcores/clk_wiz_0.xci",
                      "ipcores/config_memory.xci",
                      "ipcores/ila_config_memory.xci",
                      "ipcores/ila_0.xci",
                      "ipcores/ila_1.xci",
                      "ipcores/ila_2.xci",
                      "ipcores/xxv_ethernet_0.xci"])
  
  #vivado.add_verilog_define({"BOARD_ID" => board_id})
  
  vivado.generate_tcl("create_prj.tcl")
  #vivado.run()
  
  #config = Vivado.new(dir=dir, name=name, top="top", kind=Vivado.CONFIG)
  #config.set_chip("xc7a35t_0")
  #config.generate_tcl("config_board_#{key}.tcl")
  #config.run()
end

main()


