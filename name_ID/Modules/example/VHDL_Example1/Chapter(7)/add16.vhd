library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity adder is port (
  a,b : in std_logic_vector (15 downto 0);
  sum: out std_logic_vector (15 downto 0)
  );
end adder;

architecture dataflow of adder is

begin

  sum <= a + b;

end dataflow;
