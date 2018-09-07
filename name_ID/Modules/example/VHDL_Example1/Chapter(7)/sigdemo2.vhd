library ieee;
use ieee.std_logic_1164.all;

entity signalDemo is port (
  a: in std_logic;
  b: out std_logic
  );
end signalDemo;

architecture basic of signalDemo is

signal c: std_logic;

begin

  demo: process (a) begin

    c <= a;

    if c = '0' then
      b <= a;
    else
      b <= '0';
    end if;

  end process;

end basic;
