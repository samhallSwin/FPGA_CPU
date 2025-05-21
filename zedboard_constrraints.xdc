# Clock Input (GCLK)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Reset Button (BTNC)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]

# Run signal (SW0)
set_property PACKAGE_PIN T18 [get_ports cpu_run]
set_property IOSTANDARD LVCMOS18 [get_ports cpu_run]

# Write Enable (SW1)
set_property PACKAGE_PIN R16 [get_ports write_enable]
set_property IOSTANDARD LVCMOS18 [get_ports write_enable]

# Write Address (SW0 to SW7)
set_property PACKAGE_PIN F22 [get_ports write_addr[0]];  # "SW0"
set_property PACKAGE_PIN G22 [get_ports write_addr[1]];  # "SW1"
set_property PACKAGE_PIN H22 [get_ports write_addr[2]];  # "SW2"
set_property PACKAGE_PIN F21 [get_ports write_addr[3]];  # "SW3"
set_property PACKAGE_PIN H19 [get_ports write_addr[4]];  # "SW4"
set_property PACKAGE_PIN H18 [get_ports write_addr[5]];  # "SW5"
set_property PACKAGE_PIN H17 [get_ports write_addr[6]];  # "SW6"
set_property PACKAGE_PIN M15 [get_ports write_addr[7]];  # "SW7"

# Byte Select (2-bit input from JC Pmod)
set_property PACKAGE_PIN AB6   [get_ports byte_select[0]]
set_property PACKAGE_PIN AB7   [get_ports byte_select[1]]

# Write Data (8-bit input from JA Pmod)
set_property PACKAGE_PIN Y11 [get_ports write_data[0]]
set_property PACKAGE_PIN AA8 [get_ports write_data[1]]
set_property PACKAGE_PIN AA11  [get_ports write_data[2]]
set_property PACKAGE_PIN Y10  [get_ports write_data[3]]
set_property PACKAGE_PIN AA9  [get_ports write_data[4]]
set_property PACKAGE_PIN AB11  [get_ports write_data[5]]
set_property PACKAGE_PIN AB10   [get_ports write_data[6]]
set_property PACKAGE_PIN AB9  [get_ports write_data[7]]

# Data Output (to LEDs LD0–LD7)
set_property PACKAGE_PIN T22 [get_ports data_out[0]]
set_property PACKAGE_PIN T21 [get_ports data_out[1]]
set_property PACKAGE_PIN U22 [get_ports data_out[2]]
set_property PACKAGE_PIN U21 [get_ports data_out[3]]
set_property PACKAGE_PIN V22 [get_ports data_out[4]]
set_property PACKAGE_PIN W22 [get_ports data_out[5]]
set_property PACKAGE_PIN U19 [get_ports data_out[6]]
set_property PACKAGE_PIN U14 [get_ports data_out[7]]

# Data in (PMOD B)
set_property PACKAGE_PIN W12 [get_ports data_in[0]];  # "JB1"
set_property PACKAGE_PIN W11 [get_ports data_in[1]];  # "JB2"
set_property PACKAGE_PIN V10 [get_ports data_in[2]];  # "JB3"
set_property PACKAGE_PIN W8  [get_ports data_in[3]];  # "JB4"
set_property PACKAGE_PIN V12 [get_ports data_in[4]];  # "JB7"
set_property PACKAGE_PIN W10 [get_ports data_in[5]];  # "JB8"
set_property PACKAGE_PIN V9  [get_ports data_in[6]];  # "JB9"
set_property PACKAGE_PIN V8  [get_ports data_in[7]];  # "JB10"

