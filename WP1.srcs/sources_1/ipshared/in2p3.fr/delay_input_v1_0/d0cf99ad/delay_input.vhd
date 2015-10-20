
 --
 -------------------------------------------------------------------------------
 -- Filename:        delay_input.vhd
 --
 -- Description:     
 --                  
 -- VHDL-Standard:   VHDL'93
 -------------------------------------------------------------------------------
 -- Structure:   
 --              delay_input.vhd
 --
 --
 -------------------------------------------------------------------------------
 -- Naming Conventions:
 --      active low signals:                     "*_n"
 --      clock signals:                          "clk", "clk_div#", "clk_#x" 
 --      reset signals:                          "rst", "rst_n" 
 --      generics:                               "C_*" 
 --      user defined types:                     "*_TYPE" 
 --      state machine next state:               "*_ns" 
 --      state machine current state:            "*_cs" 
 --      combinatorial signals:                  "*_com" 
 --      pipelined or register delay signals:    "*_d#" 
 --      counter signals:                        "*cnt*"
 --      clock enable signals:                   "*_ce" 
 --      internal version of output port         "*_i"
 --      device pins:                            "*_pin" 
 --      ports:                                  - Names begin with Uppercase 
 --      processes:                              "*_PROCESS" 
 --      component instantiations:               "<ENTITY_>I_<#|FUNC>
 -------------------------------------------------------------------------------
 
 library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
 
 library unisim;
   use unisim.vcomponents.all;
 
 entity delay_input is
   port (     
     REF_CLOCK    : in  std_logic;
     IO_RESET     : in  std_logic;
     IBUF_0_P     : in  std_logic_vector(12 downto 0); -- pos. ports for diff. in buffer
     IBUF_0_N     : in  std_logic_vector(12 downto 0); -- neg. ports for diff. in buffer
     IBUF_1_P     : in  std_logic_vector(12 downto 0); -- pos. ports for diff. in buffer
     IBUF_1_N     : in  std_logic_vector(12 downto 0); -- neg. ports for diff. in buffer
     
                  
     DDELAY_0     : out std_logic_vector(12 downto 0); --output dat with delay
     DDELAY_1     : out std_logic_vector(12 downto 0); --output dat with delay
     
    
     
     DELAY_LOCKED : out std_logic );
     
     
 end delay_input;
 
 architecture beh of delay_input is
   type matrice_2x13 is array (1 downto 0) of std_logic_vector(12 downto 0);
   signal inbuf          : matrice_2x13;
   signal outbuf         : matrice_2x13;
   signal ref_clock_bufg : std_logic;
 
 begin
 
 --********************************************************* 
 --               Input Buffer declaration
 --********************************************************* 
 
   gen_in_buffer : for i in 0 to 12 generate
     IBUFDS_0 : IBUFDS
       generic map ( DIFF_TERM  => FALSE,        -- Differential termination
                     IOSTANDARD => "LVDS_25")
       port map    ( I  => IBUF_0_P(i), 
                     IB => IBUF_0_N(i),
                     O  => INBUF(0)(i) );
                  
     IBUFDS_1 : IBUFDS
       generic map ( DIFF_TERM  => FALSE,        -- Differential termination
                     IOSTANDARD => "LVDS_25")
       port map    ( I  => IBUF_1_P(i), 
                     IB => IBUF_1_N(i),
                     O  => INBUF(1)(i) );
                  
     
   end generate;

 --******************************************************
 --          IDELAYCTRL is needed for calibration
 --******************************************************
 
 delayctrl : IDELAYCTRL
   port map ( RDY    => delay_locked,
--              REFCLK => ref_clock,
              REFCLK => ref_clock_bufg,
              RST    => IO_RESET );
 
  ref_clk_bufg : BUFG
    port map ( I => ref_clock,
               O => ref_clock_bufg );
                
 --******************************************************
 --             Instantiate the delay primitive
 --******************************************************

  gen_delaye2 : for j in 0 to 1 generate
    gen_del_chip : for i in 0 to 12 generate
      idelaye2_bus : IDELAYE2
        generic map ( CINVCTRL_SEL           => "FALSE",  -- TRUE, FALSE
                      DELAY_SRC              => "IDATAIN",-- IDATAIN, DATAIN
                      HIGH_PERFORMANCE_MODE  => "FALSE",  -- TRUE, FALSE
                      IDELAY_TYPE            => "FIXED",  -- FIXED, VARIABLE, or VAR_LOADABLE
                      IDELAY_VALUE           => 0,         -- 0 to 31   78ps step
                      REFCLK_FREQUENCY       => 200.0,
                      PIPE_SEL               => "FALSE",
                      SIGNAL_PATTERN         => "DATA")   -- CLOCK, DATA
        port map    ( DATAIN                 => '0',     -- Data from FPGA logic
                      C                      => '0',
                      CE                     => '0',
                      INC                    => '0',
                      IDATAIN                => inbuf(j)(i), -- Driven by IOB
                      DATAOUT                => outbuf(j)(i),
                      LD                     => '0',
                      REGRST                 => '0',
                      LDPIPEEN               => '0',
                      CNTVALUEIN             => "00000",
                      CNTVALUEOUT            => open,
                      CINVCTRL               => '0' );
      end generate gen_del_chip;
  end generate gen_delaye2;
  
  DDELAY_0 <= outbuf(0);
  DDELAY_1 <= outbuf(1);



end beh;
 
 