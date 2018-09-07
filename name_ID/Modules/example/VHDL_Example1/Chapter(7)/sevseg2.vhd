library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sevenSegment is port (
  bcdInputs: in std_logic_vector (3 downto 0);
  a_n, b_n, c_n, d_n,
  e_n, f_n, g_n: out std_logic
  );
end sevenSegment;

architecture behavioral of sevenSegment is

signal la_n, lb_n, lc_n, ld_n, le_n, lf_n, lg_n: std_logic;
signal oe: std_logic;

begin

  bcd2sevSeg: process (bcdInputs) begin

  -- Assign default to "off"
    la_n <= '1';    lb_n <= '1';
    lc_n <= '1';    ld_n <= '1';
    le_n <= '1';    lf_n <= '1';
    lg_n <= '1';

    case bcdInputs is
      when "0000" => la_n <= '0';        lb_n <= '0';
                     lc_n <= '0';        ld_n <= '0';
                     le_n <= '0';        lf_n <= '0';

      when "0001" => lb_n <= '0';        lc_n <= '0';

      when "0010" => la_n <= '0';        lb_n <= '0';
                     ld_n <= '0';        le_n <= '0';
                     lg_n <= '0';

      when "0011" => la_n <= '0';        lb_n <= '0';
                     lc_n <= '0';        ld_n <= '0';
                     lg_n <= '0';

      when "0100" => lb_n <= '0';        lc_n <= '0';
                     lf_n <= '0';        lg_n <= '0';

      when "0101" => la_n <= '0';        lc_n <= '0';
                     ld_n <= '0';        lf_n <= '0';
                     lg_n <= '0';

      when "0110" => la_n <= '0';        lc_n <= '0';
                     ld_n <= '0';        le_n <= '0';
                     lf_n <= '0';        lg_n <= '0';

      when "0111" => la_n <= '0';        lb_n <= '0';
                     lc_n <= '0';

      when "1000" => la_n <= '0';        lb_n <= '0';
                     lc_n <= '0';        ld_n <= '0';
                     le_n <= '0';        lf_n <= '0';
                     lg_n <= '0';

      when "1001" => la_n <= '0';        lb_n <= '0';
                     lc_n <= '0';        ld_n <= '0';
                     lf_n <= '0';        lg_n <= '0';

-- All other inputs possibilities are "don't care"

      when others => la_n <= 'X';        lb_n <= 'X';
                     lc_n <= 'X';        ld_n <= 'X';
                     le_n <= 'X';        lf_n <= 'X';
                     lg_n <= 'X';

    end case;

  end process bcd2sevSeg;

  -- Disable outputs for all invalid input values

  oe <= '1' when (bcdInputs < 10) else '0';

  a_n <= la_n when oe = '1' else 'Z';
  b_n <= lb_n when oe = '1' else 'Z';
  c_n <= lc_n when oe = '1' else 'Z';
  d_n <= ld_n when oe = '1' else 'Z';
  e_n <= le_n when oe = '1' else 'Z';
  f_n <= lf_n when oe = '1' else 'Z';
  g_n <= lg_n when oe = '1' else 'Z';


end behavioral;
