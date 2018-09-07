----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:05:45 03/06/2016 
-- Design Name: 
-- Module Name:    detect - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detect is

PORT(
        input : IN Std_logic;
        output : OUT std_logic;
        clk : IN Std_logic

       );
end detect;

architecture Behavioral of detect is

type statetype is (s0,s1,s2,s3,s4,s5,s6);
signal state: statetype;

begin
PROCESS(input,state,clk)
begin


 
    if (rising_edge(clk)) then
    output <= '0';
    CASE state is
    when s0 => if(input='0') then state <= s0;
                    else state <= s1;
                    
                    end if;
    when s1 => if(input='0') then state <= s2;
                    else state <= s1;
                    end if;
    when s2 => if(input='0') then state <= s0;
                    else state <= s3;
                    end if;
    when s3 => if(input='0') then state <= s1;
                    else state <= s4;
                    end if;
    when s4 => if(input='0') then state <= s5;
                    else state <= s1;
                            end if;
   when s5 => if(input='0') then state <= s0;
                    else state <= s6;
						    output <= '1';
                    end if;
   when s6 => if(input='0') then state <= s2;
	                 output <= '0';
                    else state <= s1;
						  output <= '0';
                     end if;
                    
    end CASE;
    end if;
    end PROCESS;


end Behavioral;

