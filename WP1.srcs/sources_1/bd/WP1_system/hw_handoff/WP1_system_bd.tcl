
################################################################
# This is a generated script based on design: WP1_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source WP1_system_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:1.0 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name WP1_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: Twin_ADC_controller
proc create_hier_cell_Twin_ADC_controller { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Twin_ADC_controller() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI1

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 Op1
  create_bd_pin -dir I -from 0 -to 0 TRIG_IN
  create_bd_pin -dir O TRIG_OUT
  create_bd_pin -dir I -from 25 -to 0 adc0
  create_bd_pin -dir I -from 25 -to 0 adc1
  create_bd_pin -dir I -from 0 -to 0 -type rst s00_axi_aresetn
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn
  create_bd_pin -dir I -from 1 -to 0 sw_service

  # Create instance: Interface_ADC_0, and set properties
  set Interface_ADC_0 [ create_bd_cell -type ip -vlnv le.infn.it:user:ADC_interface:1.0 Interface_ADC_0 ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_0

  # Create instance: axi_bram_ctrl_1, and set properties
  set axi_bram_ctrl_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_1 ]
  set_property -dict [ list CONFIG.SINGLE_PORT_BRAM {1}  ] $axi_bram_ctrl_1

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_0 ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM}  ] $blk_mem_gen_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 blk_mem_gen_1 ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM}  ] $blk_mem_gen_1

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list CONFIG.C_OPERATION {not} CONFIG.C_SIZE {1}  ] $util_vector_logic_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB]
  connect_bd_intf_net -intf_net axi_bram_ctrl_1_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_1/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTB]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins Interface_ADC_0/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins S_AXI1] [get_bd_intf_pins axi_bram_ctrl_1/S_AXI]

  # Create port connections
  connect_bd_net -net Interface_ADC_0_ADC0_mem [get_bd_pins Interface_ADC_0/ADC0_mem] [get_bd_pins blk_mem_gen_0/dina]
  connect_bd_net -net Interface_ADC_0_ADC1_mem [get_bd_pins Interface_ADC_0/ADC1_mem] [get_bd_pins blk_mem_gen_1/dina]
  connect_bd_net -net Interface_ADC_0_ADDR_mem [get_bd_pins Interface_ADC_0/ADDR_mem] [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins blk_mem_gen_1/addra]
  connect_bd_net -net Interface_ADC_0_TRIG_OUT [get_bd_pins TRIG_OUT] [get_bd_pins Interface_ADC_0/TRIG_OUT]
  connect_bd_net -net Interface_ADC_0_enable [get_bd_pins Interface_ADC_0/enable] [get_bd_pins blk_mem_gen_0/ena] [get_bd_pins blk_mem_gen_1/ena]
  connect_bd_net -net Interface_ADC_0_wea [get_bd_pins Interface_ADC_0/wea] [get_bd_pins blk_mem_gen_0/wea] [get_bd_pins blk_mem_gen_1/wea]
  connect_bd_net -net SW_SERVICE_1 [get_bd_pins sw_service] [get_bd_pins Interface_ADC_0/sw_service]
  connect_bd_net -net TRIG_IN_1 [get_bd_pins TRIG_IN] [get_bd_pins Interface_ADC_0/TRIG_IN]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins Op1] [get_bd_pins Interface_ADC_0/ADC_CK] [get_bd_pins Interface_ADC_0/FPGA_CK] [get_bd_pins Interface_ADC_0/s00_axi_aclk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_bram_ctrl_1/s_axi_aclk] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_bram_ctrl_1/s_axi_aresetn] [get_bd_pins blk_mem_gen_0/rsta] [get_bd_pins blk_mem_gen_1/rsta]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins adc1] [get_bd_pins Interface_ADC_0/adc1]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins adc0] [get_bd_pins Interface_ADC_0/adc0]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_1/clka] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins s00_axi_aresetn] [get_bd_pins Interface_ADC_0/s00_axi_aresetn]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set leds_8bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 leds_8bits ]

  # Create ports
  set ADC0_N [ create_bd_port -dir I -from 0 -to 12 ADC0_N ]
  set ADC0_P [ create_bd_port -dir I -from 0 -to 12 ADC0_P ]
  set ADC1_N [ create_bd_port -dir I -from 0 -to 12 ADC1_N ]
  set ADC1_P [ create_bd_port -dir I -from 0 -to 12 ADC1_P ]
  set SPI1_MISO [ create_bd_port -dir I SPI1_MISO ]
  set SPI1_MOSI [ create_bd_port -dir O SPI1_MOSI ]
  set SPI1_SCLK [ create_bd_port -dir O SPI1_SCLK ]
  set SPI1_SS1 [ create_bd_port -dir O SPI1_SS1 ]
  set SPI1_SS2 [ create_bd_port -dir O SPI1_SS2 ]
  set SW_SERVICE [ create_bd_port -dir I -from 1 -to 0 SW_SERVICE ]
  set TRIGGER_out [ create_bd_port -dir O TRIGGER_out ]
  set TRIG_IN [ create_bd_port -dir I TRIG_IN ]
  set UART0_RX [ create_bd_port -dir I UART0_RX ]
  set UART0_TX [ create_bd_port -dir O UART0_TX ]
  set adc_clk_N [ create_bd_port -dir O -from 0 -to 0 adc_clk_N ]
  set adc_clk_P [ create_bd_port -dir O -from 0 -to 0 adc_clk_P ]

  # Create instance: Twin_ADC_controller
  create_hier_cell_Twin_ADC_controller [current_bd_instance .] Twin_ADC_controller

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list CONFIG.C_INTERRUPT_PRESENT {0} CONFIG.C_IS_DUAL {0} CONFIG.GPIO2_BOARD_INTERFACE {Custom} CONFIG.GPIO_BOARD_INTERFACE {leds_8bits} CONFIG.USE_BOARD_FLOW {true}  ] $axi_gpio_0

  # Create instance: delay_input_0, and set properties
  set delay_input_0 [ create_bd_cell -type ip -vlnv in2p3.fr:user:delay_input:1.0 delay_input_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {125} CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} CONFIG.PCW_I2C0_I2C0_IO {MIO 14 .. 15} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} CONFIG.PCW_I2C0_RESET_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_IO {<Select>} CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_MIO_14_PULLUP {enabled} CONFIG.PCW_MIO_15_PULLUP {enabled} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 3.3V} CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {1} CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART0_UART0_IO {EMIO} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} CONFIG.preset {ZedBoard} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list CONFIG.ENABLE_ADVANCED_OPTIONS {1} CONFIG.NUM_MI {5} CONFIG.STRATEGY {2}  ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create instance: selectio_wiz_0, and set properties
  set selectio_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_0 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_0

  # Create instance: selectio_wiz_1, and set properties
  set selectio_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:selectio_wiz:5.1 selectio_wiz_1 ]
  set_property -dict [ list CONFIG.BUS_IO_STD {LVCMOS25} CONFIG.SELIO_ACTIVE_EDGE {DDR} CONFIG.SELIO_BUS_IN_DELAY {NONE} CONFIG.SELIO_CLK_BUF {MMCM} CONFIG.SYSTEM_DATA_WIDTH {13}  ] $selectio_wiz_1

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:1.0 util_ds_buf_0 ]
  set_property -dict [ list CONFIG.C_BUF_TYPE {OBUFDS}  ] $util_ds_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports leds_8bits] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins Twin_ADC_controller/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins Twin_ADC_controller/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins Twin_ADC_controller/S_AXI1] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]

  # Create port connections
  connect_bd_net -net ADC0_N_1 [get_bd_ports ADC0_N] [get_bd_pins delay_input_0/IBUF_0_N]
  connect_bd_net -net ADC0_P_1 [get_bd_ports ADC0_P] [get_bd_pins delay_input_0/IBUF_0_P]
  connect_bd_net -net ADC1_N_1 [get_bd_ports ADC1_N] [get_bd_pins delay_input_0/IBUF_1_N]
  connect_bd_net -net ADC1_P_1 [get_bd_ports ADC1_P] [get_bd_pins delay_input_0/IBUF_1_P]
  connect_bd_net -net Interface_ADC_0_TRIG_OUT [get_bd_ports TRIGGER_out] [get_bd_pins Twin_ADC_controller/TRIG_OUT]
  connect_bd_net -net SPI1_MISO_1 [get_bd_ports SPI1_MISO] [get_bd_pins processing_system7_0/SPI1_MISO_I]
  connect_bd_net -net SW_SERVICE_1 [get_bd_ports SW_SERVICE] [get_bd_pins Twin_ADC_controller/sw_service]
  connect_bd_net -net TRIG_IN_1 [get_bd_ports TRIG_IN] [get_bd_pins Twin_ADC_controller/TRIG_IN]
  connect_bd_net -net UART0_RX_1 [get_bd_ports UART0_RX] [get_bd_pins processing_system7_0/UART0_RX]
  connect_bd_net -net delay_input_0_DDELAY_0 [get_bd_pins delay_input_0/DDELAY_0] [get_bd_pins selectio_wiz_1/data_in_from_pins]
  connect_bd_net -net delay_input_0_DDELAY_1 [get_bd_pins delay_input_0/DDELAY_1] [get_bd_pins selectio_wiz_0/data_in_from_pins]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins Twin_ADC_controller/Op1] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk] [get_bd_pins selectio_wiz_0/clk_in] [get_bd_pins selectio_wiz_1/clk_in] [get_bd_pins util_ds_buf_0/OBUF_IN]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins delay_input_0/REF_CLOCK] [get_bd_pins processing_system7_0/FCLK_CLK1]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net processing_system7_0_SPI1_MOSI_O [get_bd_ports SPI1_MOSI] [get_bd_pins processing_system7_0/SPI1_MOSI_O]
  connect_bd_net -net processing_system7_0_SPI1_SCLK_O [get_bd_ports SPI1_SCLK] [get_bd_pins processing_system7_0/SPI1_SCLK_O]
  connect_bd_net -net processing_system7_0_SPI1_SS1_O [get_bd_ports SPI1_SS2] [get_bd_pins processing_system7_0/SPI1_SS1_O]
  connect_bd_net -net processing_system7_0_SPI1_SS_O [get_bd_ports SPI1_SS1] [get_bd_pins processing_system7_0/SPI1_SS_O]
  connect_bd_net -net processing_system7_0_UART0_TX [get_bd_ports UART0_TX] [get_bd_pins processing_system7_0/UART0_TX]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins Twin_ADC_controller/s00_axi_aresetn] [get_bd_pins Twin_ADC_controller/s_axi_aresetn] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_reset [get_bd_pins delay_input_0/IO_RESET] [get_bd_pins rst_processing_system7_0_100M/peripheral_reset] [get_bd_pins selectio_wiz_0/io_reset] [get_bd_pins selectio_wiz_1/io_reset]
  connect_bd_net -net selectio_wiz_0_data_in_to_device [get_bd_pins Twin_ADC_controller/adc1] [get_bd_pins selectio_wiz_0/data_in_to_device]
  connect_bd_net -net selectio_wiz_1_data_in_to_device [get_bd_pins Twin_ADC_controller/adc0] [get_bd_pins selectio_wiz_1/data_in_to_device]
  connect_bd_net -net util_ds_buf_0_OBUF_DS_N [get_bd_ports adc_clk_N] [get_bd_pins util_ds_buf_0/OBUF_DS_N]
  connect_bd_net -net util_ds_buf_0_OBUF_DS_P [get_bd_ports adc_clk_P] [get_bd_pins util_ds_buf_0/OBUF_DS_P]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins processing_system7_0/SPI1_SS_I] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x1000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Twin_ADC_controller/Interface_ADC_0/S00_AXI/S00_AXI_reg] SEG_Interface_ADC_0_S00_AXI_reg
  create_bd_addr_seg -range 0x4000 -offset 0x40000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Twin_ADC_controller/axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x4000 -offset 0x40010000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs Twin_ADC_controller/axi_bram_ctrl_1/S_AXI/Mem0] SEG_axi_bram_ctrl_1_Mem0
  create_bd_addr_seg -range 0x1000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


