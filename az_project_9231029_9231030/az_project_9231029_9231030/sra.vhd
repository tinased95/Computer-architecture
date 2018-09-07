library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity exsra is 
	port (
        clock: in std_logic;
        input: in std_logic_vector(15 downto 0);
		immediate: in std_logic_vector(5 downto 0);
        result : out std_logic_vector(15 downto 0)
	);
end exsra;
  
architecture behavioral of exsra is 
    begin 
    process(clock)
    begin
    if(clock'event) then
		if(input(15) = '0') then
      case immediate is
				when "000000" =>
					result <= input(15 downto 0);
				when "000001" =>
					result <= "0" & input(15 downto 1);
				when "000010" =>
					result <= "00" & input(15 downto 2);
				when "000011" =>
					result <= "000" & input(15 downto 3);
				when "000100" =>
					result <= "0000" & input(15 downto 4);
				when "000101" =>
					result <= "00000" & input(15 downto 5);
				when "000110" =>
					result <= "000000" & input(15 downto 6);
				when "000111" =>
					result <= "0000000" & input(15 downto 7);
				when "001000" =>
					result <= "00000000" & input(15 downto 8);
				when "001001" =>
					result <= "000000000" & input(15 downto 9);
				when "001010" =>
					result <= "0000000000" & input(15 downto 10);
				when "001011" =>
					result <= "00000000000" & input(15 downto 11);
				when "001100" =>
					result <= "000000000000" & input(15 downto 12);
				when "001101" =>
					result <= "0000000000000" & input(15 downto 13);
				when "001110" =>
					result <= "00000000000000" & input(15 downto 14);
				when "001111" =>
					result <= "000000000000000" & input(15);
				when others =>
					result <= "0000000000000000";
			end case;
		else
      case immediate is
				when "000000" =>
					result <= input(15 downto 0);
				when "000001" =>
					result <= "1" & input(15 downto 1);
				when "000010" =>
					result <= "11" & input(15 downto 2);
				when "000011" =>
					result <= "111" & input(15 downto 3);
				when "000100" =>
					result <= "1111" & input(15 downto 4);
				when "000101" =>
					result <= "11111" & input(15 downto 5);
				when "000110" =>
					result <= "111111" & input(15 downto 6);
				when "000111" =>
					result <= "1111111" & input(15 downto 7);
				when "001000" =>
					result <= "11111111" & input(15 downto 8);
				when "001001" =>
					result <= "111111111" & input(15 downto 9);
				when "001010" =>
					result <= "1111111111" & input(15 downto 10);
				when "001011" =>
					result <= "11111111111" & input(15 downto 11);
				when "001100" =>
					result <= "111111111111" & input(15 downto 12);
				when "001101" =>
					result <= "1111111111111" & input(15 downto 13);
				when "001110" =>
					result <= "11111111111111" & input(15 downto 14);
				when "001111" =>
					result <= "111111111111111" & input(15);
				when others =>
					result <= "1111111111111111";
			end case;
		end if;
	end if;
  end process;
  
end architecture;



