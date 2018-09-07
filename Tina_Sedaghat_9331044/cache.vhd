LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity cache is 
  port(
    clk, wren, reset_n :in std_logic;
    address_cache:in std_logic_vector(9 downto 0);
    wrdata:in std_logic_vector(31 downto 0);
		data:out std_logic_vector(31 downto 0)
  );
end cache;
architecture behavorial of cache is
  
    component data_array is
        port(
          clk : in std_logic;
          address : in std_logic_vector(5 downto 0);
          wren : in std_logic;
          wrdata : in std_logic_vector(31 downto 0);
          data : out std_logic_vector(31 downto 0)
         );
    end component;
    
  component tag_valid_array is
    port
    (   
    clk:in std_logic;
    wren:in std_logic;
    reset_n:in std_logic;
    invalidate:in std_logic;
    address:in std_logic_vector(5 downto 0);
    wrdata:in std_logic_vector(3 downto 0);
    output:out std_logic_vector(4 downto 0)
     );
end component;
component miss_hit_logic is
  port(
         clk : in std_logic;
         tag : in std_logic_vector(3 downto 0);
         w0 : in std_logic_vector(4 downto 0);
         w1 : in std_logic_vector(4 downto 0);
         hit : out std_logic;
         w0_valid : out std_logic;
         w1_valid : out std_logic
       );
     end component;
component lru_array is
 port(
         address : in std_logic_vector(5 downto 0);
         clk : in std_logic;
         en : in std_logic;
         w1_valid : out std_logic
     );
     end component;
   
    type dataArray is array (63 downto 0) of std_logic_vector (31 downto 0);
    --data array signals
    signal data0 : std_logic_vector(31 downto 0);
    signal data1 : std_logic_vector(31 downto 0);
    signal wrdata0 :std_logic_vector(31 downto 0);
    signal wrdata1 :std_logic_vector(31 downto 0);
    signal address : std_logic_vector(5 downto 0);
    signal data_wren0 : std_logic := '0';
    signal data_wren1 : std_logic := '0';
    -- tag valid signals
    signal tag_output0 : std_logic_vector(4 downto 0);
    signal tag_output1 : std_logic_vector(4 downto 0);
    signal tag_wren0 : std_logic := '0';
    signal tag_wren1 : std_logic := '0';
    signal invalidate0 :std_logic; 
    signal invalidate1 :std_logic; 
    signal wrdata0_tag :std_logic_vector(3 downto 0);
    signal wrdata1_tag :std_logic_vector(3 downto 0);
    -- miss-hit-logic signals
    signal misshit_tag :  std_logic_vector(3 downto 0);
    signal misshit_w0 : std_logic_vector(4 downto 0);
    signal misshit_w1 : std_logic_vector(4 downto 0);
    signal hit : std_logic;
    signal w0_valid : std_logic;
    signal w1_valid : std_logic;
    -- lru signals
    signal lru_address :  std_logic_vector(3 downto 0);
    signal enable : std_logic;
    signal w1_valid_lru : std_logic;
    begin
      -- port maps:
    data_array0: data_array port map (clk =>clk , wren => data_wren0 , address => address , wrdata => wrdata0 ,data =>data0);
    data_array1: data_array port map (clk =>clk , wren => data_wren1 , address => address , wrdata => wrdata1 ,data =>data1);
    
    tag_valid0 : tag_valid_array port map (clk =>clk , wren => tag_wren0 ,reset_n => reset_n , invalidate => invalidate0,address => address ,wrdata => wrdata0_tag , output =>tag_output0 );
    tag_valid1 : tag_valid_array port map (clk =>clk , wren => tag_wren1 ,reset_n => reset_n , invalidate => invalidate1,address => address ,wrdata => wrdata1_tag , output =>tag_output1 );
       
    miss_hit : miss_hit_logic port map (clk =>clk,tag =>misshit_tag, w0 =>misshit_w0, w1 =>misshit_w1,hit=>hit , w0_valid =>w0_valid , w1_valid =>w0_valid);  
    lru : lru_array port map (address => address , clk =>clk , en =>enable , w1_valid => w1_valid_lru);
    
    
    process(clk)
      begin
        end process;
    end behavorial;