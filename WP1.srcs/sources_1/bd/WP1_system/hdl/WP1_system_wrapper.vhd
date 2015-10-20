--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.2 (win64) Build 1266856 Fri Jun 26 16:35:25 MDT 2015
--Date        : Tue Oct 20 17:19:30 2015
--Host        : Assiro-cad running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target WP1_system_wrapper.bd
--Design      : WP1_system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity WP1_system_wrapper is
  port (
    ADC0_N : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC0_P : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC1_N : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC1_P : in STD_LOGIC_VECTOR ( 0 to 12 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    SPI1_MISO : in STD_LOGIC;
    SPI1_MOSI : out STD_LOGIC;
    SPI1_SCLK : out STD_LOGIC;
    SPI1_SS1 : out STD_LOGIC;
    SPI1_SS2 : out STD_LOGIC;
    SW_SERVICE : in STD_LOGIC_VECTOR ( 1 downto 0 );
    TRIGGER_out : out STD_LOGIC;
    TRIG_IN : in STD_LOGIC;
    UART0_RX : in STD_LOGIC;
    UART0_TX : out STD_LOGIC;
    adc_clk_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    adc_clk_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    leds_8bits_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
end WP1_system_wrapper;

architecture STRUCTURE of WP1_system_wrapper is
  component WP1_system is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    leds_8bits_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    adc_clk_P : out STD_LOGIC_VECTOR ( 0 to 0 );
    adc_clk_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    SPI1_SCLK : out STD_LOGIC;
    SPI1_MOSI : out STD_LOGIC;
    SPI1_MISO : in STD_LOGIC;
    SPI1_SS1 : out STD_LOGIC;
    SPI1_SS2 : out STD_LOGIC;
    TRIGGER_out : out STD_LOGIC;
    ADC0_P : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC0_N : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC1_P : in STD_LOGIC_VECTOR ( 0 to 12 );
    ADC1_N : in STD_LOGIC_VECTOR ( 0 to 12 );
    SW_SERVICE : in STD_LOGIC_VECTOR ( 1 downto 0 );
    UART0_TX : out STD_LOGIC;
    UART0_RX : in STD_LOGIC;
    TRIG_IN : in STD_LOGIC
  );
  end component WP1_system;
begin
WP1_system_i: component WP1_system
     port map (
      ADC0_N(0 to 12) => ADC0_N(0 to 12),
      ADC0_P(0 to 12) => ADC0_P(0 to 12),
      ADC1_N(0 to 12) => ADC1_N(0 to 12),
      ADC1_P(0 to 12) => ADC1_P(0 to 12),
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      SPI1_MISO => SPI1_MISO,
      SPI1_MOSI => SPI1_MOSI,
      SPI1_SCLK => SPI1_SCLK,
      SPI1_SS1 => SPI1_SS1,
      SPI1_SS2 => SPI1_SS2,
      SW_SERVICE(1 downto 0) => SW_SERVICE(1 downto 0),
      TRIGGER_out => TRIGGER_out,
      TRIG_IN => TRIG_IN,
      UART0_RX => UART0_RX,
      UART0_TX => UART0_TX,
      adc_clk_N(0) => adc_clk_N(0),
      adc_clk_P(0) => adc_clk_P(0),
      leds_8bits_tri_o(7 downto 0) => leds_8bits_tri_o(7 downto 0)
    );
end STRUCTURE;
