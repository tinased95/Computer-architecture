library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity jump is 
	port (
        clock: in std_logic;
        pc : in std_logic_vector(15 downto 0);
        immediate: in std_logic_vector(11 downto 0);
        jump : out std_logic_vector(15 downto 0)
	);
end jump;
  
architecture behavioral of jump is 
  begin 
      process(clock)
        begin
        if(clock'event) then
            jump <= pc(15 downto 13) & immediate & "0";
		  end if;
    end process;
  
end architecture;

