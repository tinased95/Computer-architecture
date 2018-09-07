library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity sync_ram is
  port (
    clock   : in  std_logic;
    we      : in  std_logic;
    address : in  std_logic_vector(15 downto 0);
    datain  : in  std_logic_vector(7  downto 0);
    dataout : out std_logic_vector(7  downto 0)
  );
end entity sync_ram;

architecture RTL of sync_ram is

   type ram_type is array (0 to (2**16)-1) of std_logic_vector(7 downto 0);
   signal ram : ram_type;
   --signal read_address : std_logic_vector(15 downto 0);

begin

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