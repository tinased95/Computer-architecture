LIBRARY ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(
      reached : out std_logic;
      rw : in std_logic;
      clk : in std_logic;
      address : in std_logic_vector(5 downto 0);
      data_in : in std_logic_vector(31 downto 0);
      ram_ready : in std_logic; -- motmaen nistim
      data_ready : out std_logic;
      data_out : out std_logic_vector(31 downto 0)
     );
end ram;

architecture behavorial of ram is
   type data_arrayy is array (1023 downto 0) of std_logic_vector(31 downto 0);
    signal data_array : data_arrayy;
  begin
    process(clk)
    begin
  if(rw = '1') then
  data_array(to_integer(unsigned(address))) <= data_in;
  end if;
  if(ram_ready= '1')then
  data_ready <= '1';
  end if;
data_out <= data_array(to_integer(unsigned(address)));
  end process;

end behavorial;

