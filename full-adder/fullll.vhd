----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:06 02/28/2016 
-- Design Name: 
-- Module Name:    fullll - Behavioral 
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

entity fullll is

port (
a , b ,cin : in std_logic;
sum , cout : out std_logic
);
end fullll;

architecture Behavioral of fullll is

signal s1 , s2 , s3 : std_logic;
begin
s1<= a xor b;
s2 <= a and b;
s3 <= s1 and cin;
sum <= s1 xor cin;
cout<=s2 or s3;


end Behavioral;

