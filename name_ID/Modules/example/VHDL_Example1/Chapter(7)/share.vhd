library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity ForceShare is port (
  a,b,c,d,e,f: in std_logic_vector (7 downto 0);
  result: out std_logic_vector(7 downto 0)
  );
end ForceShare;

architecture behaviour of ForceShare is

begin

  sum: process (a,c,b,d,e,f)
  variable tempSum: std_logic_vector(7 downto 0);
  begin

    tempSum := a + b; -- temporary node for sum

    if (tempSum = "10011010") then
      result <= c;
    elsif (tempSum = "01011001") then
          result <= d;
    elsif (tempSum = "10111011") then
      result <= e;
    else
      result <= f;
    end if;
  end process;

end behaviour;
