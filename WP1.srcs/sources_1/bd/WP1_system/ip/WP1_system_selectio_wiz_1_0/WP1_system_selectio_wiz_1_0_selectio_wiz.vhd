
-- file: WP1_system_selectio_wiz_1_0_selectio_wiz.vhd
-- (c) Copyright 2009 - 2013 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------------
-- User entered comments
------------------------------------------------------------------------------
-- None
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity WP1_system_selectio_wiz_1_0_selectio_wiz is
generic
 (-- width of the data for the system
  SYS_W       : integer := 13;
  -- width of the data for the device
  DEV_W       : integer := 26);
port
 (
  -- From the system into the device
  data_in_from_pins       : in    std_logic_vector(SYS_W-1 downto 0);
  data_in_to_device       : out   std_logic_vector(DEV_W-1 downto 0);

 
-- Clock and reset signals
  clk_in                  : in    std_logic;                    -- Fast clock from PLL/MMCM 
  io_reset                : in    std_logic);                   -- Reset signal for IO circuit
end WP1_system_selectio_wiz_1_0_selectio_wiz;

architecture xilinx of WP1_system_selectio_wiz_1_0_selectio_wiz is
  constant clock_enable            : std_logic := '1';
  signal unused : std_logic;
  signal clk_in_int_buf            : std_logic;
  signal clk_gclk_in_int           : std_logic;


  -- After the buffer
  signal data_in_from_pins_int     : std_logic_vector(SYS_W-1 downto 0);
  -- Between the delay and serdes
  signal data_in_from_pins_delay   : std_logic_vector(SYS_W-1 downto 0);
  signal ce_in_uc          : std_logic;
  signal inc_in_uc         : std_logic;
  signal regrst_in_uc      : std_logic;
  signal ce_out_uc              : std_logic;
  signal inc_out_uc             : std_logic;
  signal regrst_out_uc          : std_logic;


begin




  -- Create the clock logic
   clk_in_int_buf <= clk_in;

  
  -- We have multiple bits- step over every bit, instantiating the required elements
  pins: for pin_count in 0 to SYS_W-1 generate
  begin
    -- Instantiate the buffers
    ----------------------------------
    -- Instantiate a buffer for every bit of the data bus
     ibuf_inst : IBUF
       generic map (
         IOSTANDARD => "LVCMOS25")
       port map (     
         I          => data_in_from_pins    (pin_count),
         O          => data_in_from_pins_int(pin_count));


    -- Pass through the delay
    -----------------------------------
   data_in_from_pins_delay(pin_count) <= data_in_from_pins_int(pin_count);

    -- Connect the delayed data to the fabric
    ------------------------------------------
   -- DDR register instantation
    iddr_inst : IDDR
      generic map (
        INIT_Q1        => '0',
        INIT_Q2        => '0',
        DDR_CLK_EDGE   => "SAME_EDGE_PIPELINED", --"SAME_EDGE", "OPPOSITE_EDGE", "SAME_EDGE", "SAME_EDGE_PIPELINED"
       SRTYPE         => "ASYNC")
      port map
       (Q1             => data_in_to_device(pin_count),
        Q2             => data_in_to_device(SYS_W + pin_count),
        C              => clk_in_int_buf,
        CE             => clock_enable,
        D              => data_in_from_pins_delay(pin_count),
        R              => io_reset,
        S              => '0');

  end generate pins;





end xilinx;



