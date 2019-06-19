library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
--use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity top_level_tb is
end;

architecture bench of top_level_tb is

  component top_level
      Port ( clk, reset : in std_logic;
             in1 : in STD_LOGIC_VECTOR (15 downto 0);
             in2 : in STD_LOGIC_VECTOR (15 downto 0);
             in3 : in STD_LOGIC_VECTOR (15 downto 0);
             in4 : in STD_LOGIC_VECTOR (15 downto 0);
             saida_final : out std_logic_vector (15 downto 0));
--             saida1 : out signed (31 downto 0);
--             saida2 : out signed (31 downto 0);
--             saida3 : out signed (31 downto 0);
--             saida4 : out signed (31 downto 0));
  end component;

  signal clk, reset: std_logic;
  signal in1: STD_LOGIC_VECTOR (15 downto 0);
  signal in2: STD_LOGIC_VECTOR (15 downto 0);
  signal in3: STD_LOGIC_VECTOR (15 downto 0);
  signal in4: STD_LOGIC_VECTOR (15 downto 0);
--  signal saida1: signed (31 downto 0);
--  signal saida2: signed (31 downto 0);
--  signal saida3: signed (31 downto 0);
--  signal saida4: signed (31 downto 0);
  
  signal saida_final : std_logic_vector (15 downto 0) := (others => '0');
  
  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: top_level port map ( clk    => clk,
                            reset  => reset,
                            in1    => in1,
                            in2    => in2,
                            in3    => in3,
                            in4    => in4,
                            saida_final => saida_final);
--                            saida1 => saida1,
--                            saida2 => saida2,
--                            saida3 => saida3,
--                            saida4 => saida4 );
                            
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
--              write (out_line, std_logic_vector(saida1));
--              writeline (out_file, out_line);
--      end if;  
--  end process;
  
  read_sinal2_file: process  
  file infile    : text is in "sinal2.txt"; -- input file declaration
  variable inline : line; -- line number declaration
  variable dataf  : std_logic_vector(15 downto 0); 
  begin
  in2 <= "0000000000000000"; 
      while (not endfile(infile)) loop
          readline(infile, inline);
          read(inline,dataf);
          in2 <= dataf;
          wait for 10 ns;
      end loop;
      assert not endfile(infile) report "FIM DA LEITURA" severity warning;
      wait;        
  end process;
  
--  write_sinal2_file: process(clk) 
--  variable out_line : line;
--  file out_file     : text is out "res_sinal2.txt";
--  begin
--      -- write line to file every clock
--      if (rising_edge(clk)) then
--              write (out_line, std_logic_vector(saida2));
--              writeline (out_file, out_line);
--      end if;  
--  end process;
  
  read_sinal3_file: process  
  file infile    : text is in "sinal3.txt"; -- input file declaration
  variable inline : line; -- line number declaration
  variable dataf  : std_logic_vector(15 downto 0); 
  begin
  in3 <= "0000000000000000"; 
      while (not endfile(infile)) loop
          readline(infile, inline);
          read(inline,dataf);
          in3 <= dataf;
          wait for 10 ns;
      end loop;
      assert not endfile(infile) report "FIM DA LEITURA" severity warning;
      wait;        
  end process;
  
--  write_sinal3_file: process(clk) 
--  variable out_line : line;
--  file out_file     : text is out "res_sinal3.txt";
--  begin
--      -- write line to file every clock
--      if (rising_edge(clk)) then
--              write (out_line, std_logic_vector(saida3));
--              writeline (out_file, out_line);
--      end if;  
--  end process;
  
  read_sinal4_file: process  
  file infile    : text is in "sinal4.txt"; -- input file declaration
  variable inline : line; -- line number declaration
  variable dataf  : std_logic_vector(15 downto 0); 
  begin
  in4 <= "0000000000000000"; 
      while (not endfile(infile)) loop
          readline(infile, inline);
          read(inline,dataf);
          in4 <= dataf;
          wait for 10 ns;
      end loop;
      assert not endfile(infile) report "FIM DA LEITURA" severity warning;
      wait;        
  end process;
  
--  write_sinal4_file: process(clk) 
--  variable out_line : line;
--  file out_file     : text is out "res_sinal4.txt";
--  begin
--      -- write line to file every clock
--      if (rising_edge(clk)) then
--              write (out_line, std_logic_vector(saida4));
--              writeline (out_file, out_line);
--      end if;  
--  end process;

  write_sinal1_file: process(clk) 
  variable out_line : line;
  file out_file     : text is out "res_sinal_final.txt";
  begin
      -- write line to file every clock
      if (rising_edge(clk)) then
              write (out_line, saida_final);
              writeline (out_file, out_line);
      end if;  
  end process;

end;