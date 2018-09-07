library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity BidirBuf is port (
  OE: in std_logic;
  input: in std_logic_vector;
  output: out std_logic_vector
  );
end BidirBuf;

architecture behavioral of BidirBuf is

begin

  bidirBuf: process (OE, input) begin
    if (OE = '1') then
      output <= input;
    else
      output <= (others => 'Z');
    end if;
  end process;

end behavioral;
