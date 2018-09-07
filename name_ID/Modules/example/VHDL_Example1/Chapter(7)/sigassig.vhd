library ieee;
use ieee.std_logic_1164.all;

entity lastAssignment is port
  (a, b: in std_logic;
   selA, selb: in std_logic;
   result: out std_logic
  );
end lastAssignment;

architecture behavioral of lastAssignment is

begin

  demo: process (a,b,selA,selB) begin
    if (selA = '1') then
      result <= a;
    else
      result <= '0';
    end if;

    if (selB = '1') then
      result <= b;
    else
      result <= '0';
    end if;
  end process demo;

end behavioral;
