library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity exsll is 
	port (
        clock: in std_logic;
        input: in std_logic_vector(15 downto 0);
		immediate: in std_logic_vector(5 downto 0);
        result : out std_logic_vector(15 downto 0)
	);
end exsll;
  
  architecture behavioral of exsll is 
  
    begin 
      process(clock)
		begin
        if(clock'event) then
            case immediate is
				when "000000" =>
					result <= input(15 downto 0);
				when "000001" =>
					result <= input(14 downto 0) & "0";
				when "000010" =>
					result <= input(13 downto 0) & "00";
				when "000011" =>
					result <= input(12 downto 0) & "000";
				when "000100" =>
					result <= input(11 downto 0) & "0000";
				when "000101" =>
					result <= input(10 downto 0) & "00000";
				when "000110" =>
					result <= input(9  downto 0) & "000000";
				when "000111" =>
					result <= input(8  downto 0) & "0000000";
				when "001000" =>
					result <= input(7 downto 0) & "00000000";
				when "001001" =>
					result <= input(6  downto 0) & "000000000";
				when "001010" =>
					result <= input(5  downto 0) & "0000000000";
				when "001011" =>
					result <= input(4  downto 0) & "00000000000";
				when "001100" =>
					result <= input(3  downto 0) & "000000000000";
				when "001101" =>
					result <= input(2  downto 0) & "0000000000000";
				when "001110" =>
					result <= input(1  downto 0) & "00000000000000";
				when "001111" =>
					result <= input(0) & "000000000000000";
				when others =>
					result <= "0000000000000000";
				end case;
		end if;
    end process;
  
end architecture;


