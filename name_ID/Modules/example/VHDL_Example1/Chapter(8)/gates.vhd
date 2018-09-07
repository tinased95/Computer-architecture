library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end AND2;

architecture rtl of AND2 is

begin

  y <= '1' when i1 = '1' and i2 = '1' else '0';

end rtl;

library IEEE;
use IEEE.std_logic_1164.all;

entity OR2 is port (
    i1: in std_logic;
    i2: in std_logic;
    y: out std_logic
    );
end OR2;

architecture rtl of OR2 is

begin

  y <= '1' when i1 = '1' or i2 = '1' else '0';

end rtl;

library IEEE;
use IEEE.std_logic_1164.all;

entity INVERTER is port (
    i: in std_logic;
    o: out std_logic
    );
end INVERTER;

architecture rtl of INVERTER is

begin

  o <= not i;

end rtl;

library IEEE;
use IEEE.std_logic_1164.all;

entity FEWGATES is port (
  a,b,c,d: in std_logic;
  y: out std_logic
  );
end FEWGATES;

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

begin

  u1: and2 port map (i1 => a ,
                     i2 => b,
                     y => a_and_b
                     );

  u2: and2 port map (i1 => c,
                     i2 => d,
                     y => c_and_d
                     );

  u3: inverter port map (i => c_and_d,
                         o => not_c_and_d);

  u4: or2 port map (i1 => a_and_b,
                    i2 => not_c_and_d,
                    y => y
                    );
end structural;
