 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Interface_uub_v1_0_S00_AXI is
  generic (
    -- Users to add parameters here
    
    -- User parameters ends
    -- Do not modify the parameters beyond this line

    C_S_AXI_DATA_WIDTH  : integer := 32;  -- Width of S_AXI data bus
    C_S_AXI_ADDR_WIDTH  : integer := 6 ); -- Width of S_AXI address bus
  port (
    -- Users to add ports here
      -- Interface ADC AD9628 (CLK)
         ADC_CK    : in  std_logic;
     -- Interface Horloge
         FPGA_CK   : in  std_logic;
      -- Interface ADC AD9628 (Datas)
         adc0      : in  std_logic_vector(25 downto 0);
         adc1      : in  std_logic_vector(25 downto 0);


           -- Interface bus to bram
         ADC0_mem            : out  std_logic_vector(31 downto 0);
         ADC1_mem            : out  std_logic_vector(31 downto 0);
         
         ADDR_mem            : out  std_logic_vector(31 downto 0);
         enable            : out  std_logic;
         wea               : out  std_logic_vector(3 downto 0);
         sw_service          : in  std_logic_vector(1 downto 0);
           
      -- Interface Trigger
         TRIG_IN   : in  std_logic;
         TRIG_OUT  : out std_logic;

    -- User ports ends
    -- Do not modify the ports beyond this line

    S_AXI_ACLK    : in std_logic; -- Global Clock Signal   
    S_AXI_ARESETN : in std_logic; -- Global Reset Signal, Active LOW
    -- Write address (issued by master, acceped by Slave)
    S_AXI_AWADDR  : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    -- Write channel Protection type. This signal indicates the privilege and
    -- security level of the transaction, and whether the transaction is a 
    -- data access or an instruction access.
    S_AXI_AWPROT  : in std_logic_vector(2 downto 0);
    -- Write address valid. This signal indicates that the master signaling
    -- valid write address and control information.
    S_AXI_AWVALID : in std_logic;
    -- Write address ready. This signal indicates that the slave is ready
    -- to accept an address and associated control signals.
    S_AXI_AWREADY : out std_logic;
    -- Write data (issued by master, acceped by Slave) 
    S_AXI_WDATA : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    -- Write strobes. This signal indicates which byte lanes hold valid data.
    -- There is one write strobe bit for each eight bits of the write data bus.    
    S_AXI_WSTRB : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
    -- Write valid. Indicates that valid write data and strobes are available.
    S_AXI_WVALID  : in std_logic;
    -- Write ready. Indicates that the slave can accept the write data.
    S_AXI_WREADY  : out std_logic;
    -- Write response. Indicates the status of the write transaction.
    S_AXI_BRESP : out std_logic_vector(1 downto 0);
    -- Write response valid. Indicates that the channel is signaling a valid 
    -- write response.
    S_AXI_BVALID  : out std_logic;
    -- Response ready. Indicates that the master can accept a write response.
    S_AXI_BREADY  : in std_logic;
    -- Read address (issued by master, acceped by Slave)
    S_AXI_ARADDR  : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
    -- Protection type. Indicates the privilege and security level of the
    -- transaction, and whether the transaction is a data access or an 
    -- instruction access.
    S_AXI_ARPROT  : in std_logic_vector(2 downto 0);
    -- Read address valid. This signal indicates that the channelis signaling
    -- valid read address and control information.
    S_AXI_ARVALID : in std_logic;
    -- Read address ready. This signal indicates that the slave is ready to
    -- accept an address and associated control signals.
    S_AXI_ARREADY : out std_logic;
    -- Read data (issued by slave)
    S_AXI_RDATA : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
    -- Read response. This signal indicates the status of the read transfer.
    S_AXI_RRESP : out std_logic_vector(1 downto 0);
    -- Read valid. This signal indicates that the channel is signaling the
    -- required read data.
    S_AXI_RVALID  : out std_logic;
    -- Read ready. This signal indicates that the master can accept the read
    -- data and response information.
    S_AXI_RREADY  : in std_logic );
end Interface_uub_v1_0_S00_AXI;

architecture arch_imp of Interface_uub_v1_0_S00_AXI is

  -- AXI4LITE signals
  signal axi_awaddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal axi_awready : std_logic;
  signal axi_wready  : std_logic;
  signal axi_bresp   : std_logic_vector(1 downto 0);
  signal axi_bvalid  : std_logic;
  signal axi_araddr  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
  signal axi_arready : std_logic;
  signal axi_rdata   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  signal axi_rresp   : std_logic_vector(1 downto 0);
  signal axi_rvalid  : std_logic;

  -- Example-specific design signals
  -- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
  -- ADDR_LSB is used for addressing 32/64 bit registers/memories
  -- ADDR_LSB = 2 for 32 bits (n downto 2)
  -- ADDR_LSB = 3 for 64 bits (n downto 3)
  constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
  constant OPT_MEM_ADDR_BITS : integer := 3;
  ------------------------------------------------
  ---- Signals for user logic register space example
  --------------------------------------------------
  ---- Number of Slave Registers 16
  type matrice_16x32 is array (15 downto 0) of std_logic_vector(31 downto 0);
  signal slv_reg      : matrice_16x32;
  signal slv_reg_rd   : matrice_16x32;
  signal slv_reg_rden : std_logic;
  signal slv_reg_wren : std_logic;
  signal reg_data_out : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
  signal byte_index   : integer;

component test_uub is
  Port ( RSTn      : in  std_logic;
         CLK       : in  std_logic;
         reg_wr0   : in  std_logic_vector(31 downto 0);
         reg_wr1   : in  std_logic_vector(31 downto 0);
         reg_wr2   : in  std_logic_vector(31 downto 0);
         reg_wr3   : in  std_logic_vector(31 downto 0);
         reg_wr4   : in  std_logic_vector(31 downto 0);
         reg_wr5   : in  std_logic_vector(31 downto 0);
         reg_wr6   : in  std_logic_vector(31 downto 0);
         reg_wr7   : in  std_logic_vector(31 downto 0);
         reg_wr8   : in  std_logic_vector(31 downto 0);
         reg_wr9   : in  std_logic_vector(31 downto 0);
         reg_wr10  : in  std_logic_vector(31 downto 0);
         reg_wr11  : in  std_logic_vector(31 downto 0);
         reg_wr12  : in  std_logic_vector(31 downto 0);
         reg_wr13  : in  std_logic_vector(31 downto 0);
         reg_wr14  : in  std_logic_vector(31 downto 0);
         reg_wr15  : in  std_logic_vector(31 downto 0);
         reg_rd0   : out std_logic_vector(31 downto 0);
         reg_rd1   : out std_logic_vector(31 downto 0);
         reg_rd2   : out std_logic_vector(31 downto 0);
         reg_rd3   : out std_logic_vector(31 downto 0);
         reg_rd4   : out std_logic_vector(31 downto 0);
         reg_rd5   : out std_logic_vector(31 downto 0);
         reg_rd6   : out std_logic_vector(31 downto 0);
         reg_rd7   : out std_logic_vector(31 downto 0);
         reg_rd8   : out std_logic_vector(31 downto 0);
         reg_rd9   : out std_logic_vector(31 downto 0);
         reg_rd10  : out std_logic_vector(31 downto 0);
         reg_rd11  : out std_logic_vector(31 downto 0);
         reg_rd12  : out std_logic_vector(31 downto 0);
         reg_rd13  : out std_logic_vector(31 downto 0);
         reg_rd14  : out std_logic_vector(31 downto 0);
         reg_rd15  : out std_logic_vector(31 downto 0);
      -- Interface ADC AD9628 (CLK)
         ADC_CK    : in  std_logic;
     -- Interface Horloge
         FPGA_CK   : in  std_logic;
      -- Interface ADC AD9628 (Datas)
         adc0      : in  std_logic_vector(25 downto 0);
         adc1      : in  std_logic_vector(25 downto 0);


           -- Interface bus to bram
           ADC0_mem          : out  std_logic_vector(31 downto 0);
           ADC1_mem          : out  std_logic_vector(31 downto 0);
                    
           ADDR_mem          : out  std_logic_vector(31 downto 0);
           enable            : out  std_logic;
           wea               : out  std_logic_vector(3 downto 0);
           sw_service        : in  std_logic_vector(1 downto 0);  
                   
      -- Interface Trigger
         TRIG_IN   : in  std_logic;
         TRIG_OUT  : out std_logic);
         
end component;

begin
  -- I/O Connections assignments

  S_AXI_AWREADY <= axi_awready;
  S_AXI_WREADY  <= axi_wready;
  S_AXI_BRESP   <= axi_bresp;
  S_AXI_BVALID  <= axi_bvalid;
  S_AXI_ARREADY <= axi_arready;
  S_AXI_RDATA   <= axi_rdata;
  S_AXI_RRESP   <= axi_rresp;
  S_AXI_RVALID  <= axi_rvalid;
  -- Implement axi_awready generation
  -- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
  -- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is de-asserted
  -- when reset is low.

  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        axi_awready <= '0';
      else
        if (axi_awready ='0' and S_AXI_AWVALID ='1' and S_AXI_WVALID ='1') then
          -- slave is ready to accept write address when
          -- there is a valid write address and write data on the write address
          -- and data bus. This design expects no outstanding transactions. 
          axi_awready <= '1';
        else
          axi_awready <= '0';
        end if;
      end if;
    end if;
  end process;

  -- Implement axi_awaddr latching
  -- This process is used to latch the address when both S_AXI_AWVALID and 
  -- S_AXI_WVALID are valid. 

  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        axi_awaddr <= (others => '0');
      else
        if (axi_awready ='0' and S_AXI_AWVALID ='1' and S_AXI_WVALID ='1') then
          axi_awaddr <= S_AXI_AWADDR;  -- Write Address latching
        end if;
      end if;
    end if;                   
  end process; 

  -- Implement axi_wready generation
  -- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
  -- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is de-asserted
  -- when reset is low. 

  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        axi_wready <= '0';
      else
        if (axi_wready ='0' and S_AXI_WVALID ='1' and S_AXI_AWVALID ='1') then
            -- slave is ready to accept write data when 
            -- there is a valid write address and write data on the write
            -- address and data bus. This design expects no outstanding
            -- transactions.           
            axi_wready <= '1';
        else
          axi_wready <= '0';
        end if;
      end if;
    end if;
  end process; 

  -- Implement memory mapped register select and write logic generation
  -- The write data is accepted and written to memory mapped registers when
  -- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. 
  -- Write strobes are used to select byte enables of slave registers while
  -- writing. These registers are cleared when reset (active low) is applied.
  -- Slave register write enable is asserted when valid address and data are
  -- available and the slave is ready to accept the write address and write data.
  slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

  process (S_AXI_ACLK)
  variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        slv_reg <= ( others => (others =>'0'));
      else
        loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
        if (slv_reg_wren = '1') then
          case loc_addr is
                  -- Respective byte enables are asserted as per write strobes                   
            when b"0000" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 0
                  slv_reg(0)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0001" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 1
                  slv_reg(1)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0010" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 2
                  slv_reg(2)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0011" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 3
                  slv_reg(3)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0100" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 4
                  slv_reg(4)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0101" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 5
                  slv_reg(5)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0110" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 6
                  slv_reg(6)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"0111" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 7
                  slv_reg(7)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1000" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 8
                  slv_reg(8)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1001" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 9
                  slv_reg(9)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1010" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 10
                  slv_reg(10)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1011" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 11
                  slv_reg(11)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1100" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 12
                  slv_reg(12)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1101" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 13
                  slv_reg(13)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1110" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 14
                  slv_reg(14)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when b"1111" =>
              for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                if ( S_AXI_WSTRB(byte_index) = '1' ) then  -- slave registor 15
                  slv_reg(15)(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                end if;
              end loop;
            when others => slv_reg <= slv_reg;
          end case;
        end if;
      end if;
    end if;                   
  end process; 

  -- Implement write response logic generation
  -- The write response and response valid signals are asserted by the slave 
  -- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
  -- This marks the acceptance of address and indicates the status of write
  -- transaction.

  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        axi_bvalid  <= '0';
        axi_bresp   <= "00"; --need to work more on the responses
      else
        if (axi_awready ='1' and S_AXI_AWVALID ='1' and axi_wready ='1' and S_AXI_WVALID ='1' and axi_bvalid ='0') then
          axi_bvalid <= '1';
          axi_bresp  <= "00"; 
        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
          axi_bvalid <= '0';  -- (there is a possibility that bready is always asserted high)
        end if;
      end if;
    end if;                   
  end process; 

  -- Implement axi_arready generation
  -- axi_arready is asserted for one S_AXI_ACLK clock cycle when S_AXI_ARVALID
  -- is asserted. axi_awready is de-asserted when reset (active low) is asserted. 
  -- The read address is also latched when S_AXI_ARVALID is asserted.
  -- axi_araddr is reset to zero on reset assertion.

  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then 
      if S_AXI_ARESETN = '0' then
        axi_arready <= '0';
        axi_araddr  <= (others => '1');
      else
        if (axi_arready = '0' and S_AXI_ARVALID = '1') then
          -- indicates that the slave has acceped the valid read address
          axi_arready <= '1';
          axi_araddr  <= S_AXI_ARADDR;  -- Read Address latching          
        else
          axi_arready <= '0';
        end if;
      end if;
    end if;                   
  end process; 

  -- Implement axi_arvalid generation
  -- axi_rvalid is asserted for one S_AXI_ACLK clk cycle when both S_AXI_ARVALID
  -- and axi_arready are asserted. The slave registers data are available on 
  -- the axi_rdata bus at this instance. The assertion of axi_rvalid marks the
  -- validity of read data on the bus and axi_rresp indicates the status of
  -- read transaction.axi_rvalid is deasserted on reset (active low).
  -- axi_rresp and axi_rdata are cleared to zero on reset (active low).  
  process (S_AXI_ACLK)
  begin
    if rising_edge(S_AXI_ACLK) then
      if S_AXI_ARESETN = '0' then
        axi_rvalid <= '0';
        axi_rresp  <= "00";
      else
        if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
          -- Valid read data is available at the read data bus
          axi_rvalid <= '1';
          axi_rresp  <= "00"; -- 'OKAY' response
        elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
          axi_rvalid <= '0';  -- Read data is accepted by the master
        end if;            
      end if;
    end if;
  end process;

  -- Implement memory mapped register select and read logic generation
  -- Slave register read enable is asserted when valid address is available
  -- and the slave is ready to accept the read address.
  slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

  process (slv_reg_rd, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
    variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
  begin
    if S_AXI_ARESETN = '0' then
      reg_data_out  <= (others => '1');
    else
      -- Address decoding for reading registers
      loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
      case loc_addr is
        when b"0000" => reg_data_out <= slv_reg_rd(0);
        when b"0001" => reg_data_out <= slv_reg_rd(1);
        when b"0010" => reg_data_out <= slv_reg_rd(2);
        when b"0011" => reg_data_out <= slv_reg_rd(3);
        when b"0100" => reg_data_out <= slv_reg_rd(4);
        when b"0101" => reg_data_out <= slv_reg_rd(5);
        when b"0110" => reg_data_out <= slv_reg_rd(6);
        when b"0111" => reg_data_out <= slv_reg_rd(7);
        when b"1000" => reg_data_out <= slv_reg_rd(8);
        when b"1001" => reg_data_out <= slv_reg_rd(9);
        when b"1010" => reg_data_out <= slv_reg_rd(10);
        when b"1011" => reg_data_out <= slv_reg_rd(11);
        when b"1100" => reg_data_out <= slv_reg_rd(12);
        when b"1101" => reg_data_out <= slv_reg_rd(13);
        when b"1110" => reg_data_out <= slv_reg_rd(14);
        when b"1111" => reg_data_out <= slv_reg_rd(15);
        when others  => reg_data_out <= (others => '0');
      end case;
    end if;
  end process; 

  -- Output register or memory read data
  process( S_AXI_ACLK ) is
  begin
    if (rising_edge (S_AXI_ACLK)) then
      if ( S_AXI_ARESETN = '0' ) then
        axi_rdata  <= (others => '0');
      else
        if (slv_reg_rden = '1') then
          -- When there is a valid read address (S_AXI_ARVALID) with 
          -- acceptance of read address by the slave (axi_arready), 
          -- output the read dada 
          -- Read address mux
            axi_rdata <= reg_data_out;     -- register read data
        end if;   
      end if;
    end if;
  end process;


  -- Add user logic here
test_uub0 : test_uub
  Port map ( RSTn      => S_AXI_ARESETN,
             CLK       => S_AXI_ACLK,
             reg_wr0   => slv_reg(0),
             reg_wr1   => slv_reg(1),
             reg_wr2   => slv_reg(2),
             reg_wr3   => slv_reg(3),
             reg_wr4   => slv_reg(4),
             reg_wr5   => slv_reg(5),
             reg_wr6   => slv_reg(6),
             reg_wr7   => slv_reg(7),
             reg_wr8   => slv_reg(8),
             reg_wr9   => slv_reg(9),
             reg_wr10  => slv_reg(10),
             reg_wr11  => slv_reg(11),
             reg_wr12  => slv_reg(12),
             reg_wr13  => slv_reg(13),
             reg_wr14  => slv_reg(14),
             reg_wr15  => slv_reg(15),
             reg_rd0   => slv_reg_rd(0),
             reg_rd1   => slv_reg_rd(1),
             reg_rd2   => slv_reg_rd(2),
             reg_rd3   => slv_reg_rd(3),
             reg_rd4   => slv_reg_rd(4),
             reg_rd5   => slv_reg_rd(5),
             reg_rd6   => slv_reg_rd(6),
             reg_rd7   => slv_reg_rd(7),
             reg_rd8   => slv_reg_rd(8),
             reg_rd9   => slv_reg_rd(9),
             reg_rd10  => slv_reg_rd(10),
             reg_rd11  => slv_reg_rd(11),
             reg_rd12  => slv_reg_rd(12),
             reg_rd13  => slv_reg_rd(13),
             reg_rd14  => slv_reg_rd(14),
             reg_rd15  => slv_reg_rd(15),
        -- Interface ADC AD9628 (CLK)
             ADC_CK    => ADC_CK,
        -- Interface Horloge
             FPGA_CK   => FPGA_CK,
        -- Interface ADC AD9628 (Datas)
               adc0      => adc0,
               adc1      => adc1,        
              
               ADC0_mem => ADC0_mem,
               ADC1_mem => ADC1_mem,
               
               ADDR_mem => ADDR_mem,
               enable => enable,          
               wea =>  wea,     
               sw_service => sw_service,
                     
        -- Interface Trigger
             TRIG_IN   => TRIG_IN,
             TRIG_OUT  => TRIG_OUT);

  -- User logic ends

end arch_imp;

 