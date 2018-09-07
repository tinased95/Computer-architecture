library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;



entity branch is
  port(
        clock : in std_logic;
        immediate : in std_logic_vector(5 downto 0);
        pc : in std_logic_vector(15 downto 0);
        branch : out std_logic_vector(15 downto 0)
      );
end branch;

architecture behavioural of branch is
 
 
    
  -- component of sign extend  
 component sign_extend is 
  port (
      clock : in std_logic;
      immediate : in std_logic_vector(5 downto 0);
      extended_immediate : out std_logic_vector(15 downto 0)
      );
end component; 
  --end
  
  --add component
	component add IS 
	Port(
			a,b    : IN STD_LOGIC_VECTOR(15 downto 0);
			ci     :IN STD_logic; 
			cout   :out STD_logic; 
			sum    :OUT STD_logic_vector(15 downto 0) 
			);
	END component;
	--end of add component
	signal exim,eximout,eximout2 : std_logic_vector(15 downto 0);
  signal sum : std_logic_vector(15 downto 0);
  signal carry :std_logic; 
  
  begin
  a1 : sign_extend port map(clock, immediate,eximout);
  exim <= eximout;
  --branch process
  process(clock)
    begin
    if(clock'event) then
      exim <= exim(14 downto 0) & "0"; 
      eximout2 <= exim;
    end if;
  end process;
  add1 : add port map(a => eximout2, b => pc, ci => '0',sum=>sum, cout => carry);
  add2 : add port map(a => "0000000000000100", b => sum, ci => carry,sum=>branch);
end architecture;
