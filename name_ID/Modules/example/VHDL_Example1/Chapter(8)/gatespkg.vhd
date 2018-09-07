library IEEE;
use IEEE.std_logic_1164.all;

package GatesPkg is

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

end GatesPkg;
