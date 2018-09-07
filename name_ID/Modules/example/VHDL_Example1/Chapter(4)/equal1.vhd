-- includes Errata 5.2
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- errata 5.2

entity compare is port (
  ina: in std_logic_vector (3 downto 0);
  inb: in std_logic_vector (2 downto 0);
  equal: out std_logic
  );
end compare;

architecture simple of compare is

begin

  equalProc: process (ina, inb) begin
    if (ina = inb ) then
      equal <= '1';
    else
      equal <= '0';
    end if;
  end process;

end simple;
