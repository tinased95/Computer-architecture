library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_cache is
    port(
         reset_n,clk,read,write: in std_logic;
         addr : in std_logic_vector(9 downto 0);
         wrdata: in std_logic_vector(31 downto 0);
         rddata: out std_logic_vector(31 downto 0);
         hit: out std_logic
     );
end ram_cache;

architecture behavorial of ram_cache is
   
  
     component ram is
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
    end component;
    component cache is
    port(
    clk, wren, reset_n :in std_logic;
    address_cache:in std_logic_vector(9 downto 0);
    wrdata:in std_logic_vector(31 downto 0);
		data:out std_logic_vector(31 downto 0)
     );
  end component;
  component controller is
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
     end component;
   begin
end behavorial;