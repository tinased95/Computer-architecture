library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tag_valid_array is
    port
    (   
    clk:in std_logic;
    wren:in std_logic;
    reset_n:in std_logic;
    invalidate:in std_logic;
    address:in std_logic_vector(5 downto 0);
    wrdata:in std_logic_vector(3 downto 0);
    output:out std_logic_vector(4 downto 0)
     );
end tag_valid_array;

architecture behavorial of tag_valid_array is

    type data_arrayy is array (63 downto 0) of std_logic_vector(4 downto 0);
    signal data_array : data_arrayy ;
    constant true : std_logic :='1';
    constant false : std_logic :='0';
    signal valid : std_logic;  
        
    begin
    process(clk)
    begin
      valid <= data_array(to_integer(unsigned(address)))(4);
      
        if(wren = '1') then
            data_array(to_integer(unsigned(address)))(3 downto 0) <= wrdata; -- tag
        end if;
   
        if(invalidate = '0') then
          valid <= true;
        else
          valid <= false;
        end if;
        if(reset_n = '1') then        
            data_array <= ((others=> (others=>'0')));
        end if;
        
        output <= data_array(to_integer(unsigned(address)));
        output(4) <= valid;
        
    end process;
end behavorial;