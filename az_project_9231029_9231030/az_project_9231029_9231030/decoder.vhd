library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity decoder is port(
  clock : in std_logic;
  IR : in std_logic_vector(15 downto 0);
	D : out std_logic_vector(15 downto 0)
);

end entity decoder;


architecture assigns of decoder is
 
 begin 
	process(IR(15 downto 12), clock) 
  begin 
	D <= "0000000000000000";
	if ( clock'event ) then 
	case IR(15 downto 12) is 
		when "0000" => D(0) <= '1';
		when "0001" => D(1) <= '1';
		when "0010" => D(2) <= '1';
		when "0011" => D(3) <= '1';
		when "0100" => D(4) <= '1';
		when "0101" => D(5) <= '1';
		when "0110" => D(6) <= '1';
		when "0111" => D(7) <= '1';
		when "1000" => D(8) <= '1';
		when "1001" => D(9) <= '1';
		when "1010" => D(10) <= '1';
		when "1011" => D(11) <= '1';
		when "1100" => D(12) <= '1';
		when "1101" => D(13) <= '1';
		when "1110" => D(14) <= '1';
		when "1111" => D(15) <= '1';
		 when others => D(0) <= '0';
		end case;
		end if;
	end process;
  end assigns;
