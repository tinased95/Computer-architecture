library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram_ins is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(15 downto 0);
    datain  : in  std_logic_vector(7 downto 0);
    dataout : out std_logic_vector(7 downto 0)
  );
end entity ram_ins;

architecture RTL of ram_ins is

   type ram_type is array (0 to (2**16)-1) of std_logic_vector (7 downto 0);
   signal ram : ram_type;
   signal read_address : std_logic_vector(15 downto 0);

begin
  ram(0) <= "00000000";
  ram(1) <= "01010000";
  ram(2) <= "00000000";
  ram(3) <= "01011001";
  RamProc: process(clock) is
  
  begin
    if (clock'event) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      end if;
      read_address <= address;
    end if;
  end process RamProc;

  dataout <= ram(to_integer(unsigned(read_address)));

end architecture RTL;

