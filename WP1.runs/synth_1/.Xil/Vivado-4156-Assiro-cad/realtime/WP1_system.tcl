# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    set ::env(RT_TMP) "./.Xil/Vivado-4156-Assiro-cad/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7z020clg484-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    # Skipping read_* RTL commands because this is post-elab optimize flow
    set rt::useElabCache true
    if {$rt::useElabCache == false} {
      rt::read_verilog -include {
    c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_processing_system7_0_0
    c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_infrastructure_v1_1/cf21a66f/hdl/verilog
  } {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/processing_system7_v5_5/ad955ff5/hdl/verilog/processing_system7_v5_5_aw_atc.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/processing_system7_v5_5/ad955ff5/hdl/verilog/processing_system7_v5_5_b_atc.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/processing_system7_v5_5/ad955ff5/hdl/verilog/processing_system7_v5_5_w_atc.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/processing_system7_v5_5/ad955ff5/hdl/verilog/processing_system7_v5_5_atc.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/processing_system7_v5_5/ad955ff5/hdl/verilog/processing_system7_v5_5_trace_buffer.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_processing_system7_0_0/hdl/verilog/processing_system7_v5_5_processing_system7.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_processing_system7_0_0/synth/WP1_system_processing_system7_0_0.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_carry_and.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_carry_or.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_carry.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_comparator.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_mux.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/generic_baseblocks_v2_1/da89d453/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_infrastructure_v1_1/cf21a66f/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_infrastructure_v1_1/cf21a66f/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_infrastructure_v1_1/cf21a66f/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_register_slice_v2_1/03a8e0ba/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_register_slice_v2_1/03a8e0ba/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_data_fifo_v2_1/82d298e6/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_crossbar.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_si_transactor.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_splitter.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_wdata_router.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_crossbar_v2_1/9368eebf/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_xbar_0/synth/WP1_system_xbar_0.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_s00_data_fifo_0_1/synth/WP1_system_s00_data_fifo_0.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_b2s.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_protocol_converter_v2_1/017861a2/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_auto_pc_0/synth/WP1_system_auto_pc_0.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_auto_pc_1_1/synth/WP1_system_auto_pc_1.v
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_auto_pc_2/synth/WP1_system_auto_pc_2.v
    }
      rt::read_vhdl -lib axi_lite_ipif_v3_0 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_lite_ipif_v3_0/876b8fe4/hdl/src/vhdl/ipif_pkg.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_lite_ipif_v3_0/876b8fe4/hdl/src/vhdl/pselect_f.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_lite_ipif_v3_0/876b8fe4/hdl/src/vhdl/address_decoder.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_lite_ipif_v3_0/876b8fe4/hdl/src/vhdl/slave_attachment.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_lite_ipif_v3_0/876b8fe4/hdl/src/vhdl/axi_lite_ipif.vhd
    }
      rt::read_vhdl -lib lib_cdc_v1_0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/lib_cdc_v1_0/ea79928f/hdl/src/vhdl/cdc_sync.vhd
      rt::read_vhdl -lib interrupt_control_v3_1 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/interrupt_control_v3_1/dd9a9dbd/hdl/src/vhdl/interrupt_control.vhd
      rt::read_vhdl -lib axi_gpio_v2_0 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_gpio_v2_0/e416c384/hdl/src/vhdl/gpio_core.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_gpio_v2_0/e416c384/hdl/src/vhdl/axi_gpio.vhd
    }
      rt::read_vhdl -lib xil_defaultlib {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_gpio_0_0/synth/WP1_system_axi_gpio_0_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_rst_processing_system7_0_100M_0/synth/WP1_system_rst_processing_system7_0_100M_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_util_ds_buf_0_0/synth/WP1_system_util_ds_buf_0_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_0_0/WP1_system_selectio_wiz_0_0_selectio_wiz.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_0_0/WP1_system_selectio_wiz_0_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/xlconstant_v1_1/36911fd5/xlconstant.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_xlconstant_0_0/sim/WP1_system_xlconstant_0_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_1_0/WP1_system_selectio_wiz_1_0_selectio_wiz.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_1_0/WP1_system_selectio_wiz_1_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_util_vector_logic_0_0/synth/WP1_system_util_vector_logic_0_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/le.infn.it/adc_interface_v1_0/2d75957a/src/test_uub.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/le.infn.it/adc_interface_v1_0/2d75957a/src/Interface_uub_v1_0_S00_AXI.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/le.infn.it/adc_interface_v1_0/2d75957a/hdl/Interface_uub_v1_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_Interface_ADC_0_2/synth/WP1_system_Interface_ADC_0_2.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/in2p3.fr/delay_input_v1_0/d0cf99ad/delay_input.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_delay_input_0_1/synth/WP1_system_delay_input_0_1.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_blk_mem_gen_0_2/synth/WP1_system_blk_mem_gen_0_2.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_bram_ctrl_0_1/synth/WP1_system_axi_bram_ctrl_0_1.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_bram_ctrl_1_0/synth/WP1_system_axi_bram_ctrl_1_0.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_blk_mem_gen_1_0/synth/WP1_system_blk_mem_gen_1_0.vhd
      C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/hdl/WP1_system.vhd
    }
      rt::read_vhdl -lib proc_sys_reset_v5_0 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/proc_sys_reset_v5_0/066de7cd/hdl/src/vhdl/upcnt_n.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/proc_sys_reset_v5_0/066de7cd/hdl/src/vhdl/sequence.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/proc_sys_reset_v5_0/066de7cd/hdl/src/vhdl/lpf.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/proc_sys_reset_v5_0/066de7cd/hdl/src/vhdl/proc_sys_reset.vhd
    }
      rt::read_vhdl -lib util_ds_buf_v1_01_a c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/util_ds_buf_v1_0/86bade70/hdl/vhdl/util_ds_buf.vhd
      rt::read_vhdl -lib util_vector_logic_v2_0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/util_vector_logic_v2_0/5ac42227/hdl/util_vector_logic.vhd
      rt::read_vhdl -lib blk_mem_gen_v8_2 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/blk_mem_gen_v8_2/7b054ed9/hdl/blk_mem_gen_v8_2_vhsyn_rfs.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/blk_mem_gen_v8_2/7b054ed9/hdl/blk_mem_gen_v8_2.vhd
    }
      rt::read_vhdl -lib axi_bram_ctrl_v4_0 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/srl_fifo.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/axi_bram_ctrl_funcs.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/coregen_comp_defs.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/axi_lite_if.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/checkbit_handler_64.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/checkbit_handler.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/correct_one_bit_64.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/correct_one_bit.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/xor18.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/parity.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/ecc_gen.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/lite_ecc_reg.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/axi_lite.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/sng_port_arb.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/ua_narrow.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/wrap_brst.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/rd_chnl.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/wr_chnl.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/full_axi.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/axi_bram_ctrl_top.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/axi_bram_ctrl_v4_0/3dec2f5b/hdl/vhdl/axi_bram_ctrl.vhd
    }
      rt::read_vhdl -lib fifo_generator_v12_0 {
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/fifo_generator_v12_0/15467f24/hdl/fifo_generator_v12_0_vhsyn_rfs.vhd
      c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/ipshared/xilinx.com/fifo_generator_v12_0/15467f24/hdl/fifo_generator_v12_0.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification true
    set rt::SDCFileList ./.Xil/Vivado-4156-Assiro-cad/realtime/WP1_system_synth.xdc
    rt::sdcChecksum
    set rt::top WP1_system
    set rt::reportTiming false
    rt::set_parameter elaborateOnly false
    rt::set_parameter elaborateRtl false
    rt::set_parameter eliminateRedundantBitOperator true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter ramStyle auto
    rt::set_parameter merge_flipflops true
    rt::set_parameter webTalkPath {C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.cache/wt}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-4156-Assiro-cad/"
    if {$rt::useElabCache == false} {
      rt::run_synthesis -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    rt::HARTNDb_reportJobStats "Synthesis Optimization Runtime"
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
