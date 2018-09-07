library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity register_set is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(2  downto 0);
    datain  : in  std_logic_vector(15 downto 0);
    dataout : out std_logic_vector(15 downto 0)
  );
end entity register_set;

architecture RTL of register_set is

   type ram_type is array (0 to 7) of std_logic_vector(15 downto 0);
   signal ram : ram_type;
  -- signal read_address : std_logic_vector(2 downto 0);

begin
  ram(0) <= "0000000000000000";
  ram(1) <= "0000000000000001";
  RamProc: process(clock) is

  begin
    if (clock'event) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      else
        dataout <= ram(to_integer(unsigned(address)));
      end if;
    end if;
  end process RamProc;
  
end architecture RTL;
