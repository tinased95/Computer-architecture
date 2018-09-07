library IEEE;
use IEEE.std_logic_1164.all;


library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end AND2;

architecture rtl of AND2 is

begin

  y <= '1' when i1 = '1' and i2 = '1' else '0';

end rtl;
