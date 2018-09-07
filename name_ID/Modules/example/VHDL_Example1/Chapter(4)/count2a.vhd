-- Incorporates Errata 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is port (
  clk: in std_logic;
  reset: in std_logic;
  count: out std_logic_vector(0 to 3)
  );
end counter;

architecture simple of counter is

signal countL: unsigned(0 to 3);

begin

  increment: process (clk, reset) begin
    if reset = '1' then
      countL <= "1001";
    elsif(clk'event and clk = '1') then
      countL <= countL + 1;
    end if;
  end process;
  
  count <= std_logic_vector(countL);

end simple;
