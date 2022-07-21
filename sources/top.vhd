library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xpm;
use xpm.vcomponents.all;

entity top is
  port(
    gt_rxp_in : in std_logic_vector(8-1 downto 0);
    gt_rxn_in : in std_logic_vector(8-1 downto 0);
    gt_txp_out : out std_logic_vector(8-1 downto 0);
    gt_txn_out : out std_logic_vector(8-1 downto 0);

    QSFP28_0_ACTIVITY_LED : out std_logic;
    QSFP28_0_STATUS_LEDG  : out std_logic;
    QSFP28_0_STATUS_LEDY  : out std_logic;
    
    gt_refclk_p : in std_logic_vector(1 downto 0);
    gt_refclk_n : in std_logic_vector(1 downto 0);

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
      clk_out3  : out std_logic;
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

  component ila_0
    port (
      clk : in std_logic;
      probe0 : in std_logic_vector(63 downto 0);
      probe1 : in std_logic_vector(2 downto 0);
      probe2 : in std_logic_vector(63 downto 0);
      probe3 : in std_logic_vector(0 downto 0);
      probe4 : in std_logic_vector(0 downto 0);
      probe5 : in std_logic_vector(31 downto 0);
      probe6 : in std_logic_vector(15 downto 0)
      );
  end component ila_0;
  
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

  signal pUdp0Send_Data_4    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_4 : std_logic;
  signal pUdp0Send_Ack_4     : std_logic;
  signal pUdp0Send_Enable_4  : std_logic;
  signal pUdp1Send_Data_4    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_4 : std_logic;
  signal pUdp1Send_Ack_4     : std_logic;
  signal pUdp1Send_Enable_4  : std_logic;
  
  signal pUdp0Receive_Data_4    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_4 : std_logic;
  signal pUdp0Receive_Ack_4     : std_logic;
  signal pUdp0Receive_Enable_4  : std_logic;
  signal pUdp1Receive_Data_4    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_4 : std_logic;
  signal pUdp1Receive_Ack_4     : std_logic;
  signal pUdp1Receive_Enable_4  : std_logic;
  
  signal pUdp0Send_Data_5    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_5 : std_logic;
  signal pUdp0Send_Ack_5     : std_logic;
  signal pUdp0Send_Enable_5  : std_logic;
  signal pUdp1Send_Data_5    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_5 : std_logic;
  signal pUdp1Send_Ack_5     : std_logic;
  signal pUdp1Send_Enable_5  : std_logic;
  
  signal pUdp0Receive_Data_5    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_5 : std_logic;
  signal pUdp0Receive_Ack_5     : std_logic;
  signal pUdp0Receive_Enable_5  : std_logic;
  signal pUdp1Receive_Data_5    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_5 : std_logic;
  signal pUdp1Receive_Ack_5     : std_logic;
  signal pUdp1Receive_Enable_5  : std_logic;

  signal pUdp0Send_Data_6    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_6 : std_logic;
  signal pUdp0Send_Ack_6     : std_logic;
  signal pUdp0Send_Enable_6  : std_logic;
  signal pUdp1Send_Data_6    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_6 : std_logic;
  signal pUdp1Send_Ack_6     : std_logic;
  signal pUdp1Send_Enable_6  : std_logic;
  
  signal pUdp0Receive_Data_6    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_6 : std_logic;
  signal pUdp0Receive_Ack_6     : std_logic;
  signal pUdp0Receive_Enable_6  : std_logic;
  signal pUdp1Receive_Data_6    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_6 : std_logic;
  signal pUdp1Receive_Ack_6     : std_logic;
  signal pUdp1Receive_Enable_6  : std_logic;

  signal pUdp0Send_Data_7    : std_logic_vector(127 downto 0);
  signal pUdp0Send_Request_7 : std_logic;
  signal pUdp0Send_Ack_7     : std_logic;
  signal pUdp0Send_Enable_7  : std_logic;
  signal pUdp1Send_Data_7    : std_logic_vector(127 downto 0);
  signal pUdp1Send_Request_7 : std_logic;
  signal pUdp1Send_Ack_7     : std_logic;
  signal pUdp1Send_Enable_7  : std_logic;
  
  signal pUdp0Receive_Data_7    : std_logic_vector(127 downto 0);
  signal pUdp0Receive_Request_7 : std_logic;
  signal pUdp0Receive_Ack_7     : std_logic;
  signal pUdp0Receive_Enable_7  : std_logic;
  signal pUdp1Receive_Data_7    : std_logic_vector(127 downto 0);
  signal pUdp1Receive_Request_7 : std_logic;
  signal pUdp1Receive_Ack_7     : std_logic;
  signal pUdp1Receive_Enable_7  : std_logic;
  
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

  signal MyIpAddr_4       : std_logic_vector(31 downto 0);
  signal MyMacAddr_4      : std_logic_vector(47 downto 0);
  signal MyNetMask_4      : std_logic_vector(31 downto 0);
  signal DefaultGateway_4 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_4   : std_logic_vector(31 downto 0);
  signal MyUdpPort_4_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_4_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_5       : std_logic_vector(31 downto 0);
  signal MyMacAddr_5      : std_logic_vector(47 downto 0);
  signal MyNetMask_5      : std_logic_vector(31 downto 0);
  signal DefaultGateway_5 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_5   : std_logic_vector(31 downto 0);
  signal MyUdpPort_5_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_5_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_6       : std_logic_vector(31 downto 0);
  signal MyMacAddr_6      : std_logic_vector(47 downto 0);
  signal MyNetMask_6      : std_logic_vector(31 downto 0);
  signal DefaultGateway_6 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_6   : std_logic_vector(31 downto 0);
  signal MyUdpPort_6_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_6_1    : std_logic_vector(15 downto 0);

  signal MyIpAddr_7       : std_logic_vector(31 downto 0);
  signal MyMacAddr_7      : std_logic_vector(47 downto 0);
  signal MyNetMask_7      : std_logic_vector(31 downto 0);
  signal DefaultGateway_7 : std_logic_vector(31 downto 0);
  signal TargetIPAddr_7   : std_logic_vector(31 downto 0);
  signal MyUdpPort_7_0    : std_logic_vector(15 downto 0);
  signal MyUdpPort_7_1    : std_logic_vector(15 downto 0);

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

  component e7udpip10g_au200_dual
    port(
      gt_rxp_in : in std_logic_vector(8-1 downto 0);
      gt_rxn_in : in std_logic_vector(8-1 downto 0);
      gt_txp_out : out std_logic_vector(8-1 downto 0);
      gt_txn_out : out std_logic_vector(8-1 downto 0);

      gt_refclk_p : in std_logic_vector(1 downto 0);
      gt_refclk_n : in std_logic_vector(1 downto 0);

      clk250mhz : in std_logic;
      clk100mhz : in std_logic;
      clk_locked : in std_logic;
      
      rx_block_lock_led_0 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_1 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_2 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_3 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_4 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_5 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_6 : out std_logic;  -- Indicates Core Block Lock
      rx_block_lock_led_7 : out std_logic;  -- Indicates Core Block Lock

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
      pUdp1Receive_Enable_3  : out std_logic;

      MyIpAddr_4       : in std_logic_vector(31 downto 0);
      MyMacAddr_4      : in std_logic_vector(47 downto 0);
      MyNetMask_4      : in std_logic_vector(31 downto 0);
      DefaultGateway_4 : in std_logic_vector(31 downto 0);
      TargetIPAddr_4   : in std_logic_vector(31 downto 0);
      MyUdpPort_4_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_4_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_4       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_4    : in  std_logic;
      pUdp0Send_Ack_4        : out std_logic;
      pUdp0Send_Enable_4     : in  std_logic;
      pUdp1Send_Data_4       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_4    : in  std_logic;
      pUdp1Send_Ack_4        : out std_logic;
      pUdp1Send_Enable_4     : in  std_logic;
      pUdp0Receive_Data_4    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_4 : out std_logic;
      pUdp0Receive_Ack_4     : in  std_logic;
      pUdp0Receive_Enable_4  : out std_logic;
      pUdp1Receive_Data_4    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_4 : out std_logic;
      pUdp1Receive_Ack_4     : in  std_logic;
      pUdp1Receive_Enable_4  : out std_logic;
      
      MyIpAddr_5       : in std_logic_vector(31 downto 0);
      MyMacAddr_5      : in std_logic_vector(47 downto 0);
      MyNetMask_5      : in std_logic_vector(31 downto 0);
      DefaultGateway_5 : in std_logic_vector(31 downto 0);
      TargetIPAddr_5   : in std_logic_vector(31 downto 0);
      MyUdpPort_5_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_5_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_5       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_5    : in  std_logic;
      pUdp0Send_Ack_5        : out std_logic;
      pUdp0Send_Enable_5     : in  std_logic;
      pUdp1Send_Data_5       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_5    : in  std_logic;
      pUdp1Send_Ack_5        : out std_logic;
      pUdp1Send_Enable_5     : in  std_logic;
      pUdp0Receive_Data_5    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_5 : out std_logic;
      pUdp0Receive_Ack_5     : in  std_logic;
      pUdp0Receive_Enable_5  : out std_logic;
      pUdp1Receive_Data_5    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_5 : out std_logic;
      pUdp1Receive_Ack_5     : in  std_logic;
      pUdp1Receive_Enable_5  : out std_logic;

      MyIpAddr_6       : in std_logic_vector(31 downto 0);
      MyMacAddr_6      : in std_logic_vector(47 downto 0);
      MyNetMask_6      : in std_logic_vector(31 downto 0);
      DefaultGateway_6 : in std_logic_vector(31 downto 0);
      TargetIPAddr_6   : in std_logic_vector(31 downto 0);
      MyUdpPort_6_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_6_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_6       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_6    : in  std_logic;
      pUdp0Send_Ack_6        : out std_logic;
      pUdp0Send_Enable_6     : in  std_logic;
      pUdp1Send_Data_6       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_6    : in  std_logic;
      pUdp1Send_Ack_6        : out std_logic;
      pUdp1Send_Enable_6     : in  std_logic;
      pUdp0Receive_Data_6    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_6 : out std_logic;
      pUdp0Receive_Ack_6     : in  std_logic;
      pUdp0Receive_Enable_6  : out std_logic;
      pUdp1Receive_Data_6    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_6 : out std_logic;
      pUdp1Receive_Ack_6     : in  std_logic;
      pUdp1Receive_Enable_6  : out std_logic;

      MyIpAddr_7       : in std_logic_vector(31 downto 0);
      MyMacAddr_7      : in std_logic_vector(47 downto 0);
      MyNetMask_7      : in std_logic_vector(31 downto 0);
      DefaultGateway_7 : in std_logic_vector(31 downto 0);
      TargetIPAddr_7   : in std_logic_vector(31 downto 0);
      MyUdpPort_7_0    : in std_logic_vector(15 downto 0);
      MyUdpPort_7_1    : in std_logic_vector(15 downto 0);

      pUdp0Send_Data_7       : in  std_logic_vector(127 downto 0);
      pUdp0Send_Request_7    : in  std_logic;
      pUdp0Send_Ack_7        : out std_logic;
      pUdp0Send_Enable_7     : in  std_logic;
      pUdp1Send_Data_7       : in  std_logic_vector(127 downto 0);
      pUdp1Send_Request_7    : in  std_logic;
      pUdp1Send_Ack_7        : out std_logic;
      pUdp1Send_Enable_7     : in  std_logic;
      pUdp0Receive_Data_7    : out std_logic_vector(127 downto 0);
      pUdp0Receive_Request_7 : out std_logic;
      pUdp0Receive_Ack_7     : in  std_logic;
      pUdp0Receive_Enable_7  : out std_logic;
      pUdp1Receive_Data_7    : out std_logic_vector(127 downto 0);
      pUdp1Receive_Request_7 : out std_logic;
      pUdp1Receive_Ack_7     : in  std_logic;
      pUdp1Receive_Enable_7  : out std_logic
      );
  end component e7udpip10g_au200_dual;

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
      MYMACADDR3_o : out std_logic_vector(47 downto 0);
      
      MYIPADDR4_o : out std_logic_vector(31 downto 0);
      MYNETMASK4_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY4_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR4_o : out std_logic_vector(31 downto 0);
      MYMACADDR4_o : out std_logic_vector(47 downto 0);

      MYIPADDR5_o : out std_logic_vector(31 downto 0);
      MYNETMASK5_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY5_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR5_o : out std_logic_vector(31 downto 0);
      MYMACADDR5_o : out std_logic_vector(47 downto 0);

      MYIPADDR6_o : out std_logic_vector(31 downto 0);
      MYNETMASK6_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY6_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR6_o : out std_logic_vector(31 downto 0);
      MYMACADDR6_o : out std_logic_vector(47 downto 0);
      
      MYIPADDR7_o : out std_logic_vector(31 downto 0);
      MYNETMASK7_o : out std_logic_vector(31 downto 0);
      MYDEFAULTGATEWAY7_o : out std_logic_vector(31 downto 0);
      MYTARGETIPADDR7_o : out std_logic_vector(31 downto 0);
      MYMACADDR7_o : out std_logic_vector(47 downto 0)
      );
  end component config_memory_wrapper;
  
  component command_parser
    port(
      -- input
      UPL_input_data : in std_logic_vector(128-1 downto 0);
      UPL_input_en : in std_logic;
      UPL_input_req : in std_logic;
      UPL_input_ack : out std_logic;
      
      -- forward_input
      UPL_forward_input_data : in std_logic_vector(128-1 downto 0);
      UPL_forward_input_en : in std_logic;
      UPL_forward_input_req : in std_logic;
      UPL_forward_input_ack : out std_logic;
      
      -- output
      UPL_output_data : out std_logic_vector(128-1 downto 0);
      UPL_output_en : out std_logic;
      UPL_output_req : out std_logic;
      UPL_output_ack : in std_logic;
      
      -- forward_output
      UPL_forward_output_data : out std_logic_vector(128-1 downto 0);
      UPL_forward_output_en : out std_logic;
      UPL_forward_output_req : out std_logic;
      UPL_forward_output_ack : in std_logic;
      
      -- user-defiend ports
      synch_sender_kick : out std_logic;
      synch_sender_busy : in std_logic;
      synch_target_addr : out std_logic_vector(32-1 downto 0);
      synch_target_port : out std_logic_vector(16-1 downto 0);
      global_clock : in std_logic_vector(64-1 downto 0);
      global_clock_clear : out std_logic;
      global_clock_set_value : out std_logic_vector(64-1 downto 0);
      
      -- system clock and reset
      clk : in std_logic;
      reset : in std_logic
      );
  end component command_parser;

  signal rx_block_lock_led_0 : std_logic;
  signal rx_block_lock_led_1 : std_logic;
  signal rx_block_lock_led_2 : std_logic;
  signal rx_block_lock_led_3 : std_logic;
  signal rx_block_lock_led_4 : std_logic;
  signal rx_block_lock_led_5 : std_logic;
  signal rx_block_lock_led_6 : std_logic;
  signal rx_block_lock_led_7 : std_logic;

  signal clk250mhz : std_logic;
  signal clk100mhz : std_logic;
  signal clk125mhz : std_logic;
  signal clk_locked : std_logic;
  signal sys_reset : std_logic;

  signal global_clock                  : unsigned(63 downto 0);
  signal global_clock_clear_125mhz     : std_logic;
  signal global_clock_clear_125mhz_d   : std_logic;
  signal global_clock_set_value_125mhz : std_logic_vector(63 downto 0);
  
  signal global_clock_250mhz      : std_logic_vector(63 downto 0);
  signal global_clock_clear       : std_logic := '0';
  signal global_clock_clear_d     : std_logic := '0';
  signal global_clock_set_value   : std_logic_vector(63 downto 0);
  signal global_clock_set_value_d : std_logic_vector(63 downto 0);
  signal global_clock_clear_recv  : std_logic;
    
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
  signal synch_target_port : std_logic_vector(15 downto 0);

  signal user_upl_out_data : std_logic_vector(127 downto 0);
  signal user_upl_out_en   : std_logic;
  signal user_upl_out_req  : std_logic;
  signal user_upl_out_ack  : std_logic;
      
  signal user_upl_in_data : std_logic_vector(127 downto 0);
  signal user_upl_in_en   : std_logic;
  signal user_upl_in_req  : std_logic;
  signal user_upl_in_ack  : std_logic;

  attribute mark_debug of global_clock_250mhz     : signal is "true";
  attribute mark_debug of global_clock_clear      : signal is "true";
  attribute mark_debug of global_clock_clear_d    : signal is "true";
  attribute mark_debug of global_clock_clear_recv : signal is "true";
  attribute mark_debug of global_clock_set_value  : signal is "true";
  attribute mark_debug of synch_sender_kick       : signal is "true";
  attribute mark_debug of synch_sender_busy       : signal is "true";
  attribute mark_debug of synch_target_addr       : signal is "true";
  attribute mark_debug of synch_target_port       : signal is "true";

  signal forward_input_data : std_logic_vector(127 downto 0);
  signal forward_input_en   : std_logic;
  signal forward_input_req  : std_logic;
  signal forward_input_ack  : std_logic;
  
  signal forward_output_data : std_logic_vector(127 downto 0);
  signal forward_output_en   : std_logic;
  signal forward_output_req  : std_logic;
  signal forward_output_ack  : std_logic;

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
    clk_out3  => clk125mhz,
    reset     => '0',
    locked    => clk_locked,
    clk_in1_p => SYSCLK3_P,
    clk_in1_n => SYSCLK3_N
    );
  sys_reset <= not clk_locked;

  ----------------------------------------------------
  -- 10.3.X.X, 16'h4000
  user_upl_in_data   <= pUdp0Receive_Data_0;
  user_upl_in_req    <= pUdp0Receive_Request_0;
  pUdp0Receive_Ack_0 <= user_upl_in_ack;
  user_upl_in_en     <= pUdp0Receive_Enable_0;

  pUdp0Send_Data_0    <= user_upl_out_data;
  pUdp0Send_Request_0 <= user_upl_out_req;
  user_upl_out_ack    <= pUdp0Send_Ack_0;
  pUdp0Send_Enable_0  <= user_upl_out_en;

  -- 10.3.X.X, 16'h4001
  pUdp1Send_Data_0    <= pUdp1Receive_Data_0;
  pUdp1Send_Request_0 <= pUdp1Receive_Request_0;
  pUdp1Receive_Ack_0  <= pUdp1Send_Ack_0;
  pUdp1Send_Enable_0  <= pUdp1Receive_Enable_0;
  ----------------------------------------------------

  -- ----------------------------------------------------
  -- -- 10.4.X.X, 16'h4000
  -- forward_input_data <= pUdp0Receive_Data_1;
  -- forward_input_req  <= pUdp0Receive_Request_1;
  -- pUdp0Receive_Ack_1 <= forward_input_ack;
  -- forward_input_en   <= pUdp0Receive_Enable_1;
  
  -- pUdp0Send_Data_1    <= forward_output_data;
  -- pUdp0Send_Request_1 <= forward_output_req;
  -- forward_output_ack  <= pUdp0Send_Ack_1;
  -- pUdp0Send_Enable_1  <= forward_output_en;
  
  -- -- 10.4.X.X, 16'h4001
  -- synch_sender_in_data <= pUdp1Receive_Data_1;
  -- synch_sender_in_req  <= pUdp1Receive_Request_1;
  -- pUdp1Receive_Ack_1   <= synch_sender_in_ack;
  -- synch_sender_in_en   <= pUdp1Receive_Enable_1;

  -- pUdp1Send_Data_1     <= synch_sender_out_data;
  -- pUdp1Send_Request_1  <= synch_sender_out_req;
  -- synch_sender_out_ack <= pUdp1Send_Ack_1;
  -- pUdp1Send_Enable_1   <= synch_sender_out_en;
  -- ----------------------------------------------------

  ----------------------------------------------------
  -- 10.254.X.X, 16'h4000
  pUdp0Send_Data_1    <= pUdp0Receive_Data_1;
  pUdp0Send_Request_1 <= pUdp0Receive_Request_1;
  pUdp0Receive_Ack_1  <= pUdp0Send_Ack_1;
  pUdp0Send_Enable_1  <= pUdp0Receive_Enable_1;
  
  -- 10.254.X.X, 16'h4001
  pUdp1Send_Data_1    <= pUdp1Receive_Data_1;
  pUdp1Send_Request_1 <= pUdp1Receive_Request_1;
  pUdp1Receive_Ack_1  <= pUdp1Send_Ack_1;
  pUdp1Send_Enable_1  <= pUdp1Receive_Enable_1;
  ----------------------------------------------------

  ----------------------------------------------------
  -- 10.254.X.X, 16'h4000
  pUdp0Send_Data_2    <= pUdp0Receive_Data_2;
  pUdp0Send_Request_2 <= pUdp0Receive_Request_2;
  pUdp0Receive_Ack_2  <= pUdp0Send_Ack_2;
  pUdp0Send_Enable_2  <= pUdp0Receive_Enable_2;
  
  -- 10.254.X.X, 16'h4001
  pUdp1Send_Data_2    <= pUdp1Receive_Data_2;
  pUdp1Send_Request_2 <= pUdp1Receive_Request_2;
  pUdp1Receive_Ack_2  <= pUdp1Send_Ack_2;
  pUdp1Send_Enable_2  <= pUdp1Receive_Enable_2;
  ----------------------------------------------------

  ----------------------------------------------------
  -- 10.255.X.X, 16'h4000
  pUdp0Send_Data_3    <= pUdp0Receive_Data_3;
  pUdp0Send_Request_3 <= pUdp0Receive_Request_3;
  pUdp0Receive_Ack_3  <= pUdp0Send_Ack_3;
  pUdp0Send_Enable_3  <= pUdp0Receive_Enable_3;
  
  -- 10.254.X.X, 16'h4001
  pUdp1Send_Data_3    <= pUdp1Receive_Data_3;
  pUdp1Send_Request_3 <= pUdp1Receive_Request_3;
  pUdp1Receive_Ack_3  <= pUdp1Send_Ack_3;
  pUdp1Send_Enable_3  <= pUdp1Receive_Enable_3;
  ----------------------------------------------------

  ----------------------------------------------------
  -- 10.4.X.X, 16'h4000
  forward_input_data <= pUdp0Receive_Data_4;
  forward_input_req  <= pUdp0Receive_Request_4;
  pUdp0Receive_Ack_4 <= forward_input_ack;
  forward_input_en   <= pUdp0Receive_Enable_4;
  
  pUdp0Send_Data_4    <= forward_output_data;
  pUdp0Send_Request_4 <= forward_output_req;
  forward_output_ack  <= pUdp0Send_Ack_4;
  pUdp0Send_Enable_4  <= forward_output_en;
  
  -- 10.4.X.X, 16'h4001
  synch_sender_in_data <= pUdp1Receive_Data_4;
  synch_sender_in_req  <= pUdp1Receive_Request_4;
  pUdp1Receive_Ack_4   <= synch_sender_in_ack;
  synch_sender_in_en   <= pUdp1Receive_Enable_4;

  pUdp1Send_Data_4     <= synch_sender_out_data;
  pUdp1Send_Request_4  <= synch_sender_out_req;
  synch_sender_out_ack <= pUdp1Send_Ack_4;
  pUdp1Send_Enable_4   <= synch_sender_out_en;
  ----------------------------------------------------

  ----------------------------------------------------
  -- 10.255.X.X, 16'h4000
  pUdp0Send_Data_6    <= pUdp0Receive_Data_6;
  pUdp0Send_Request_6 <= pUdp0Receive_Request_6;
  pUdp0Receive_Ack_6  <= pUdp0Send_Ack_6;
  pUdp0Send_Enable_6  <= pUdp0Receive_Enable_6;
  
  -- 10.254.X.X, 16'h4001
  pUdp1Send_Data_6    <= pUdp1Receive_Data_6;
  pUdp1Send_Request_6 <= pUdp1Receive_Request_6;
  pUdp1Receive_Ack_6  <= pUdp1Send_Ack_6;
  pUdp1Send_Enable_6  <= pUdp1Receive_Enable_6;
  ----------------------------------------------------

  ----------------------------------------------------
  -- 10.255.X.X, 16'h4000
  pUdp0Send_Data_7    <= pUdp0Receive_Data_7;
  pUdp0Send_Request_7 <= pUdp0Receive_Request_7;
  pUdp0Receive_Ack_7  <= pUdp0Send_Ack_7;
  pUdp0Send_Enable_7  <= pUdp0Receive_Enable_7;
  
  -- 10.254.X.X, 16'h4001
  pUdp1Send_Data_7    <= pUdp1Receive_Data_7;
  pUdp1Send_Request_7 <= pUdp1Receive_Request_7;
  pUdp1Receive_Ack_7  <= pUdp1Send_Ack_7;
  pUdp1Send_Enable_7  <= pUdp1Receive_Enable_7;
  ----------------------------------------------------

  process(clk125mhz)
  begin
    if rising_edge(clk125mhz) then
      if sys_reset = '1' then
        global_clock <= (others => '0');
      else
        global_clock_clear_125mhz_d <= global_clock_clear_125mhz;
        if global_clock_clear_125mhz = '1' and global_clock_clear_125mhz_d = '0' then -- rising of global_clock_clear_125mhz
          global_clock <= unsigned(global_clock_set_value_125mhz);
        else
          global_clock <= global_clock + 1;
        end if;
      end if;
    end if;
  end process;

  xpm_cdc_array_single_125_to_250 : xpm_cdc_array_single
    generic map(
      WIDTH => 64
      )
    port map (
      src_clk => clk125mhz,
      dest_clk => clk250mhz,
      src_in => std_logic_vector(global_clock),
      dest_out => global_clock_250mhz
      );
  
  xpm_cdc_handshake_250_to_125 : xpm_cdc_handshake
    generic map(
      DEST_EXT_HSK => 0,
      DEST_SYNC_FF => 4,
      INIT_SYNC_FF => 0,
      SIM_ASSERT_CHK => 0,
      SRC_SYNC_FF => 4,
      WIDTH => 64
      )
    port map(
      dest_out => global_clock_set_value_125mhz,
      dest_req => global_clock_clear_125mhz,
      src_rcv => global_clock_clear_recv,
      dest_ack => '0',
      dest_clk => clk125mhz,
      src_clk => clk250mhz,
      src_in => global_clock_set_value_d,
      src_send => global_clock_clear_d
      );

  process(clk250mhz)
  begin
    if rising_edge(clk250mhz) then
      if sys_reset = '1' then
        global_clock_clear_d <= '0';
      else
        if global_clock_clear = '1' and global_clock_clear_recv = '0' then
          global_clock_clear_d <= '1';
          global_clock_set_value_d <= global_clock_set_value;
        elsif global_clock_clear_d = '1' and global_clock_clear_recv = '1' then
          global_clock_clear_d <= '0';
        end if;
      end if;
    end if;
  end process;

  synch_sender_i : synch_sender
    port map(
      clk => clk250mhz,
      reset => sys_reset,

      clock_in => global_clock_250mhz,

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
      dst_port => synch_target_port
      );
  
  command_parser_i : command_parser
    port map(
      -- input
      UPL_input_data => user_upl_in_data,
      UPL_input_en   => user_upl_in_en,
      UPL_input_req  => user_upl_in_req,
      UPL_input_ack  => user_upl_in_ack,

      -- forward_input
      UPL_forward_input_data => forward_input_data,
      UPL_forward_input_en   => forward_input_en,
      UPL_forward_input_req  => forward_input_req,
      UPL_forward_input_ack  => forward_input_ack,

      -- output
      UPL_output_data => user_upl_out_data,
      UPL_output_en   => user_upl_out_en,
      UPL_output_req  => user_upl_out_req,
      UPL_output_ack  => user_upl_out_ack,

      -- forward_output
      UPL_forward_output_data => forward_output_data,
      UPL_forward_output_en   => forward_output_en,
      UPL_forward_output_req  => forward_output_req,
      UPL_forward_output_ack  => forward_output_ack,

      -- user-defiend ports
      synch_sender_kick      => synch_sender_kick,
      synch_sender_busy      => synch_sender_busy,
      synch_target_addr      => synch_target_addr,
      synch_target_port      => synch_target_port,
      global_clock           => global_clock_250mhz,
      global_clock_clear     => global_clock_clear,
      global_clock_set_value => global_clock_set_value,

      -- system clock and reset
      clk   => clk250mhz,
      reset => sys_reset
      );

  MyUdpPort_0_0    <= X"4000";
  MyUdpPort_0_1    <= X"4001";

  MyUdpPort_1_0    <= X"4000";
  MyUdpPort_1_1    <= X"4001";

  MyUdpPort_2_0    <= X"4000";
  MyUdpPort_2_1    <= X"4001";

  MyUdpPort_3_0    <= X"4000";
  MyUdpPort_3_1    <= X"4001";
  
  e7udpip10g_au200_dual_i : e7udpip10g_au200_dual port map(
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
    rx_block_lock_led_4 => rx_block_lock_led_4,
    rx_block_lock_led_5 => rx_block_lock_led_5,
    rx_block_lock_led_6 => rx_block_lock_led_6,
    rx_block_lock_led_7 => rx_block_lock_led_7,

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
    pUdp1Receive_Enable_3  => pUdp1Receive_Enable_3,

    MyIpAddr_4       => MyIpAddr_4,
    MyMacAddr_4      => MyMacAddr_4,
    MyNetMask_4      => MyNetMask_4,
    DefaultGateway_4 => DefaultGateway_4,
    TargetIPAddr_4   => TargetIPAddr_4,
    MyUdpPort_4_0    => MyUdpPort_4_0,
    MyUdpPort_4_1    => MyUdpPort_4_1,

    pUdp0Send_Data_4       => pUdp0Send_Data_4,
    pUdp0Send_Request_4    => pUdp0Send_Request_4,
    pUdp0Send_Ack_4        => pUdp0Send_Ack_4,
    pUdp0Send_Enable_4     => pUdp0Send_Enable_4,
    pUdp1Send_Data_4       => pUdp1Send_Data_4,
    pUdp1Send_Request_4    => pUdp1Send_Request_4,
    pUdp1Send_Ack_4        => pUdp1Send_Ack_4,
    pUdp1Send_Enable_4     => pUdp1Send_Enable_4,
    pUdp0Receive_Data_4    => pUdp0Receive_Data_4,
    pUdp0Receive_Request_4 => pUdp0Receive_Request_4,
    pUdp0Receive_Ack_4     => pUdp0Receive_Ack_4,
    pUdp0Receive_Enable_4  => pUdp0Receive_Enable_4,
    pUdp1Receive_Data_4    => pUdp1Receive_Data_4,
    pUdp1Receive_Request_4 => pUdp1Receive_Request_4,
    pUdp1Receive_Ack_4     => pUdp1Receive_Ack_4,
    pUdp1Receive_Enable_4  => pUdp1Receive_Enable_4,

    MyIpAddr_5       => MyIpAddr_5,
    MyMacAddr_5      => MyMacAddr_5,
    MyNetMask_5      => MyNetMask_5,
    DefaultGateway_5 => DefaultGateway_5,
    TargetIPAddr_5   => TargetIPAddr_5,
    MyUdpPort_5_0    => MyUdpPort_5_0,
    MyUdpPort_5_1    => MyUdpPort_5_1,

    pUdp0Send_Data_5       => pUdp0Send_Data_5,
    pUdp0Send_Request_5    => pUdp0Send_Request_5,
    pUdp0Send_Ack_5        => pUdp0Send_Ack_5,
    pUdp0Send_Enable_5     => pUdp0Send_Enable_5,
    pUdp1Send_Data_5       => pUdp1Send_Data_5,
    pUdp1Send_Request_5    => pUdp1Send_Request_5,
    pUdp1Send_Ack_5        => pUdp1Send_Ack_5,
    pUdp1Send_Enable_5     => pUdp1Send_Enable_5,
    pUdp0Receive_Data_5    => pUdp0Receive_Data_5,
    pUdp0Receive_Request_5 => pUdp0Receive_Request_5,
    pUdp0Receive_Ack_5     => pUdp0Receive_Ack_5,
    pUdp0Receive_Enable_5  => pUdp0Receive_Enable_5,
    pUdp1Receive_Data_5    => pUdp1Receive_Data_5,
    pUdp1Receive_Request_5 => pUdp1Receive_Request_5,
    pUdp1Receive_Ack_5     => pUdp1Receive_Ack_5,
    pUdp1Receive_Enable_5  => pUdp1Receive_Enable_5,

    MyIpAddr_6       => MyIpAddr_6,
    MyMacAddr_6      => MyMacAddr_6,
    MyNetMask_6      => MyNetMask_6,
    DefaultGateway_6 => DefaultGateway_6,
    TargetIPAddr_6   => TargetIPAddr_6,
    MyUdpPort_6_0    => MyUdpPort_6_0,
    MyUdpPort_6_1    => MyUdpPort_6_1,

    pUdp0Send_Data_6       => pUdp0Send_Data_6,
    pUdp0Send_Request_6    => pUdp0Send_Request_6,
    pUdp0Send_Ack_6        => pUdp0Send_Ack_6,
    pUdp0Send_Enable_6     => pUdp0Send_Enable_6,
    pUdp1Send_Data_6       => pUdp1Send_Data_6,
    pUdp1Send_Request_6    => pUdp1Send_Request_6,
    pUdp1Send_Ack_6        => pUdp1Send_Ack_6,
    pUdp1Send_Enable_6     => pUdp1Send_Enable_6,
    pUdp0Receive_Data_6    => pUdp0Receive_Data_6,
    pUdp0Receive_Request_6 => pUdp0Receive_Request_6,
    pUdp0Receive_Ack_6     => pUdp0Receive_Ack_6,
    pUdp0Receive_Enable_6  => pUdp0Receive_Enable_6,
    pUdp1Receive_Data_6    => pUdp1Receive_Data_6,
    pUdp1Receive_Request_6 => pUdp1Receive_Request_6,
    pUdp1Receive_Ack_6     => pUdp1Receive_Ack_6,
    pUdp1Receive_Enable_6  => pUdp1Receive_Enable_6,

    MyIpAddr_7       => MyIpAddr_7,
    MyMacAddr_7      => MyMacAddr_7,
    MyNetMask_7      => MyNetMask_7,
    DefaultGateway_7 => DefaultGateway_7,
    TargetIPAddr_7   => TargetIPAddr_7,
    MyUdpPort_7_0    => MyUdpPort_7_0,
    MyUdpPort_7_1    => MyUdpPort_7_1,

    pUdp0Send_Data_7       => pUdp0Send_Data_7,
    pUdp0Send_Request_7    => pUdp0Send_Request_7,
    pUdp0Send_Ack_7        => pUdp0Send_Ack_7,
    pUdp0Send_Enable_7     => pUdp0Send_Enable_7,
    pUdp1Send_Data_7       => pUdp1Send_Data_7,
    pUdp1Send_Request_7    => pUdp1Send_Request_7,
    pUdp1Send_Ack_7        => pUdp1Send_Ack_7,
    pUdp1Send_Enable_7     => pUdp1Send_Enable_7,
    pUdp0Receive_Data_7    => pUdp0Receive_Data_7,
    pUdp0Receive_Request_7 => pUdp0Receive_Request_7,
    pUdp0Receive_Ack_7     => pUdp0Receive_Ack_7,
    pUdp0Receive_Enable_7  => pUdp0Receive_Enable_7,
    pUdp1Receive_Data_7    => pUdp1Receive_Data_7,
    pUdp1Receive_Request_7 => pUdp1Receive_Request_7,
    pUdp1Receive_Ack_7     => pUdp1Receive_Ack_7,
    pUdp1Receive_Enable_7  => pUdp1Receive_Enable_7
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

  ila_0_i : ila_0 port map(
    clk       => clk250mhz,
    probe0    => global_clock_250mhz,
    probe1(0) => global_clock_clear,
    probe1(1) => global_clock_clear_d,
    probe1(2) => global_clock_clear_recv,
    probe2    => global_clock_set_value,
    probe3(0) => synch_sender_kick,
    probe4(0) => synch_sender_busy,
    probe5    => synch_target_addr,
    probe6    => synch_target_port
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
