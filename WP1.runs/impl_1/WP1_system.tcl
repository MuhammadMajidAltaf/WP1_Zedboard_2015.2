proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7z020clg484-1
  set_property board_part em.avnet.com:zed:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.cache/wt [current_project]
  set_property parent.project_path C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.xpr [current_project]
  set_property ip_repo_paths {
  c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.cache/ip
  C:/Xilinx/Vivado/2014.2/progetti/ip_repo
  C:/Xilinx/Vivado/2014.2/progetti/WP1/ip_repo
} [current_project]
  set_property ip_output_repo c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.cache/ip [current_project]
  add_files -quiet C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.runs/synth_1/WP1_system.dcp
  add_files C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/WP1_system.bmm
  set_property SCOPED_TO_REF WP1_system [get_files -all C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/WP1_system.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/WP1_system.bmm]
  read_xdc -ref WP1_system_processing_system7_0_0 -cells inst c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_processing_system7_0_0/WP1_system_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_processing_system7_0_0/WP1_system_processing_system7_0_0.xdc]
  read_xdc -prop_thru_buffers -ref WP1_system_axi_gpio_0_0 -cells U0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_gpio_0_0/WP1_system_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_gpio_0_0/WP1_system_axi_gpio_0_0_board.xdc]
  read_xdc -ref WP1_system_axi_gpio_0_0 -cells U0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_gpio_0_0/WP1_system_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_axi_gpio_0_0/WP1_system_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref WP1_system_rst_processing_system7_0_100M_0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_rst_processing_system7_0_100M_0/WP1_system_rst_processing_system7_0_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_rst_processing_system7_0_100M_0/WP1_system_rst_processing_system7_0_100M_0_board.xdc]
  read_xdc -ref WP1_system_rst_processing_system7_0_100M_0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_rst_processing_system7_0_100M_0/WP1_system_rst_processing_system7_0_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_rst_processing_system7_0_100M_0/WP1_system_rst_processing_system7_0_100M_0.xdc]
  read_xdc -ref WP1_system_selectio_wiz_0_0 -cells U0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_0_0/WP1_system_selectio_wiz_0_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_0_0/WP1_system_selectio_wiz_0_0.xdc]
  read_xdc -ref WP1_system_selectio_wiz_1_0 -cells U0 c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_1_0/WP1_system_selectio_wiz_1_0.xdc
  set_property processing_order EARLY [get_files c:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/ip/WP1_system_selectio_wiz_1_0/WP1_system_selectio_wiz_1_0.xdc]
  read_xdc -mode out_of_context -ref WP1_system C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/sources_1/bd/WP1_system/WP1_system_ooc.xdc
  read_xdc C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/constrs_1/imports/WP1/roberto_constraints.xdc
  read_xdc C:/Xilinx/Vivado/2015.2/progetti/WP1/WP1.srcs/constrs_1/new/migrated_io_properties.xdc
  link_design -top WP1_system -part xc7z020clg484-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force WP1_system_opt.dcp
  catch {report_drc -file WP1_system_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file WP1_system.hwdef}
  place_design 
  write_checkpoint -force WP1_system_placed.dcp
  catch { report_io -file WP1_system_io_placed.rpt }
  catch { report_utilization -file WP1_system_utilization_placed.rpt -pb WP1_system_utilization_placed.pb }
  catch { report_control_sets -verbose -file WP1_system_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force WP1_system_routed.dcp
  catch { report_drc -file WP1_system_drc_routed.rpt -pb WP1_system_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file WP1_system_timing_summary_routed.rpt -rpx WP1_system_timing_summary_routed.rpx }
  catch { report_power -file WP1_system_power_routed.rpt -pb WP1_system_power_summary_routed.pb }
  catch { report_route_status -file WP1_system_route_status.rpt -pb WP1_system_route_status.pb }
  catch { report_clock_utilization -file WP1_system_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force WP1_system.mmi }
  catch { write_bmm -force WP1_system_bd.bmm }
  write_bitstream -force WP1_system.bit 
  catch { write_sysdef -hwdef WP1_system.hwdef -bitfile WP1_system.bit -meminfo WP1_system.mmi -ltxfile debug_nets.ltx -file WP1_system.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

