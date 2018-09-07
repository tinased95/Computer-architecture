library ieee;
use ieee.std_logic_1164.all;

entity and2 is port (
  a,b: in std_logic;
  a_and_b: out std_logic
  );
end and2;

architecture dataflow of and2 is

begin

  a_and_b <= '1' when a = '1' and b = '1' else '0';

end dataflow;
