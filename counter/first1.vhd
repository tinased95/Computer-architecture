----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:07:13 02/28/2016 
-- Design Name: 
-- Module Name:    first1 - Behavioral 
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

entity first1 is
PORT(
		a : in STD_LOGIC_VECTOR (2 DOWNTO 0);
		b : in STD_LOGIC_VECTOR (7 DOWNTO 0);
		c : out STD_LOGIC
	);

end first1;

architecture Behavioral of first1 is
begin

with a select
   c <= b(0) when "000",
		  b(1) when "001",
		  b(2) when "010",
		  b(3) when "011",
		  b(4) when "100",
		  b(5) when "101",
		  b(6) when "110",
		  b(7) when "111";





end Behavioral;









