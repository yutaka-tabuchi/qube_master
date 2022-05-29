library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port(
    gt_rxp_in : in std_logic_vector(4-1 downto 0);
    gt_rxn_in : in std_logic_vector(4-1 downto 0);
    gt_txp_out : out std_logic_vector(4-1 downto 0);
    gt_txn_out : out std_logic_vector(4-1 downto 0);

    QSFP28_0_ACTIVITY_LED : out std_logic;
    QSFP28_0_STATUS_LEDG  : out std_logic;
    QSFP28_0_STATUS_LEDY  : out std_logic;
    
    gt_refclk_p : in std_logic;
    gt_refclk_n : in std_logic;

    SYSCLK3_N : in std_logic;
    SYSCLK3_P : in std_logic
    );
end entity top;

architecture RTL of top is

  attribute keep : string;
  attribute mark_debug : string;
  
  component clk_wiz_0
    port (
      clk_out1  : out std_logic;
      clk_out2  : out std_logic;
      reset     : in  std_logic;
      locked    : out std_logic;
      clk_in1_p : in  std_logic;
      clk_in1_n : in  std_logic
      );
  end component clk_wiz_0;

  component ila_1
    port (
      clk : in std_logic;
      probe0 : in std_logic_vector(130 downto 0);
      probe1 : in std_logic_vector(130 downto 0);
      probe2 : in std_logic_vector(130 downto 0);
      probe3 : in std_logic_vector(130 downto 0);
      probe4 : in std_logic_vector(130 downto 0);
      probe5 : in std_logic_vector(130 downto 0);
      probe6 : in std_logic_vector(130 downto 0);
      probe7 : in std_logic_vector(130 downto 0)
      );
  end component ila_1;
  
  signal pUdp0Send_Data_0    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_0 : std_logic;
  signal pUdp0Send_Ack_0     : std_logic;
  signal pUdp0Send_Enable_0  : std_logic;
  signal pUdp1Send_Data_0    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_0 : std_logic;
  signal pUdp1Send_Ack_0     : std_logic;
  signal pUdp1Send_Enable_0  : std_logic;
  
  signal pUdp0Receive_Data_0    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_0 : std_logic;
  signal pUdp0Receive_Ack_0     : std_logic;
  signal pUdp0Receive_Enable_0  : std_logic;
  signal pUdp1Receive_Data_0    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_0 : std_logic;
  signal pUdp1Receive_Ack_0     : std_logic;
  signal pUdp1Receive_Enable_0  : std_logic;

  attribute keep of pUdp0Send_Data_0    : signal is "true";
  attribute keep of pUdp0Send_Request_0 : signal is "true";
  attribute keep of pUdp0Send_Ack_0     : signal is "true";
  attribute keep of pUdp0Send_Enable_0  : signal is "true";
  attribute keep of pUdp1Send_Data_0    : signal is "true";
  attribute keep of pUdp1Send_Request_0 : signal is "true";
  attribute keep of pUdp1Send_Ack_0     : signal is "true";
  attribute keep of pUdp1Send_Enable_0  : signal is "true";
  
  signal pUdp0Send_Data_1    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_1 : std_logic;
  signal pUdp0Send_Ack_1     : std_logic;
  signal pUdp0Send_Enable_1  : std_logic;
  signal pUdp1Send_Data_1    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_1 : std_logic;
  signal pUdp1Send_Ack_1     : std_logic;
  signal pUdp1Send_Enable_1  : std_logic;
  
  signal pUdp0Receive_Data_1    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_1 : std_logic;
  signal pUdp0Receive_Ack_1     : std_logic;
  signal pUdp0Receive_Enable_1  : std_logic;
  signal pUdp1Receive_Data_1    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_1 : std_logic;
  signal pUdp1Receive_Ack_1     : std_logic;
  signal pUdp1Receive_Enable_1  : std_logic;

  attribute keep of pUdp0Send_Data_1    : signal is "true";
  attribute keep of pUdp0Send_Request_1 : signal is "true";
  attribute keep of pUdp0Send_Ack_1     : signal is "true";
  attribute keep of pUdp0Send_Enable_1  : signal is "true";
  attribute keep of pUdp1Send_Data_1    : signal is "true";
  attribute keep of pUdp1Send_Request_1 : signal is "true";
  attribute keep of pUdp1Send_Ack_1     : signal is "true";
  attribute keep of pUdp1Send_Enable_1  : signal is "true";

  signal pUdp0Send_Data_2    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_2 : std_logic;
  signal pUdp0Send_Ack_2     : std_logic;
  signal pUdp0Send_Enable_2  : std_logic;
  signal pUdp1Send_Data_2    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_2 : std_logic;
  signal pUdp1Send_Ack_2     : std_logic;
  signal pUdp1Send_Enable_2  : std_logic;
  
  signal pUdp0Receive_Data_2    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_2 : std_logic;
  signal pUdp0Receive_Ack_2     : std_logic;
  signal pUdp0Receive_Enable_2  : std_logic;
  signal pUdp1Receive_Data_2    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_2 : std_logic;
  signal pUdp1Receive_Ack_2     : std_logic;
  signal pUdp1Receive_Enable_2  : std_logic;

  attribute keep of pUdp0Send_Data_2    : signal is "true";
  attribute keep of pUdp0Send_Request_2 : signal is "true";
  attribute keep of pUdp0Send_Ack_2     : signal is "true";
  attribute keep of pUdp0Send_Enable_2  : signal is "true";
  attribute keep of pUdp1Send_Data_2    : signal is "true";
  attribute keep of pUdp1Send_Request_2 : signal is "true";
  attribute keep of pUdp1Send_Ack_2     : signal is "true";
  attribute keep of pUdp1Send_Enable_2  : signal is "true";

  signal pUdp0Send_Data_3    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_3 : std_logic;
  signal pUdp0Send_Ack_3     : std_logic;
  signal pUdp0Send_Enable_3  : std_logic;
  signal pUdp1Send_Data_3    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_3 : std_logic;
  signal pUdp1Send_Ack_3     : std_logic;
  signal pUdp1Send_Enable_3  : std_logic;
  
  signal pUdp0Receive_Data_3    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_3 : std_logic;
  signal pUdp0Receive_Ack_3     : std_logic;
  signal pUdp0Receive_Enable_3  : std_logic;
  signal pUdp1Receive_Data_3    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_3 : std_logic;
  signal pUdp1Receive_Ack_3     : std_logic;
  signal pUdp1Receive_Enable_3  : std_logic;

  attribute keep of pUdp0Send_Data_3    : signal is "true";
  attribute keep of pUdp0Send_Request_3 : signal is "true";
  attribute keep of pUdp0Send_Ack_3     : signal is "true";
  attribute keep of pUdp0Send_Enable_3  : signal is "true";
  attribute keep of pUdp1Send_Data_3    : signal is "true";
  attribute keep of pUdp1Send_Request_3 : signal is "true";
  attribute keep of pUdp1Send_Ack_3     : signal is "true";
  attribute keep of pUdp1Send_Enable_3  : signal is "true";

  signal MyIpAddr_0       : std_logic_vector(31 downto 0);
  signal MyMacAddr_0      : std_logic_vector(47 downto 0);
  signal MyNetMask_0      : std_logic_vector(31 downto 0);
  signal DefaultGateway_0 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_0   : std_logic_vector(31 downto 0);
  signal MyUdpPort_0_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_0_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_1       : std_logic_vector(31 downto 0);
  signal MyMacAddr_1      : std_logic_vector(47 downto 0);
  signal MyNetMask_1      : std_logic_vector(31 downto 0);
  signal DefaultGateway_1 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_1   : std_logic_vector(31 downto 0);
  signal MyUdpPort_1_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_1_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_2       : std_logic_vector(31 downto 0);
  signal MyMacAddr_2      : std_logic_vector(47 downto 0);
  signal MyNetMask_2      : std_logic_vector(31 downto 0);
  signal DefaultGateway_2 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_2   : std_logic_vector(31 downto 0);
  signal MyUdpPort_2_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_2_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_3       : std_logic_vector(31 downto 0);
  signal MyMacAddr_3      : std_logic_vector(47 downto 0);
  signal MyNetMask_3      : std_logic_vector(31 downto 0);
  signal DefaultGateway_3 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_3   : std_logic_vector(31 downto 0);
  signal MyUdpPort_3_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_3_1    : std_logic_vector(15 downto 0);

  component synch_sender
    port (
      clk   : in std_logic;
      reset : in std_logic;

      clock_in : in std_logic_vector(63 downto 0);

      UPLOut_data : out std_logic_vector(127 downto 0);
      UPLOut_en   : out std_logic;
      UPLOut_req  : out std_logic;
      UPLOut_ack  : in  std_logic;

      UPLIn_data : in  std_logic_vector(127 downto 0);
      UPLIn_en   : in  std_logic;
      UPLIn_req  : in  std_logic;
      UPLIn_ack  : out std_logic;

      kick : in std_logic;
      busy : out std_logic;

      src_addr : in std_logic_vector(31 downto 0);
      dst_addr : in std_logic_vector(31 downto 0);
      src_port : in std_logic_vector(15 downto 0);
      dst_port : in std_logic_vector(15 downto 0)
      );
  end component synch_sender;

  component e7udpip10g_au200
    port(
      gt_rxp_in : in std_logic_vector(4-1 downto 0);
      gt_rxn_in : in std_logic_vector(4-1 downto 0);
      gt_txp_out : out std_logic_vector(4-1 downto 0);
      gt_txn_out : out std_logic_vector(4-1 downto 0);

      gt_refclk_p : in std_logic;
      gt_refclk_n : in std_logic;

      clk250mhz : in std_logic;
      clk100mhz : in std_logic;
      clk_locked : in std_logic;
      
      rx_block_lock_led_0 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_1 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_2 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_3 : out std_logic;  -- Indicates Core Block Lock

      MyIpAddr_0       : in std_logic_vector(31 downto 0);
      MyMacAddr_0      : in std_logic_vector(47 downto 0);
      MyNetMask_0      : in std_logic_vector(31 downto 0);
      DefaultGateway_0 : in std_logic_vector(31 downto 0);
      TargetIPAddr_0   : in std_logic_vector(31 downto 0);
      MyUdpPort_0_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_0_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_0       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_0    : in  std_logic;
      pUdp0Send_Ack_0        : out std_logic;
      pUdp0Send_Enable_0     : in  std_logic;
      pUdp1Send_Data_0       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_0    : in  std_logic;
      pUdp1Send_Ack_0        : out std_logic;
      pUdp1Send_Enable_0     : in  std_logic;
      pUdp0Receive_Data_0    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_0 : out std_logic;
      pUdp0Receive_Ack_0     : in  std_logic;
      pUdp0Receive_Enable_0  : out std_logic;
      pUdp1Receive_Data_0    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_0 : out std_logic;
      pUdp1Receive_Ack_0     : in  std_logic;
      pUdp1Receive_Enable_0  : out std_logic;

      MyIpAddr_1       : in std_logic_vector(31 downto 0);
      MyMacAddr_1      : in std_logic_vector(47 downto 0);
      MyNetMask_1      : in std_logic_vector(31 downto 0);
      DefaultGateway_1 : in std_logic_vector(31 downto 0);
      TargetIPAddr_1   : in std_logic_vector(31 downto 0);
      MyUdpPort_1_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_1_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_1       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_1    : in  std_logic;
      pUdp0Send_Ack_1        : out std_logic;
      pUdp0Send_Enable_1     : in  std_logic;
      pUdp1Send_Data_1       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_1    : in  std_logic;
      pUdp1Send_Ack_1        : out std_logic;
      pUdp1Send_Enable_1     : in  std_logic;
      pUdp0Receive_Data_1    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_1 : out std_logic;
      pUdp0Receive_Ack_1     : in  std_logic;
      pUdp0Receive_Enable_1  : out std_logic;
      pUdp1Receive_Data_1    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_1 : out std_logic;
      pUdp1Receive_Ack_1     : in  std_logic;
      pUdp1Receive_Enable_1  : out std_logic;

      MyIpAddr_2       : in std_logic_vector(31 downto 0);
      MyMacAddr_2      : in std_logic_vector(47 downto 0);
      MyNetMask_2      : in std_logic_vector(31 downto 0);
      DefaultGateway_2 : in std_logic_vector(31 downto 0);
      TargetIPAddr_2   : in std_logic_vector(31 downto 0);
      MyUdpPort_2_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_2_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_2       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_2    : in  std_logic;
      pUdp0Send_Ack_2        : out std_logic;
      pUdp0Send_Enable_2     : in  std_logic;
      pUdp1Send_Data_2       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_2    : in  std_logic;
      pUdp1Send_Ack_2        : out std_logic;
      pUdp1Send_Enable_2     : in  std_logic;
      pUdp0Receive_Data_2    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_2 : out std_logic;
      pUdp0Receive_Ack_2     : in  std_logic;
      pUdp0Receive_Enable_2  : out std_logic;
      pUdp1Receive_Data_2    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_2 : out std_logic;
      pUdp1Receive_Ack_2     : in  std_logic;
      pUdp1Receive_Enable_2  : out std_logic;

      MyIpAddr_3       : in std_logic_vector(31 downto 0);
      MyMacAddr_3      : in std_logic_vector(47 downto 0);
      MyNetMask_3      : in std_logic_vector(31 downto 0);
      DefaultGateway_3 : in std_logic_vector(31 downto 0);
      TargetIPAddr_3   : in std_logic_vector(31 downto 0);
      MyUdpPort_3_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_3_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_3       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_3    : in  std_logic;
      pUdp0Send_Ack_3        : out std_logic;
      pUdp0Send_Enable_3     : in  std_logic;
      pUdp1Send_Data_3       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_3    : in  std_logic;
      pUdp1Send_Ack_3        : out std_logic;
      pUdp1Send_Enable_3     : in  std_logic;
      pUdp0Receive_Data_3    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_3 : out std_logic;
      pUdp0Receive_Ack_3     : in  std_logic;
      pUdp0Receive_Enable_3  : out std_logic;
      pUdp1Receive_Data_3    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_3 : out std_logic;
      pUdp1Receive_Ack_3     : in  std_logic;
      pUdp1Receive_Enable_3  : out std_logic
      );
  end component e7udpip10g_au200;

  component config_memory_wrapper
    port (
      clk : in std_logic;
      reset : in std_logic;
			     
      MYIPADDR0_o : out std_logic_vector(31 downto 0);
      MYNETMASK0_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY0_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR0_o : out std_logic_vector(31 downto 0);
      MYMACADDR0_o : out std_logic_vector(47 downto 0);
      
      MYIPADDR1_o : out std_logic_vector(31 downto 0);
      MYNETMASK1_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY1_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR1_o : out std_logic_vector(31 downto 0);
      MYMACADDR1_o : out std_logic_vector(47 downto 0);

      MYIPADDR2_o : out std_logic_vector(31 downto 0);
      MYNETMASK2_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY2_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR2_o : out std_logic_vector(31 downto 0);
      MYMACADDR2_o : out std_logic_vector(47 downto 0);

      MYIPADDR3_o : out std_logic_vector(31 downto 0);
      MYNETMASK3_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY3_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR3_o : out std_logic_vector(31 downto 0);
      MYMACADDR3_o : out std_logic_vector(47 downto 0)
      );
  end component config_memory_wrapper;
  
  component command_parser
    port (
      clk : in std_logic;
      reset : in std_logic;
      
      UPLOut_data : out std_logic_vector(127 downto 0);
      UPLOut_en   : out std_logic;
      UPLOut_req  : out std_logic;
      UPLOut_ack  : in  std_logic;
      
      UPLIn_data : in  std_logic_vector(127 downto 0);
      UPLIn_en   : in  std_logic;
      UPLIn_req  : in  std_logic;
      UPLIn_ack  : out std_logic;
      
      synch_sender_kick : out std_logic;
      synch_sender_busy : in  std_logic;
      synch_target_addr : out std_logic_vector(31 downto 0);
      
      global_clock       : in  std_logic_vector(63 downto 0);
      global_clock_clear : out std_logic
      );
  end component command_parser;

  signal rx_block_lock_led_0 : std_logic;
  signal rx_block_lock_led_1 : std_logic;
  signal rx_block_lock_led_2 : std_logic;
  signal rx_block_lock_led_3 : std_logic;

  signal clk250mhz : std_logic;
  signal clk100mhz : std_logic;
  signal clk_locked : std_logic;
  signal sys_reset : std_logic;

  signal global_clock         : unsigned(63 downto 0);
  signal global_clock_clear   : std_logic := '0';
  signal global_clock_clear_d : std_logic := '0';
          
  signal synch_sender_out_data : std_logic_vector(127 downto 0);
  signal synch_sender_out_en   : std_logic;
  signal synch_sender_out_req  : std_logic;
  signal synch_sender_out_ack  : std_logic;
  signal synch_sender_in_data  : std_logic_vector(127 downto 0);
  signal synch_sender_in_en    : std_logic;
  signal synch_sender_in_req   : std_logic;
  signal synch_sender_in_ack   : std_logic;

  signal synch_sender_kick : std_logic;
  signal synch_sender_busy : std_logic;
  signal synch_target_addr : std_logic_vector(31 downto 0);

  signal user_upl_out_data : std_logic_vector(127 downto 0);
  signal user_upl_out_en   : std_logic;
  signal user_upl_out_req  : std_logic;
  signal user_upl_out_ack  : std_logic;
      
  signal user_upl_in_data : std_logic_vector(127 downto 0);
  signal user_upl_in_en   : std_logic;
  signal user_upl_in_req  : std_logic;
  signal user_upl_in_ack  : std_logic;

  attribute mark_debug of global_clock         : signal is "true";
  attribute mark_debug of global_clock_clear   : signal is "true";
  attribute mark_debug of global_clock_clear_d : signal is "true";
  attribute mark_debug of synch_sender_kick    : signal is "true";
  attribute mark_debug of synch_sender_busy    : signal is "true";
  attribute mark_debug of synch_target_addr    : signal is "true";

begin

  QSFP28_0_ACTIVITY_LED <= rx_block_lock_led_0 or
                           rx_block_lock_led_1 or
                           rx_block_lock_led_2 or
                           rx_block_lock_led_3 ;
  QSFP28_0_STATUS_LEDG <= '0';
  QSFP28_0_STATUS_LEDY <= '0';
  
  clk_wiz_0_i : clk_wiz_0 port map(
    clk_out1  => clk250mhz,
    clk_out2  => clk100mhz,
    reset     => '0',
    locked    => clk_locked,
    clk_in1_p => SYSCLK3_P,
    clk_in1_n => SYSCLK3_N
    );
  sys_reset <= not clk_locked;

  -- 10.3.X.X, 16'h4000
  user_upl_in_data   <= pUdp0Receive_Data_0;
  user_upl_in_req    <= pUdp0Receive_Request_0;
  pUdp0Receive_Ack_0 <= user_upl_in_ack;
  user_upl_in_en     <= pUdp0Receive_Enable_0;

  pUdp0Send_Data_0    <= user_upl_out_data;
  pUdp0Send_Request_0 <= user_upl_out_req;
  user_upl_out_ack    <= pUdp0Send_Ack_0;
  pUdp0Send_Enable_0  <= user_upl_out_en;

  pUdp1Send_Data_0    <= pUdp1Receive_Data_0;
  pUdp1Send_Request_0 <= pUdp1Receive_Request_0;
  pUdp1Receive_Ack_0  <= pUdp1Send_Ack_0;
  pUdp1Send_Enable_0  <= pUdp1Receive_Enable_0;

  pUdp0Send_Data_1    <= pUdp0Receive_Data_1;
  pUdp0Send_Request_1 <= pUdp0Receive_Request_1;
  pUdp0Receive_Ack_1  <= pUdp0Send_Ack_1;
  pUdp0Send_Enable_1  <= pUdp0Receive_Enable_1;
  
  pUdp1Send_Data_1    <= pUdp1Receive_Data_1;
  pUdp1Send_Request_1 <= pUdp1Receive_Request_1;
  pUdp1Receive_Ack_1  <= pUdp1Send_Ack_1;
  pUdp1Send_Enable_1  <= pUdp1Receive_Enable_1;

  pUdp0Send_Data_2    <= pUdp0Receive_Data_2;
  pUdp0Send_Request_2 <= pUdp0Receive_Request_2;
  pUdp0Receive_Ack_2  <= pUdp0Send_Ack_2;
  pUdp0Send_Enable_2  <= pUdp0Receive_Enable_2;
  
  pUdp1Send_Data_2    <= pUdp1Receive_Data_2;
  pUdp1Send_Request_2 <= pUdp1Receive_Request_2;
  pUdp1Receive_Ack_2  <= pUdp1Send_Ack_2;
  pUdp1Send_Enable_2  <= pUdp1Receive_Enable_2;

  pUdp0Send_Data_3    <= pUdp0Receive_Data_3;
  pUdp0Send_Request_3 <= pUdp0Receive_Request_3;
  pUdp0Receive_Ack_3  <= pUdp0Send_Ack_3;
  pUdp0Send_Enable_3  <= pUdp0Receive_Enable_3;
  
  pUdp1Send_Data_3    <= pUdp1Receive_Data_3;
  pUdp1Send_Request_3 <= pUdp1Receive_Request_3;
  pUdp1Receive_Ack_3  <= pUdp1Send_Ack_3;
  pUdp1Send_Enable_3  <= pUdp1Receive_Enable_3;

  process(clk250mhz)
  begin
    if rising_edge(clk250mhz) then
      global_clock_clear_d <= global_clock_clear;
      if global_clock_clear = '1' and global_clock_clear_d = '0' then
        global_clock <= (others => '0');
      else
        global_clock <= global_clock + 1;
      end if;
    end if;
  end process;

  synch_sender_i : synch_sender
    port map(
      clk => clk250mhz,
      reset => sys_reset,

      clock_in => std_logic_vector(global_clock),

      UPLOut_data => synch_sender_out_data,
      UPLOut_en   => synch_sender_out_en,
      UPLOut_req  => synch_sender_out_req,
      UPLOut_ack  => synch_sender_out_ack,
      
      UPLIn_data => synch_sender_in_data,
      UPLIn_en   => synch_sender_in_en,
      UPLIn_req  => synch_sender_in_req,
      UPLIn_ack  => synch_sender_in_ack,

      kick => synch_sender_kick,
      busy => synch_sender_busy,

      src_addr => MyIPAddr_1,
      dst_addr => synch_target_addr,
      src_port => MyUdpPort_1_1,
      dst_port => MyUdpPort_1_1
      );
  
  command_parser_i : command_parser
    port map(
      clk => clk250mhz,
      reset => sys_reset,
      
      UPLOut_data => user_upl_out_data,
      UPLOut_en   => user_upl_out_en,
      UPLOut_req  => user_upl_out_req,
      UPLOut_ack  => user_upl_out_ack,
      
      UPLIn_data => user_upl_in_data,
      UPLIn_en   => user_upl_in_en,
      UPLIn_req  => user_upl_in_req,
      UPLIn_ack  => user_upl_in_ack,
      
      synch_sender_kick => synch_sender_kick,
      synch_sender_busy => synch_sender_busy,
      synch_target_addr => synch_target_addr,
      
      global_clock => std_logic_vector(global_clock),
      global_clock_clear => global_clock_clear
      );

  MyUdpPort_0_0    <= X"4000";
  MyUdpPort_0_1    <= X"4001";

  MyUdpPort_1_0    <= X"4000";
  MyUdpPort_1_1    <= X"4001";

  MyUdpPort_2_0    <= X"4000";
  MyUdpPort_2_1    <= X"4001";

  MyUdpPort_3_0    <= X"4000";
  MyUdpPort_3_1    <= X"4001";
  
  e7udpip10g_au200_i : e7udpip10g_au200 port map(
    gt_rxp_in => gt_rxp_in,
    gt_rxn_in => gt_rxn_in,
    gt_txp_out => gt_txp_out,
    gt_txn_out => gt_txn_out,

    gt_refclk_p => gt_refclk_p,
    gt_refclk_n => gt_refclk_n,

    clk250mhz => clk250mhz,
    clk100mhz => clk100mhz,
    clk_locked => clk_locked,
    
    rx_block_lock_led_0 => rx_block_lock_led_0,
    rx_block_lock_led_1 => rx_block_lock_led_1,
    rx_block_lock_led_2 => rx_block_lock_led_2,
    rx_block_lock_led_3 => rx_block_lock_led_3,

    MyIpAddr_0       => MyIpAddr_0,
    MyMacAddr_0      => MyMacAddr_0,
    MyNetMask_0      => MyNetMask_0,
    DefaultGateway_0 => DefaultGateway_0,
    TargetIPAddr_0   => TargetIPAddr_0,
    MyUdpPort_0_0    => MyUdpPort_0_0,
    MyUdpPort_0_1    => MyUdpPort_0_1,
    
    pUdp0Send_Data_0       => pUdp0Send_Data_0,
    pUdp0Send_Request_0    => pUdp0Send_Request_0,
    pUdp0Send_Ack_0        => pUdp0Send_Ack_0,
    pUdp0Send_Enable_0     => pUdp0Send_Enable_0,
    pUdp1Send_Data_0       => pUdp1Send_Data_0,
    pUdp1Send_Request_0    => pUdp1Send_Request_0,
    pUdp1Send_Ack_0        => pUdp1Send_Ack_0,
    pUdp1Send_Enable_0     => pUdp1Send_Enable_0,
    pUdp0Receive_Data_0    => pUdp0Receive_Data_0,
    pUdp0Receive_Request_0 => pUdp0Receive_Request_0,
    pUdp0Receive_Ack_0     => pUdp0Receive_Ack_0,
    pUdp0Receive_Enable_0  => pUdp0Receive_Enable_0,
    pUdp1Receive_Data_0    => pUdp1Receive_Data_0,
    pUdp1Receive_Request_0 => pUdp1Receive_Request_0,
    pUdp1Receive_Ack_0     => pUdp1Receive_Ack_0,
    pUdp1Receive_Enable_0  => pUdp1Receive_Enable_0,

    MyIpAddr_1       => MyIpAddr_1,
    MyMacAddr_1      => MyMacAddr_1,
    MyNetMask_1      => MyNetMask_1,
    DefaultGateway_1 => DefaultGateway_1,
    TargetIPAddr_1   => TargetIPAddr_1,
    MyUdpPort_1_0    => MyUdpPort_1_0,
    MyUdpPort_1_1    => MyUdpPort_1_1,

    pUdp0Send_Data_1       => pUdp0Send_Data_1,
    pUdp0Send_Request_1    => pUdp0Send_Request_1,
    pUdp0Send_Ack_1        => pUdp0Send_Ack_1,
    pUdp0Send_Enable_1     => pUdp0Send_Enable_1,
    pUdp1Send_Data_1       => pUdp1Send_Data_1,
    pUdp1Send_Request_1    => pUdp1Send_Request_1,
    pUdp1Send_Ack_1        => pUdp1Send_Ack_1,
    pUdp1Send_Enable_1     => pUdp1Send_Enable_1,
    pUdp0Receive_Data_1    => pUdp0Receive_Data_1,
    pUdp0Receive_Request_1 => pUdp0Receive_Request_1,
    pUdp0Receive_Ack_1     => pUdp0Receive_Ack_1,
    pUdp0Receive_Enable_1  => pUdp0Receive_Enable_1,
    pUdp1Receive_Data_1    => pUdp1Receive_Data_1,
    pUdp1Receive_Request_1 => pUdp1Receive_Request_1,
    pUdp1Receive_Ack_1     => pUdp1Receive_Ack_1,
    pUdp1Receive_Enable_1  => pUdp1Receive_Enable_1,

    MyIpAddr_2       => MyIpAddr_2,
    MyMacAddr_2      => MyMacAddr_2,
    MyNetMask_2      => MyNetMask_2,
    DefaultGateway_2 => DefaultGateway_2,
    TargetIPAddr_2   => TargetIPAddr_2,
    MyUdpPort_2_0    => MyUdpPort_2_0,
    MyUdpPort_2_1    => MyUdpPort_2_1,

    pUdp0Send_Data_2       => pUdp0Send_Data_2,
    pUdp0Send_Request_2    => pUdp0Send_Request_2,
    pUdp0Send_Ack_2        => pUdp0Send_Ack_2,
    pUdp0Send_Enable_2     => pUdp0Send_Enable_2,
    pUdp1Send_Data_2       => pUdp1Send_Data_2,
    pUdp1Send_Request_2    => pUdp1Send_Request_2,
    pUdp1Send_Ack_2        => pUdp1Send_Ack_2,
    pUdp1Send_Enable_2     => pUdp1Send_Enable_2,
    pUdp0Receive_Data_2    => pUdp0Receive_Data_2,
    pUdp0Receive_Request_2 => pUdp0Receive_Request_2,
    pUdp0Receive_Ack_2     => pUdp0Receive_Ack_2,
    pUdp0Receive_Enable_2  => pUdp0Receive_Enable_2,
    pUdp1Receive_Data_2    => pUdp1Receive_Data_2,
    pUdp1Receive_Request_2 => pUdp1Receive_Request_2,
    pUdp1Receive_Ack_2     => pUdp1Receive_Ack_2,
    pUdp1Receive_Enable_2  => pUdp1Receive_Enable_2,

    MyIpAddr_3       => MyIpAddr_3,
    MyMacAddr_3      => MyMacAddr_3,
    MyNetMask_3      => MyNetMask_3,
    DefaultGateway_3 => DefaultGateway_3,
    TargetIPAddr_3   => TargetIPAddr_3,
    MyUdpPort_3_0    => MyUdpPort_3_0,
    MyUdpPort_3_1    => MyUdpPort_3_1,

    pUdp0Send_Data_3       => pUdp0Send_Data_3,
    pUdp0Send_Request_3    => pUdp0Send_Request_3,
    pUdp0Send_Ack_3        => pUdp0Send_Ack_3,
    pUdp0Send_Enable_3     => pUdp0Send_Enable_3,
    pUdp1Send_Data_3       => pUdp1Send_Data_3,
    pUdp1Send_Request_3    => pUdp1Send_Request_3,
    pUdp1Send_Ack_3        => pUdp1Send_Ack_3,
    pUdp1Send_Enable_3     => pUdp1Send_Enable_3,
    pUdp0Receive_Data_3    => pUdp0Receive_Data_3,
    pUdp0Receive_Request_3 => pUdp0Receive_Request_3,
    pUdp0Receive_Ack_3     => pUdp0Receive_Ack_3,
    pUdp0Receive_Enable_3  => pUdp0Receive_Enable_3,
    pUdp1Receive_Data_3    => pUdp1Receive_Data_3,
    pUdp1Receive_Request_3 => pUdp1Receive_Request_3,
    pUdp1Receive_Ack_3     => pUdp1Receive_Ack_3,
    pUdp1Receive_Enable_3  => pUdp1Receive_Enable_3
    );
    
  ila_1_i : ila_1 port map(
    clk                  => clk250mhz,
    probe0(127 downto 0) => pUdp0Send_Data_0,
    probe0(128)          => pUdp0Send_Request_0,
    probe0(129)          => pUdp0Send_Ack_0,
    probe0(130)          => pUdp0Send_Enable_0,
    probe1(127 downto 0) => pUdp1Send_Data_0,
    probe1(128)          => pUdp1Send_Request_0,
    probe1(129)          => pUdp1Send_Ack_0,
    probe1(130)          => pUdp1Send_Enable_0,
    
    probe2(127 downto 0) => pUdp0Send_Data_1,
    probe2(128)          => pUdp0Send_Request_1,
    probe2(129)          => pUdp0Send_Ack_1,
    probe2(130)          => pUdp0Send_Enable_1,
    probe3(127 downto 0) => pUdp1Send_Data_1,
    probe3(128)          => pUdp1Send_Request_1,
    probe3(129)          => pUdp1Send_Ack_1,
    probe3(130)          => pUdp1Send_Enable_1,
    
    probe4(127 downto 0) => pUdp0Send_Data_2,
    probe4(128)          => pUdp0Send_Request_2,
    probe4(129)          => pUdp0Send_Ack_2,
    probe4(130)          => pUdp0Send_Enable_2,
    probe5(127 downto 0) => pUdp1Send_Data_2,
    probe5(128)          => pUdp1Send_Request_2,
    probe5(129)          => pUdp1Send_Ack_2,
    probe5(130)          => pUdp1Send_Enable_2,
    
    probe6(127 downto 0) => pUdp0Send_Data_3,
    probe6(128)          => pUdp0Send_Request_3,
    probe6(129)          => pUdp0Send_Ack_3,
    probe6(130)          => pUdp0Send_Enable_3,
    probe7(127 downto 0) => pUdp1Send_Data_3,
    probe7(128)          => pUdp1Send_Request_3,
    probe7(129)          => pUdp1Send_Ack_3,
    probe7(130)          => pUdp1Send_Enable_3
    );

  config_memory_wrapper_i : config_memory_wrapper port map(
    clk => clk250mhz,
    reset => sys_reset,
			     
    MYIPADDR0_o => MyIpAddr_0,
    MYNETMASK0_o => MyNetMask_0,
    MYDEFAULTGATEWAY0_o => DefaultGateway_0,
    MYTARGETIPADDR0_o => TargetIPAddr_0,
    MYMACADDR0_o => MyMacAddr_0,
      
    MYIPADDR1_o => MyIPAddr_1,
    MYNETMASK1_o => MyNetMask_1,
    MYDEFAULTGATEWAY1_o => DefaultGateway_1,
    MYTARGETIPADDR1_o => TargetIPAddr_1,
    MYMACADDR1_o => MyMacAddr_1,

    MYIPADDR2_o => MyIPAddr_2,
    MYNETMASK2_o => MyNetMask_2,
    MYDEFAULTGATEWAY2_o => DefaultGateway_2,
    MYTARGETIPADDR2_o => TargetIPAddr_2,
    MYMACADDR2_o => MyMacAddr_2,

    MYIPADDR3_o => MyIPAddr_3,
    MYNETMASK3_o => MyNetMask_3,
    MYDEFAULTGATEWAY3_o => DefaultGateway_3,
    MYTARGETIPADDR3_o => TargetIPAddr_3,
    MYMACADDR3_o => MyMacAddr_3
    );

end RTL;
