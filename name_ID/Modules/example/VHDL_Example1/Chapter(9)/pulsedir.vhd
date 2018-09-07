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

signal downCnt, downCntData: unsigned(7 downto 0);
signal downCntLd, downCntEn: std_logic;
signal delayCntVal, pulseCntVal: unsigned(7 downto 0);
signal startPulse, endPulse: std_logic;

subtype fsmType is std_logic_vector(1 downto 0);
constant loadDelayCnt  : fsmType := "00";
constant waitDelayEnd  : fsmType := "10";
constant loadLengthCnt : fsmType := "11";
constant waitLengthEnd : fsmType := "01";

signal currState, nextState: fsmType;

begin

  delayreg: process (clk, reset) begin
    if reset = '1' then
      delayCntVal <= "11111111";
    elsif clk'event and clk = '1' then
      if loadDelay = '1' then
        delayCntVal <= to_unsigned(data);
      end if;
    end if;
  end process;

  lengthReg: process (clk, reset) begin
    if reset = '1' then
      pulseCntVal <= "11111111";
    elsif clk'event and clk = '1' then
      if loadDelay = '1' then
        pulseCntVal <= to_unsigned(data);
      end if;
    end if;
  end process;

  nextStProc: process (currState, downCnt, loadDelay, loadLength) begin
    case currState is
      when loadDelayCnt =>
        nextState <= waitDelayEnd;

      when waitDelayEnd =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        elsif (downCnt = 0) then
          nextState <= loadLengthCnt;
        else
          nextState <= waitDelayEnd;
        end if;

      when loadLengthCnt =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        else
          nextState <= waitLengthEnd;
        end if;

      when waitLengthEnd =>
        if (loadDelay = '1' or loadLength = '1') then
          nextState <= loadDelayCnt;
        elsif (downCnt = 0) then
          nextState <= loadDelayCnt;
        else
          nextState <= waitDelayEnd;
        end if;

      when others =>
        null;

   end case;
  end process nextStProc;

  currStProc: process (clk, reset) begin
    if (reset = '1') then
      currState <= loadDelayCnt;
    elsif (clk'event and clk = '1') then
      currState <= nextState;
    end if;
  end process currStProc;

  outConProc: process (currState, delayCntVal, pulseCntVal) begin
    case currState is
      when loadDelayCnt =>
        downCntEn <= '0';
        downCntLd <= '1';
        downCntData <= delayCntVal;

      when waitDelayEnd =>
        downCntEn <= '1';
        downCntLd <= '0';
        downCntData <= delayCntVal;

      when loadLengthCnt =>
        downCntEn <= '0';
        downCntLd <= '1';
        downCntData <= pulseCntVal;

      when waitLengthEnd =>
        downCntEn <= '1';
        downCntLd <= '0';
        downCntData <= pulseCntVal;

      when others =>
        downCntEn <= '0';
        downCntLd <= '1';
        downCntData <= pulseCntVal;

    end case;
  end process outConProc;

  downCntr: process (clk,reset) begin
    if (reset = '1') then
      downCnt <= "00000000";
    elsif (clk'event and clk = '1') then
      if (downCntLd = '1') then
        downCnt <= downCntData;
      elsif (downCntEn = '1') then
        downCnt <= downCnt - 1;
      else
        downCnt <= downCnt;
      end if;
    end if;
  end process;

  -- Assign pulse output
  pulse <= currState(0);
        

end rtl;
