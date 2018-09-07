library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity multiplier is port (
  a,b : in std_logic_vector (15 downto 0);
  product: out std_logic_vector (31 downto 0)
  );
end multiplier;

architecture dataflow of multiplier is

begin

  product <= a * b;

end dataflow;
