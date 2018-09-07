configuration SimpleGatesCfg of FEWGATES is

  for structural

    for u1: and2
      use entity work.and2(rtl);
    end for;

    for u2: and2
      use entity work.and2(rtl);
    end for;

    for u3: inverter
      use entity work.inverter(rtl);
    end for;

    for u4: or2
      use entity work.or2(rtl);
    end for;

  end for;

end SimpleGatesCfg;
