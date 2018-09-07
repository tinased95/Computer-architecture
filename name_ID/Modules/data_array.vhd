library IEEE;
use IEEE.std_logic_1164.all;

entity data_array is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  wren: in std_logic;
  wrdata:in std_logic_vector(31 downto 0);
  data: out std_logic_vector(31 downto 0)
  );
end data_array;

architecture dataflow of data_array is

begin

	-- insert your code here --
	
	
end data_array;
