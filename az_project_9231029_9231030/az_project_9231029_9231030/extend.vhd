 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;


entity extend is 
  port (
      clock : in std_logic;
      immediate : in std_logic_vector(5 downto 0);
      extended_immediate : out std_logic_vector(15 downto 0)
      );
end extend;    
  
Architecture behavioural OF extend IS
  
  begin
    process(clock)
      begin
        if(clock'event) then
          
            extended_immediate <= std_logic_vector("0000000000" & immediate);
            
        end if;
    end process;
  
end architecture;



