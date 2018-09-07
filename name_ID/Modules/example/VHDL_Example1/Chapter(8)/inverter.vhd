library IEEE;
use IEEE.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;

entity INVERTER is port (
    i: in std_logic;
    o: out std_logic
    );
end INVERTER;

architecture rtl of INVERTER is

begin

  o <= not i;

end rtl;
