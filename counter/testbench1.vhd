--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:21 02/28/2016
-- Design Name:   
-- Module Name:   C:/Documents and Settings/first/testbench1.vhd
-- Project Name:  first
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: first1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbench1 IS
END testbench1;
 
ARCHITECTURE behavior OF testbench1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT first1
    PORT(
         a : IN  std_logic_vector (2 DOWNTO 0);
         b : IN  std_logic_vector (7 DOWNTO 0);
         c : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector (2 DOWNTO 0):="100" ;
   signal b : std_logic_vector (7 DOWNTO 0):="00011101";

 	--Outputs
   signal c : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: first1 PORT MAP (
          a => a,
          b => b,
          c => c
        );
--	a<='1' after 100ns,'0' after 200ns;
	--b<='0' after 50ns,'1' after 150ns;
	a<="100" after 100 ns,"011" after 200 ns;
	b<="00011101";
	
	
   -- Clock process definitions
 --  <clock>_process :process
   --begin
	--	<clock> <= '0';
		--wait for <clock>_period/2;
		--<clock> <= '1';
		--wait for <clock>_period/2;
   --end process;
 

   -- Stimulus process
   --stim_proc: process
   --begin		
      -- hold reset state for 100 ns.
     -- wait for 100 ns;	

   --   wait for <clock>_period*10;

      -- insert stimulus here 

     -- wait;
   --end process;

END;
