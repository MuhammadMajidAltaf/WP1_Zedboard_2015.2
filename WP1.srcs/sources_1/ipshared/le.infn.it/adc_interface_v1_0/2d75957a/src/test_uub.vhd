  -----------------------------------------------------------------------
-- Company: INFN
-- Roberto Assiro, Pietro Creti
-- ADC data module
-----------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;
 
entity test_uub is
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
         ADC0_mem            : out  std_logic_vector(31 downto 0);
         ADC1_mem            : out  std_logic_vector(31 downto 0);
                    
         ADDR_mem            : out  std_logic_vector(31 downto 0);
         enable              : out  std_logic;
         wea                 : out  std_logic_vector(3 downto 0);
         sw_service          : in  std_logic_vector(1 downto 0);
         
      -- Interface Trigger
         TRIG_IN   : in  std_logic;
         TRIG_OUT  : out std_logic);
         
end test_uub;

architecture Behavioral of test_uub is

  type matrice_2x13 is array (1 downto 0) of std_logic_vector(12 downto 0);
  signal mem_data_a : matrice_2x13;
  signal out_data_a : matrice_2x13;
  signal out_data_b : matrice_2x13;
  signal out_data_a_p1 : matrice_2x13;
  signal out_data_a_p2 : matrice_2x13;
  signal out_data_b_p1 : matrice_2x13;
  signal out_data_b_p2 : matrice_2x13;

  signal out_data_a_p3 : matrice_2x13;
  signal out_data_a_p4 : matrice_2x13;
  signal out_data_b_p3 : matrice_2x13;
  signal out_data_b_p4 : matrice_2x13;
  signal out_data_a_p5 : matrice_2x13;
  signal out_data_a_p6 : matrice_2x13;
  signal out_data_b_p5 : matrice_2x13;
  signal out_data_b_p6 : matrice_2x13;
  signal TRIG_OUT_INT  : std_logic;
  
  signal adc0_data : std_logic_vector (31 downto 0);
  signal adc1_data : std_logic_vector (31 downto 0);
  
  signal buffer1 : std_logic_vector (25 downto 0);
  signal buffer2 : std_logic_vector (25 downto 0);
  
  signal adc0_g : std_logic_vector (25 downto 0);
  signal adc1_g : std_logic_vector (25 downto 0);
  
  signal conteggio : std_logic_vector (15 downto 0);
  signal wea_reg : std_logic_vector (3 downto 0);
  signal sw_reg : std_logic_vector(1 downto 0);
  signal enable_mem : std_logic;
  
  signal flop_flip  : std_logic;
  signal trig0  : std_logic;
  signal trig1  : std_logic;
  signal trig2  : std_logic;
  signal trig3  : std_logic;
  signal trig_ok  : std_logic;
  signal veto_trig  : std_logic;
  
begin

-- adc0 reverse 
adc0_g(0) <=  adc0(25);
adc0_g(1) <=  adc0(24);
adc0_g(2) <=  adc0(23);
adc0_g(3) <=  adc0(22);
adc0_g(4) <=  adc0(21);
adc0_g(5) <=  adc0(20);
adc0_g(6) <=  adc0(19);
adc0_g(7) <=  adc0(18);
adc0_g(8) <=  adc0(17);
adc0_g(9) <=  adc0(16);
adc0_g(10) <=  adc0(15);
adc0_g(11) <=  adc0(14);
adc0_g(12) <=  adc0(13);
adc0_g(13) <=  adc0(12);
adc0_g(14) <=  adc0(11);
adc0_g(15) <=  adc0(10);
adc0_g(16) <=  adc0(9);
adc0_g(17) <=  adc0(8);
adc0_g(18) <=  adc0(7);
adc0_g(19) <=  adc0(6);
adc0_g(20) <=  adc0(5);
adc0_g(21) <=  adc0(4);
adc0_g(22) <=  adc0(3);
adc0_g(23) <=  adc0(2);
adc0_g(24) <=  adc0(1);
adc0_g(25) <=  adc0(0);

-- adc1 reverse
--chA
adc1_g(0) <=  adc1(25);
adc1_g(1) <=  adc1(24);
adc1_g(2) <=  adc1(23);
adc1_g(3) <=  adc1(22);
adc1_g(4) <=  adc1(21);
adc1_g(5) <=  adc1(20);
adc1_g(6) <=  adc1(19);
adc1_g(7) <=  adc1(18);
adc1_g(8) <=  adc1(17);
adc1_g(9) <=  adc1(16);
adc1_g(10) <=  adc1(15);
adc1_g(11) <=  adc1(14);
adc1_g(12) <=  adc1(13);

--chB
adc1_g(13) <=  adc1(12);
adc1_g(14) <=  adc1(11);
adc1_g(15) <=  adc1(10);
adc1_g(16) <=  adc1(9);
adc1_g(17) <=  adc1(8);
adc1_g(18) <=  adc1(7);
adc1_g(19) <=  adc1(6);
adc1_g(20) <=  adc1(5);

adc1_g(21) <=  adc1(4);
adc1_g(22) <=  adc1(3);
adc1_g(23) <=  adc1(2);
adc1_g(24) <=  adc1(1);
--overflow
adc1_g(25) <=  adc1(0); 
            
 --******************************************************************
 -- Rseynchronisation des datas recus de l'elements Selectio_wiz_X
 --******************************************************************

 process(RSTn, ADC_CK)  -- a changer par le reset SELECTIO_WIZ_X
 begin
   if RSTn = '0' then
       mem_data_a <= ( others => (others => '0'));
       out_data_a <= ( others => (others => '0'));
       out_data_b <= ( others => (others => '0'));
       adc0_data <= (others => '0');
       adc1_data <= (others => '0');
       flop_flip <= '0';
   elsif rising_edge(ADC_CK) then 
        flop_flip <= not(flop_flip);  
--        if(flop_flip = '1') then                
        mem_data_a <= ( adc1_g(25 downto 13), adc0_g(25 downto 13) );
        out_data_a <= mem_data_a;
        out_data_b <= ( adc1_g(12 downto 0), adc0_g(12 downto 0) );  


--       allineamento del byte meno significativo dopo splittaggio
--       buffer1 <= adc0_g(12 downto 0) & adc1_g(12 downto 0);            
--       adc0_data <= "0000" & buffer1(24 downto 13) & "0000" & adc0_g(24 downto 13);                              
--       adc1_data <= "0000" & buffer1(11 downto 0)  & "0000" & adc1_g(24 downto 13);  

--     scrittura diretta dei dati come vengono da splittaggio  
       adc0_data <= "0000" & adc0_g(24 downto 13) & "0000" & adc0_g(11 downto 0);   -- il bit overflow su adc0 e' messo volutamente a zero in quanto non e' connesso sul pcb(errore)
       adc1_data <= "000" & adc1_g(25 downto 13) & "000" & adc1_g(12 downto 0);                      

  end if;
 end process;

--********************************************************************
--                 Changement de domaine d horloge 
--********************************************************************

--  process(RSTn, CLK)
 process(RSTn, ADC_CK)
 begin
   if RSTn = '0' then
        out_data_a_p1 <= ( others => (others => '0'));
        out_data_a_p2 <= ( others => (others => '0'));
        out_data_b_p1 <= ( others => (others => '0'));
        out_data_b_p2 <= ( others => (others => '0'));
        out_data_a_p3 <= ( others => (others => '0'));
        out_data_a_p4 <= ( others => (others => '0'));
        out_data_b_p3 <= ( others => (others => '0'));
        out_data_b_p4 <= ( others => (others => '0'));
        out_data_a_p5 <= ( others => (others => '0'));
        out_data_a_p6 <= ( others => (others => '0'));
        out_data_b_p5 <= ( others => (others => '0'));
        out_data_b_p6 <= ( others => (others => '0'));
     
        conteggio <= (others => '0');
        wea_reg <= (others => '1');
        enable_mem <= '1';
        veto_trig <= '0';
   elsif rising_edge(ADC_CK) then
        if ((trig_ok = '1') AND (veto_trig = '0')) then
                veto_trig <= '1';
                enable_mem <= '1';
                wea_reg <= "1111";
                conteggio <= (others => '0');     
        elsif   ((conteggio = "0011111111111100") AND (sw_reg = "01")) then     -- se lo sw0 e' alto resetto conteggio di continuo e memorizzo sempre
                veto_trig <= '1';
                enable_mem <= '1';
                wea_reg <= "1111";
                conteggio <= (others => '0'); 
        elsif   (conteggio = "0011111111111100") then -- mi fermo con indirizzamento a 4k per 32 bit equivalente a indirizzo 3FFC
                    conteggio <= conteggio ;
--                  enable_mem <= '0';
                    wea_reg <= "1111";    --wea_reg <= (others => '0');
                    veto_trig <= '0';
         else
                enable_mem <= '1';
                wea_reg <= "1111";     
                conteggio <= conteggio + "0000000000000100"; -- incremento di 4 locazioni da 8 bit quindi 32 bit per riga
--              wea_reg <= wea;
     
                out_data_a_p1 <= out_data_a;
                out_data_a_p2 <= out_data_a_p1;
                out_data_b_p1 <= out_data_b;
                out_data_b_p2 <= out_data_b_p1;
     
                out_data_a_p3 <= out_data_a_p2;
                out_data_a_p4 <= out_data_a_p3;
                out_data_b_p3 <= out_data_b_p2;
                out_data_b_p4 <= out_data_b_p3;
     
                out_data_a_p5 <= out_data_a_p4;
                out_data_a_p6 <= out_data_a_p5;
                out_data_b_p5 <= out_data_b_p4;
                out_data_b_p6 <= out_data_b_p5;  
               
        end if;    
        
   end if;
 end process;
 
ADDR_mem <= "0000000000000000" & conteggio; -- indirizzamento continuo memoria

ADC0_mem <= adc0_data; -- collego dati su porta
ADC1_mem <= adc1_data;
wea <= wea_reg;
--wea <= "1111";
enable <= enable_mem; -- enable sempre messo a 1, metto a zero se voglio bloccare scrittura in memoria
sw_reg <= sw_service;
--********************************************************************
--                     Formation des registres 
--********************************************************************
    
--reg_rd0  <= "000" & adc0_g(25 downto 13) & "000" & adc0_g(12 downto 0);
reg_rd0  <= "000" & out_data_b_p2(0) & "000" & out_data_a_p2(0);
reg_rd1  <= "000" & out_data_b_p2(1) & "000" & out_data_a_p2(1);

reg_rd2  <= "000" & out_data_b_p3(0) & "000" & out_data_a_p3(0);
reg_rd3  <= "000" & out_data_b_p3(1) & "000" & out_data_a_p3(1); 

reg_rd4  <= "000" & out_data_b_p4(0) & "000" & out_data_a_p4(0);
reg_rd5  <= "000" & out_data_b_p4(1) & "000" & out_data_a_p4(1);

reg_rd6  <= "000" & out_data_b_p5(0) & "000" & out_data_a_p5(0);
reg_rd7  <= "000" & out_data_b_p5(1) & "000" & out_data_a_p5(1); 

reg_rd8  <= "000" & out_data_b_p6(0) & "000" & out_data_a_p6(0);
reg_rd9  <= "000" & out_data_b_p6(1) & "000" & out_data_a_p6(1);
 
  
-- reg_rd2  <= reg_wr2;
-- reg_rd3  <= reg_wr3; 
-- reg_rd4  <= reg_wr4; 
-- reg_rd5  <= reg_wr5;         
-- reg_rd6  <= reg_wr6;           
-- reg_rd7  <= reg_wr7;           
-- reg_rd8  <= reg_wr8;           
-- reg_rd9  <= reg_wr9;           
reg_rd10 <= reg_wr10;     
reg_rd11 <= "0000000000000000" & conteggio;               
reg_rd12 <= "0000000000000000" & conteggio;    
  
reg_rd13 <= "0000000000000000000000000000000" & conteggio(0);  
         
reg_rd14 <= reg_wr14;                      
reg_rd15 <= x"5555AAAA";           
         

-- gestione trigger out
process (RSTn,CLK)
begin
 if RSTn = '0' then
    trig0 <= '0';
    trig1 <= '0';
    trig2 <= '0';
    trig3 <= '0';
 elsif rising_edge(ADC_CK) then
    trig0 <= TRIG_IN;
    trig1 <= trig0;
    trig2 <= trig1;
    trig3 <= trig2;
 end if;
end process;

trig_ok <= (not trig3) AND trig1;
TRIG_OUT <= trig_ok;

-- gestione trigger out
--process (RSTn,CLK)
--begin
-- if RSTn = '0' then
--   TRIG_OUT_INT <= '0';
-- elsif rising_edge(ADC_CK) then
--   TRIG_OUT_INT <= not TRIG_OUT_INT;
-- end if;
--end process;

--TRIG_OUT <= TRIG_OUT_INT;

end Behavioral;


