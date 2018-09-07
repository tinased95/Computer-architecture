-- Incorporates Errata 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity downCounter is port (
  clk: in std_logic;
  reset: in std_logic;
  count: out std_logic_vector(3 downto 0)
  );
end downCounter;

architecture simple of downCounter is

signal countL: unsigned(3 downto 0);
signal termCnt: std_logic;

begin

  decrement: process (clk, reset) begin
    if (reset = '1') then
      countL <= "1011";          -- Reset to 11
      termCnt <= '1';
    elsif(clk'event and clk = '1') then
      if (termCnt = '1') then
        countL <= "1011";        -- Count rolls over to 11
      else
        countL <= countL - 1;
      end if;

      if (countL = "0001") then  -- Terminal count decoded 1 cycle earlier
        termCnt <= '1';
      else
        termCnt <= '0';
      end if;
    end if;
  end process;
  
  count <= std_logic_vector(countL);

end simple;
