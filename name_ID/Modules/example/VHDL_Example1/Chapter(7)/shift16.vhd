library IEEE;
use IEEE.std_logic_1164.all;

entity shifter is port (
  clk, rst: in std_logic;
  shiftEn,shiftIn: std_logic;
  q: out std_logic_vector (15 downto 0)
  );
end shifter;


architecture behav of shifter is

signal qLocal: std_logic_vector(15 downto 0);

begin

  shift: process (clk, rst) begin
    if (rst = '1') then
      qLocal <= (others => '0');
    elsif (clk'event and clk = '1') then
      if (shiftEn = '1') then
        qLocal <= qLocal(14 downto 0) & shiftIn;
      else
        qLocal <= qLocal;
      end if;
    end if;

    q <= qLocal;
  end process;

end behav;
