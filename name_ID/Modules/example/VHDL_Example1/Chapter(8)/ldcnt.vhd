library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity LoadCnt is port (
  CntEn: in std_logic;
  LdCnt: in std_logic;
  LdData: in std_logic_vector(3 downto 0);
  Clk: in std_logic;
  Rst: in std_logic;
  CntVal: out std_logic_vector(3 downto 0)
  );
end LoadCnt;

architecture behavioral of LoadCnt is

signal Cnt: std_logic_vector(3 downto 0);

begin

  counter: process (Clk, Rst) begin
    if Rst = '1' then
      Cnt <= (others => '0');
    elsif (Clk'event and Clk = '1') then
      if (LdCnt = '1') then
        Cnt <= LdData;
      elsif (CntEn = '1') then
        Cnt <= Cnt + 1;
      else
        Cnt <= Cnt;
      end if;
    end if;
  end process;

  CntVal <= Cnt;

end behavioral;
