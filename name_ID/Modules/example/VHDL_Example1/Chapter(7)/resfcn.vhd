library ieee;
use ieee.std_logic_1164.all;

entity resFcnDemo is port (
  a, b: in std_logic;
  oeA,oeB: in std_logic;
  result: out std_logic
  );
end resFcnDemo;

architecture multiDriver of resFcnDemo is

begin

  result <= a when oeA = '1' else 'Z';
  result <= b when oeB = '1' else 'Z';

end multiDriver;
