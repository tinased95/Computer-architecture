library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity lru_array is
    port(
         address : in std_logic_vector(5 downto 0);
         clk : in std_logic;
         en : in std_logic;
         w1_valid : out std_logic
     );
end entity;

architecture behavorial of lru_array is
  type data_array is array (63 downto 0) of integer;
    signal w0 : data_array := (others => 0);
    signal w1 : data_array := (others => 0);
    begin
  process (clk)
    begin   
if(en = '1')  then
    if (w0(to_integer(unsigned(address)))= 0) then
    w1_valid <= '0';
    w0(to_integer(unsigned(address))) <= 1;
    w1(to_integer(unsigned(address))) <= 0;
  end if;
    if(w1(to_integer(unsigned(address)))= 0) then
    w1_valid <= '1';
    w1(to_integer(unsigned(address))) <= 1;
    w0(to_integer(unsigned(address))) <= 0;
  end if;
end if;
 end process;
end behavorial;
