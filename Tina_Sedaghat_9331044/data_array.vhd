LIBRARY IEEE;
USE IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;

entity data_array is
  port (
    clk : in std_logic;
    address : in std_logic_vector(5 downto 0);
    wren : in std_logic;
    wrdata : in std_logic_vector(31 downto 0);
    data : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavorial of data_array is
  type dataArray is array(63 downto 0) of std_logic_vector (31 downto 0);
  signal dataArrayy : dataArray;
   begin
     process(clk)
      begin
     if( wren = '1')
      then 
     dataArrayy(to_integer(unsigned(address))) <= wrdata;
     end if;   
     
     data <= dataArrayy(to_integer(unsigned(address))); 
     end process;
end behavorial;