library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity in_read1_tb is
end;

architecture bench of in_read1_tb is

  component in_read1
      Port ( in1 : in std_logic_vector (15 downto 0);
             out1 : out std_logic_vector (15 downto 0);
             out2 : out std_logic_vector (15 downto 0);
             clk : in STD_LOGIC;
             reset : in STD_LOGIC);
  end component;

  signal in1: std_logic_vector (15 downto 0);
  signal out1: std_logic_vector (15 downto 0);
  signal out2: std_logic_vector (15 downto 0);
  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: in_read1 port map ( in1   => in1,
                           out1  => out1,
                           out2  => out2,
                           clk   => clk,
                           reset => reset );

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
  
  read_sinal1_file: process  
  file infile    : text is in "sinal1.txt"; -- input file declaration
  variable inline : line; -- line number declaration
  variable dataf  : std_logic_vector(15 downto 0); 
  begin
  in1 <= "0000000000000000"; 
  reset <= '0';
      while (not endfile(infile)) loop
          readline(infile, inline);
          read(inline,dataf);
          in1 <= dataf;
          wait for 10 ns;
      end loop;
      assert not endfile(infile) report "FIM DA LEITURA" severity warning;
      wait;        
  end process;
      
--  write_sinal1_file: process(clk) 
--  variable out_line : line;
--  file out_file     : text is out "res_sinal1.txt";
--  begin
--      -- write line to file every clock
--      if (rising_edge(clk)) then
--              write (out_line, out1);
--              writeline (out_file, out_line);
--      end if;  
--  end process;

end;