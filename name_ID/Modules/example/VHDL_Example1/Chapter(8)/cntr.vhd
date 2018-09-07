library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Cnt4Term is port (
  clk: in std_logic;
  Cnt: out std_logic_vector(3 downto 0);
  TermCnt: out std_logic
  );
end Cnt4Term;

architecture behavioral of Cnt4Term is

signal CntL: unsigned(3 downto 0);

begin

  increment: process begin
    wait until clk = '1';
      CntL <= CntL + 1;
  end process;

  Cnt <= to_stdlogicvector(CntL);

  TermCnt <= '1' when CntL = "1111" else '0';

end behavioral;

library IEEE;
use IEEE.std_logic_1164.all;

entity Counter is port (
  clock: in std_logic;
  Count: out std_logic_vector(3 downto 0)
  );
end Counter;

architecture structural of Counter is

  component Cnt4Term port (
    clk: in std_logic;
    Cnt: out std_logic_vector(3 downto 0);
    TermCnt: out std_logic);
  end component;

begin

  u1: Cnt4Term port map (clk => clock,
                         Cnt => Count,
                         TermCnt => open
                    );

end structural;
