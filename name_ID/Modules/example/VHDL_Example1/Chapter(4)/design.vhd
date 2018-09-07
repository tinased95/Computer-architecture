-- Incorporates Errata 5.1 and 5.4

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity progPulse is port (
  clk, reset: in std_logic;
  loadLength,loadDelay: in std_logic;
  data: in std_logic_vector(7 downto 0);
  pulse: out std_logic
  );
end progPulse;

architecture rtl of progPulse is

signal delayCnt, pulseCnt: unsigned(7 downto 0);
signal delayCntVal, pulseCntVal: unsigned(7 downto 0);
signal startPulse, endPulse: std_logic;

begin

  delayReg: process (clk, reset) begin
    if reset = '1' then
      delayCntVal <= "11111111";
    elsif clk'event and clk = '1' then
      if loadDelay = '1' then
        delayCntVal <= unsigned(data);
      end if;
    end if;
  end process;

  lengthReg: process (clk, reset) begin
    if reset = '1' then
      pulseCntVal <= "11111111";
    elsif clk'event and clk = '1' then
      if loadLength = '1' then -- changed loadLength to loadDelay (Errata 5.1)
        pulseCntVal <= unsigned(data);
      end if;
    end if;
  end process;

  pulseDelay: process (clk, reset) begin
    if (reset = '1') then
      delayCnt <= "11111111";
    elsif(clk'event and clk = '1') then
      if (loadDelay = '1' or loadLength = '1' or endPulse = '1') then -- changed startPulse to endPulse (Errata 5.1)
        delayCnt <= delayCntVal;
      elsif endPulse = '1' then
        delayCnt <= delayCnt - 1;
      end if;
    end if;
  end process;

  startPulse <= '1' when delayCnt = "00000000" else '0';

  pulseLength: process (clk, reset) begin
    if (reset = '1') then
      pulseCnt <= "11111111";
    elsif (clk'event and clk = '1') then
      if (loadLength = '1') then
        pulseCnt <= pulseCntVal;
      elsif (startPulse = '1' and endPulse = '1') then
        pulseCnt <= pulseCntVal;
      elsif (endPulse = '1') then
        pulseCnt <= pulseCnt;
      else
        pulseCnt <= pulseCnt - 1;
      end if;
    end if;
  end process;

  endPulse <= '1' when pulseCnt = "00000000" else '0';

  pulseOutput: process (clk, reset) begin
    if (reset = '1') then
      pulse <= '0';
    elsif (clk'event and clk = '1') then
      if (startPulse = '1') then
        pulse <= '1';
      elsif (endPulse = '1') then
        pulse <= '0';
      end if;
    end if;
  end process;
        

end rtl;
