LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;
USE IEEE.std_logic_arith.all;

entity basic_computer  IS 
port(

	clock : in std_logic;
	out1,out2 : out std_logic_vector(15 downto 0)
	--pc : in std_logic_vector(15 downto 0)
  );
end entity;

Architecture rtl OF basic_computer IS

	component sync_ram is
	port(
		clock   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector;
		datain  : in  std_logic_vector;
		dataout : out std_logic_vector
	    );
	end component;
	component ram_ins is
	port(
		clock   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector;
		datain  : in  std_logic_vector;
		dataout : out std_logic_vector
	    );
	end component;
	component register_set is
	port(
		clock   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector;
		datain  : in  std_logic_vector;
		dataout : out std_logic_vector
		);
	end component;
	component alu  IS 
	port(
	  clock : in std_logic ;
		a,b : in std_logic_vector(15 downto 0);
		func : in std_logic_vector(2 downto 0);
		less_than, cout, zero: out std_logic;
		result : out std_logic_vector(15 downto 0)
	);
	end component;
	component sign_extend is 
	port(
		clock : in std_logic;
		immediate : in std_logic_vector(5 downto 0);
		extended_immediate : out std_logic_vector(15 downto 0)
		);
	end component; 
	component extend is 
	port(
		clock : in std_logic;
		immediate : in std_logic_vector(5 downto 0);
		extended_immediate : out std_logic_vector(15 downto 0)
		);
	end component; 
	component branch is
	port(
        clock : in std_logic;
        immediate : in std_logic_vector(5 downto 0);
        pc : in std_logic_vector(15 downto 0);
        branch : out std_logic_vector(15 downto 0)
		);
	end component;
	component jump is 
	port (
        clock: in std_logic;
        pc : in std_logic_vector(15 downto 0);
        immediate: in std_logic_vector(11 downto 0);
        jump : out std_logic_vector(15 downto 0)
	);
	end component;
	component exsll is 
	port (
        clock: in std_logic;
        input: in std_logic_vector(15 downto 0);
		immediate: in std_logic_vector(5 downto 0);
        result : out std_logic_vector(15 downto 0)
	);
	end component;
	component exsrl is 
	port (
        clock: in std_logic;
        input: in std_logic_vector(15 downto 0);
		immediate: in std_logic_vector(5 downto 0);
        result : out std_logic_vector(15 downto 0)
	);
	end component;
	component exsra is 
	port (
        clock: in std_logic;
        input: in std_logic_vector(15 downto 0);
		immediate: in std_logic_vector(5 downto 0);
        result : out std_logic_vector(15 downto 0)
	);
	end component;
	
	
	signal dest8,read_ins : std_logic_vector(7 downto 0);
	signal ir : std_logic_vector(15 downto 0);
	signal pc :  std_logic_vector(15 downto 0);
	signal dest16,immediate, dataout, branch_out, jump_out : std_logic_vector(15 downto 0);
	signal less_than,cout,zero : std_logic;
	type state_type is(start,fetch,decode,execute_Rtype,addi,andi,ori,exe_sll,exe_srl,exe_sra,lhw,shw,beq,bne,blt,bgt,ble,bge,sjump);
	signal state : state_type;
	signal ram0_out,ram1_out : std_logic_vector(7 downto 0);
	signal source1_out,source2_out,alu_out,source3_out,register_set_in,register_ac :  std_logic_vector(15 downto 0);
	signal reg_set_addr_in,reg_addr_read1,reg_addr_read2 : std_logic_vector(2 downto 0);
	signal addi_out,andi_out,ori_out,sll_out,srl_out, sra_out : std_logic_vector(15 downto 0);
	signal mem_data_write, mem_data_read, ls_addr : std_logic_vector(15 downto 0);
	signal pcplus, ls_addr_plus : std_logic_vector(15 downto 0);
	signal funcr : std_logic_vector(2 downto 0);
	signal imm : std_logic_vector(5 downto 0);
	signal jmp : std_logic_vector(11 downto 0);
	signal addr1,addr2 : std_logic_vector(7 downto 0);
	begin
	--fetch state
	ram0 : ram_ins port map (clock, '0', pc, "00000000", ram0_out); 
	ram1 : ram_ins port map (clock, '0',pcplus, "00000000", ram1_out); 
	
	--write on register set
	write_reg : register_set port map(clock, '1', reg_set_addr_in, register_set_in, dataout);
	--read from register set
	read1_reg : register_set port map(clock, '0', reg_addr_read1, "0000000000000000", source1_out);
	read2_reg : register_set port map(clock, '0', reg_addr_read2, "0000000000000000",source2_out);
	

	--addi andi ori
	sign_ex : sign_extend port map(clock, imm, immediate);
	addi_exe : alu port map(clock, source1_out, immediate, "000", less_than, cout, zero, addi_out );
	ori_exe  : alu port map(clock, source1_out, immediate, "011", less_than, cout, zero, ori_out  );
	andi_exe : alu port map(clock, source1_out, immediate, "010", less_than, cout, zero, andi_out );
	
	--Rtype execution
	alu_exeee : alu port map(clock, source1_out, source2_out, funcr, less_than, cout, zero, register_ac);
	
	
	--sll srl sra
	exsll0 : exsll port map(clock, source1_out, imm, sll_out);
	exsrl0 : exsrl port map(clock, source1_out, imm, srl_out);
	exsra0 : exsra port map(clock, source1_out, imm, sra_out);
	
	--lhw shw
	ex : extend port map(clock, imm, immediate);
	addls : alu port map(clock, source1_out, immediate, "000", less_than, cout, zero, ls_addr );
	read_ram1  : sync_ram port map (clock, '0', ls_addr, 					  "00000000", addr1 );
	read_ram2  : sync_ram port map (clock, '0', ls_addr_plus, "00000000", addr2);
	write_ram1 : sync_ram port map (clock, '1', ls_addr, 					  addr1 , dest8);
	write_ram2 : sync_ram port map (clock, '1', ls_addr_plus, addr2 , dest8);
	
	--branch
	compare : alu port map(clock, source1_out, source2_out, "001", less_than, cout, zero, dest16 );
	brn : branch port map (clock,imm, pc, branch_out);
	
	--jump
	jml : jump port map(clock, pc, jmp, jump_out);
	  
		--*************************************
	read1_reg_out1 : register_set port map(clock, '0', "010", "0000000000000000", out1);
	read2_reg_out2 : register_set port map(clock, '0', "011", "0000000000000000", out2);
	
	--**************************************	  
	  
	  
	  
	  
	--state <= start;
	pc <= "0000000000000000";
	process (clock)
	begin
	
		case state is
			when start =>
			
				state <= fetch;
			-- fetch instruction from memory and add 1 to pc
			when fetch =>
				ir(15 downto 8) <= ram0_out;
				pcplus <= pc + "0000000000000001";
				ir(7 downto 0) <= ram1_out;
				pc <= pc + "0000000000000010";
				state <= decode;

			when decode =>
				case ir(15 downto 12) is 
					when "0000" => 
						state <= execute_Rtype;
					when "0001" => 
						state <= addi;
					when "0010" => 
						state <= andi;
					when "0011" => 
						state <= ori;
					when "0100" => 
						state <= exe_sll;
					when "0101" => 
						state <= exe_srl;
					when "0110" => 
						state <= exe_sra;
					when "0111" => 
						state <= lhw;
					when "1000" => 
						state <= shw;
					when "1001" => 
						state <= beq;
					when "1010" => 
						state <= bne;
					when "1011" => 
						state <= blt;
					when "1100" => 
						state <= bgt;
					when "1101" => 
						state <= ble;
					when "1110" => 
						state <= bge;
					when "1111" => 
						state <= sjump;
					when others => 
						state <= decode;
				end case;
			
			when execute_Rtype =>
			  funcr <= ir(2 downto 0);
				reg_addr_read1 <= ir(11 downto 9);
				reg_addr_read2 <= ir(8 downto 6);
				if(ir(2 downto 0) = "111") then
					pc <= source1_out;
				else
					reg_set_addr_in <= ir(5 downto 3);
					register_set_in <= register_ac;
				end if;
				state <= fetch;
				
			when addi =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= addi_out;
				state <= fetch;
				
			when andi =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= andi_out;
				state <= fetch;
				
			when ori =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= ori_out;
				state <= fetch;
			
			when exe_sll =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= sll_out;
				state <= fetch;
				
			when exe_srl =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= srl_out;
				state <= fetch;
				
			when exe_sra =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= sra_out;
				state <= fetch;
			
			when lhw =>
			  ls_addr_plus <= ls_addr + "0000000000000001";
			  addr1 <= ls_addr(15 downto 8);
			  addr2 <= ls_addr(7  downto 0);
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_set_addr_in <= ir(8 downto 6);
				register_set_in <= mem_data_read;
				state <= fetch;
				
			when shw =>
			  ls_addr_plus <= ls_addr + "0000000000000001";
			  addr1 <= ls_addr(15 downto 8);
			  addr2 <= ls_addr(7  downto 0);
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				mem_data_write <= source2_out;
				state <= fetch;
				
			when beq => 
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(zero = '1') then
					pc <= branch_out;
				end if;
				state <= fetch;
			
			when bne =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(zero = '0') then
					pc <= branch_out;
				end if;
				state <= fetch;
				
			when blt =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(less_than = '1') then
					pc <= branch_out;
				end if;
				state <= fetch;
			
			when bgt =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(less_than = '0') then
					pc <= branch_out;
				end if;
				state <= fetch;
				
			when ble =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(zero = '1') or (less_than = '1') then
					pc <= branch_out;
				end if;
				state <= fetch;
		
			when bge =>
			  imm <= ir(5 downto 0);
				reg_addr_read1  <= ir(11 downto 9);
				reg_addr_read2  <= ir(8 downto 6);
				if(zero = '1') or (less_than = '0') then
					pc <= branch_out;
				end if;
				state <= fetch;
				
			when sjump =>
			  jmp <= ir(11 downto 0);
				pc <= jump_out;
				state <= fetch;
				
			when others =>
				  state <= fetch;
		end case;
	end process;
  
end architecture;


--test bench
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_signed.all;
USE IEEE.std_logic_arith.all;

entity basic_computer_tb  IS 
end entity;

Architecture rtl OF basic_computer_tb IS
  component basic_computer  IS 
  port(

	clock : in std_logic;
	out1,out2 : out std_logic_vector(15 downto 0)
	--pc : in std_logic_vector(15 downto 0)
  );
end component;
  
   signal  clock : std_ulogic := '1';
   signal out1,out2 : std_logic_vector(15 downto 0);
begin
  mapcom : basic_computer port map(clock,out1,out2);
   clock <= not clock after 5 ns;
  
  
  
end architecture;



