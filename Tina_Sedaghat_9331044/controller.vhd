library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
    port(
         write : in std_logic;
         read : in std_logic;
         address : in std_logic_vector(5 downto 0);
         clk : in std_logic;
         hit : in std_logic;
         reached : in std_logic;
         invalidate : out std_logic := '0';
         ram_write : out std_logic := '0'; --
         ram_read : out std_logic := '0'; --
         cache_write : out std_logic := '0' --
        
     ); 
end entity;

architecture behavorial of controller is
  signal ram_ready : std_logic;
  signal invalid : std_logic;
begin
    process(clk)
     
      begin
       --  invalid <= invalidate;
      if(write = '1') then
       invalidate <= '1' ;
       ram_write <= '1';
       cache_write <= '0';
     --  valid(4) <= '0';
    end if;
    if (read = '1') then --     
      if(hit = '1')then -- hit shod
      if(invalid = '0') then
     -- state 0
      end if;
      
    --  else miss shod
    ram_read <= '1';
    if(reached = '1')then
    ram_ready <= '1';
    cache_write <= '1';
    ram_write <= '0';
    ram_read <='0';
    -- state 0
    end if;
  end if;
end if;
       
  
    end process;
end behavorial;