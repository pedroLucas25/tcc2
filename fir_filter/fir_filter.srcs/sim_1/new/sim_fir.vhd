-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
--use IEEE.Numeric_Std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity filtro_fir_tb is
end;

architecture bench of filtro_fir_tb is

  component filtro_fir
      GENERIC (n: INTEGER := 101; m: INTEGER := 16);
      PORT ( x: IN SIGNED(16-1 downto 0);
             clk, rst: IN STD_LOGIC;
             y: OUT SIGNED(2*16-1 downto 0));
  end component;

  signal x: SIGNED(15 downto 0);
  signal clk, rst: STD_LOGIC;
  signal y: SIGNED(31 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: filtro_fir generic map ( n   => 101,
                                m   =>  16)
                     port map ( x   => x,
                                clk => clk,
                                rst => rst,
                                y   => y );

  stimulus: process
  begin
  
    -- Put initialisation code here
    x <= "0000000000000000";
    rst <='1'; wait for 10 ns; rst <= '0'; wait for 10 ns;


    -- Put test bench stimulus code here
    x <= "0000000000000001";wait for 10 ns;
    x <= "0000000000000000";
    
--    x <= "0101"; wait for 10 ns;
--    x <= "1010"; wait for 10 ns;
--    x <= "1111"; wait for 10 ns;
--    x <= "0100"; wait for 10 ns;
--    x <= "1001"; wait for 10 ns;
--    x <= "1110"; wait for 10 ns;

    --stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;