library IEEE;
use IEEE.std_logic_1164.all;

entity BidirCnt is port (
  OE: in std_logic;
  CntEnable: in std_logic;
  LdCnt: in std_logic;
  Clk: in std_logic;
  Rst: in std_logic;
  Cnt: inout std_logic_vector(3 downto 0)
  );
end BidirCnt;

architecture behavioral of BidirCnt is

  component LoadCnt port (
    CntEn: in std_logic;
    LdCnt: in std_logic;
    LdData: in std_logic_vector(3 downto 0);
    Clk: in std_logic;
    Rst: in std_logic;
    CntVal: out std_logic_vector(3 downto 0)
    );
  end component;

  component BidirBuf port (
    OE: in std_logic;
    input: in std_logic_vector;
    output: inout std_logic_vector
    );
  end component;

signal CntVal: std_logic_vector(3 downto 0);
signal LoadVal: std_logic_vector(3 downto 0);

begin

  u1: loadcnt port map (CntEn => CntEnable,
                        LdCnt => LdCnt,
                        LdData => LoadVal,
                        Clk => Clk,
                        Rst => Rst,
                        CntVal => CntVal
                        );

  u2: bidirbuf port map (OE => oe,
                         input => CntVal,
                         output => Cnt
                        );

  LoadVal <= Cnt;

end behavioral;
