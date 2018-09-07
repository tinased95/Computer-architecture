library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity miss_hit_logic is
    port(
         clk : in std_logic;
         tag : in std_logic_vector(3 downto 0);
         w0 : in std_logic_vector(4 downto 0); -- tag
         w1 : in std_logic_vector(4 downto 0);-- valid
         hit : out std_logic := '0';
         w0_valid : out std_logic; -- 0 way
         w1_valid : out std_logic -- 1 way
     );
end miss_hit_logic;

architecture behavorial of miss_hit_logic is
  
  begin
  process(clk)
   begin
 
 	if(tag(0) = w0(0) and tag(1)=w0(1) and tag(2)=w0(2) and tag(3)=w0(3) and w0(4)='1')then
 			hit<='1';
      w0_valid <= '1';
		else
		  hit <= '0';
			w0_valid <= '0';
		end if;
		if(tag(0) = w1(0) and tag(1)=w1(1) and tag(2)=w1(2) and tag(3)=w1(3) and w1(4)='1')then
			hit<='1';
      w1_valid <= '1';
		else
	 		hit <= '0';
			w1_valid <= '0';
	
  end if;
 end process;
  
end behavorial;
