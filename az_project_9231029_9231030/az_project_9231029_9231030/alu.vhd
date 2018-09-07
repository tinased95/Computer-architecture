-- ALU entity 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;
USE IEEE.std_logic_arith.all;

entity alu  IS 
port(
    clock : in std_logic;
    a,b : in std_logic_vector(15 downto 0);
    func : in std_logic_vector(2 downto 0);
    less_than, cout, zero: out std_logic;
    result : out std_logic_vector(15 downto 0)
);
end entity;

Architecture behavioural OF alu IS

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

	--sub component
	component sub IS 
	   Port(
		   a,b : IN STD_LOGIC_VECTOR(15 downto 0);
			ci     :IN STD_logic; 
			cout    :out STD_logic; 
			sub   :OUT STD_logic_vector(15 downto 0) 
			);
	END component;
	--end of sub component
	signal add_result, sub_result,slt_result,sresult : std_logic_vector(15 downto 0);
	begin
	
	s1 : sub port map(a,b,'1',cout,sub_result);
	a1 : add port map(a,b,'0',cout,add_result);
	s2 : sub port map(a,b,'1',less_than,slt_result);
	
	process(func, clock)
	begin
		if(clock'event) then
			case func(2 downto 0) is
				when "000" => 
				  sresult <= add_result;
				when "001" => 
				  sresult <= sub_result;
				when "010" => 
				  sresult <= a and b;
				when "011" => 
				  sresult <= a or  b;
				when "100" => 
				  sresult <= a xor b;
				when "101" => 
				  sresult <= a nor b;
				when "110" =>  
				  sresult <= slt_result;
				when others => 
				  sresult <= a and b;
			end case;
			case sresult(15 downto 0) is
		    when "0000000000000000" =>
		    zero <= '1';
	     
	      when others =>
		    zero <= '0';
	   end case;
	   result <= sresult;
		end if;
		
	end process;
	
END architecture;
--END of alu entity

-- add entity

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY fulladder IS 
   Port(
        a,b,ci     :IN STD_logic; 
        sum,cout   :OUT STD_logic );
END fulladder;

Architecture behavioural OF fulladder IS

  BEGIN
	sum <= a xor b xor ci;
	cout <= (a and b) OR (a and ci) OR (b and ci);
 END ARCHITECTURE;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY add IS 
   Port(
       a,b : IN STD_LOGIC_VECTOR(15 downto 0);
        ci     :IN STD_logic; 
        cout    :out STD_logic; 
        sum   :OUT STD_logic_vector(15 downto 0) 
        );
END add;

Architecture behavioural OF add IS
  signal carry : std_logic_vector(16 downto 0);
  component fulladder IS 
   Port(
        a,b,ci     :IN STD_logic; 
        sum,cout   :OUT STD_logic );
END component;
  BEGIN
   carry(0) <= ci; 
   LGEN : for i in 0 to 15 generate
     lful : fulladder port map(a=>a(i), b=>b(i), ci => carry(i), sum=>sum(i),  cout=>carry(i+1));
   end generate; 
	cout <= carry(16);
 END ARCHITECTURE;
 --end of add entity
 
 
 -- sub entity
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;

ENTITY sub IS 
   Port(
       a,b : IN STD_LOGIC_VECTOR(15 downto 0);
        ci     :IN STD_logic; 
        cout    :out STD_logic; 
        sub   :OUT STD_logic_vector(15 downto 0) 
        );
END sub;

Architecture behavioural OF sub IS
  component fulladder IS 
   Port(
        a,b,ci     :IN STD_logic; 
        sum,cout   :OUT STD_logic );
END component;
  signal carry : std_logic_vector(16 downto 0);
  signal bb :std_logic_vector(15 downto 0);
 BEGIN 
  bb <= b xor "1111111111111111";
   carry(0) <= ci; 
   LGEN : for i in 0 to 15 generate
     lful2 : fulladder port map(a=>a(i), b=>bb(i), ci => carry(i), sum=>sub(i),  cout=>carry(i+1)
     );
   end generate; 
	cout <= carry(16);
 END ARCHITECTURE;
 --end of sub entity


