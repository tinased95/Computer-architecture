----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:25:13 03/06/2016 
-- Design Name: 
-- Module Name:    dff1 - Behavioral 
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

entity dff1 is

   PORT(
        clk, d:in std_logic;
        Q: out std_logic
    );

end dff1;

architecture Behavioral of dff1 is
begin
    
    PROCESS(clk)
    BEGIN
        if (rising_edge(clk)) then      
            if d='1' then 
                Q<='1';
            else 
                Q<='0';
            end if;
        end if;
    END PROCESS;

end Behavioral;
