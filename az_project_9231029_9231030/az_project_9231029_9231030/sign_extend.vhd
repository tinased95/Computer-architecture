 LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;


entity sign_extend is 
  port (
      clock : in std_logic;
      immediate : in std_logic_vector(5 downto 0);
      extended_immediate : out std_logic_vector(15 downto 0)
      );
end sign_extend;    
  
Architecture behavioural OF sign_extend IS
  
  begin
    process(clock,immediate(5))
      begin
        if(clock'event) then
          case(immediate(5)) is
            when '0' => extended_immediate <= std_logic_vector("0000000000" & immediate);
            when '1' => extended_immediate <= std_logic_vector("1111111111" & immediate);
            when others => extended_immediate <= std_logic_vector("0000000000" & immediate);
          end case;
        end if;
    end process;
  
end architecture;

