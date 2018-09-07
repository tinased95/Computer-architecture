library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is port (
    d1,d2: in std_logic;
    q1,q2: out std_logic;
    clk: in std_logic;
    rst : in std_logic
    );
end DFF;

architecture rtl of DFF is

begin

  resetLatch: process (clk, rst) begin
    if rst = '1' then
      q1 <= '0';
    elsif clk'event and clk = '1' then
      q1 <= d1;
      q2 <= d2;
    end if;
  end process;

end rtl;
