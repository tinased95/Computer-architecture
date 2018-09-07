library ieee;
use ieee.std_logic_1164.all;

entity test is port (
  a: in std_logic;
  z: out std_logic;
  en: in std_logic
  );
end test;

architecture simple of test is

begin

  z <= a when en = '1' else 'z';

end simple;
