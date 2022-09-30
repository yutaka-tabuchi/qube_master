REM ##############################################################
REM # Set version and path as your installed Vivado or Vivado_Lab
REM ##############################################################
CALL C:\Xilinx\Vivado_Lab\2022.1\settings64.bat

echo on

vivado_lab -mode batch -source program_mcs.tcl

PAUSE
