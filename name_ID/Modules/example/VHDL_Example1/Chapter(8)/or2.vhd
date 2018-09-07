library IEEE;
use IEEE.std_logic_1164.all;

library IEEE;
use IEEE.std_logic_1164.all;

entity OR2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end OR2;

architecture rtl of OR2 is

begin

  y <= '1' when i1 = '1' or i2 = '1' else '0';

end rtl;
