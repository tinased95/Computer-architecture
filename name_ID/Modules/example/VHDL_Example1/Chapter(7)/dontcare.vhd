library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity compareDC is port (
  addressBus: in std_logic_vector(31 downto 0);
  addressHit: out std_logic
  );
end compareDC;

architecture wontWork of compareDC is

begin

  compare: process(addressBus) begin
    if (addressBus = "011110101011--------------------") then
      addressHit <= '1';
    else
      addressHit <= '0';
    end if;
  end process compare;

end wontWork;
