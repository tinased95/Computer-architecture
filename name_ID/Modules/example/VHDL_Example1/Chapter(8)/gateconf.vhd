library IEEE;
use IEEE.std_logic_1164.all;

entity FEWGATES is port (
  a,b,c,d: in std_logic;
  y: out std_logic
  );
end FEWGATES;

use work.and2;
use work.or2;
use work.inverter;

architecture structural of FEWGATES is

  component AND2 port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
  end component;

  component OR2 port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
  end component;

  component INVERTER port (
    i: in std_logic;
    o: out std_logic
    );
  end component;

signal a_and_b, c_and_d, not_c_and_d: std_logic;

-- Configution specifications

for all: and2 use entity work.and2(rtl);
for u3: inverter use entity work.inverter(rtl);
for u4: or2 use entity work.or2(rtl);

begin

  u1: and2 port map (i1 => a, i2 => b,
                     y => a_and_b
                     );

  u2: and2 port map (i1 => c, i2 => d,
                     y => c_and_d
                     );

  u3: inverter port map (i => c_and_d,
                         o => not_c_and_d);

  u4: or2 port map (i1 => a_and_b, i2 => not_c_and_d,
                    y => y
                    );
end structural;
