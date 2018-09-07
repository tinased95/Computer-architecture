library ieee;
use ieee.std_logic_1164.all;

entity pulseErr is port
  (a: in std_logic;
   b: out std_logic
  );
end pulseErr;

architecture behavior of pulseErr is

signal c: std_logic;

begin

  pulse: process (a,c) begin
    b <= c XOR a;

    c <= a;
  end process;

end behavior;
