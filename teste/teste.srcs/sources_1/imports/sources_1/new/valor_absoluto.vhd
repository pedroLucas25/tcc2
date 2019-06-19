library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity valor_absoluto is
    Port ( clk, reset : in std_logic;
           in1 : in STD_LOGIC_VECTOR (15 downto 0);
           in2 : in STD_LOGIC_VECTOR (15 downto 0);
           in3 : in STD_LOGIC_VECTOR (15 downto 0);
           in4 : in STD_LOGIC_VECTOR (15 downto 0);
           out1 : out STD_LOGIC_VECTOR (15 downto 0);
           out2 : out STD_LOGIC_VECTOR (15 downto 0);
           out3 : out STD_LOGIC_VECTOR (15 downto 0);
           out4 : out STD_LOGIC_VECTOR (15 downto 0));
end valor_absoluto;

architecture Behavioral of valor_absoluto is

signal aux_saida1 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_saida2 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_saida3 : std_logic_vector(15 downto 0) := (others => '0');
signal aux_saida4 : std_logic_vector(15 downto 0) := (others => '0');

begin

saida_1: process(clk, reset)

begin

if (reset = '1') then
    aux_saida1 <= (others => '0');
elsif rising_edge(clk) then
    aux_saida1 <= std_logic_vector(abs(signed(in1)));
end if;

end process;

saida_2: process(clk, reset)

begin

if (reset = '1') then
    aux_saida2 <= (others => '0');
elsif rising_edge(clk) then
    aux_saida2 <= std_logic_vector(abs(signed(in2)));
end if;

end process;

saida_3: process(clk, reset)

begin

if (reset = '1') then
    aux_saida3 <= (others => '0');
elsif rising_edge(clk) then
    aux_saida3 <= std_logic_vector(abs(signed(in3)));
end if;

end process;

saida_4: process(clk, reset)

begin

if (reset = '1') then
    aux_saida4 <= (others => '0');
elsif rising_edge(clk) then
    aux_saida4 <= std_logic_vector(abs(signed(in4)));
end if;

end process;

out1 <= aux_saida1;
out2 <= aux_saida2;
out3 <= aux_saida3;
out4 <= aux_saida4;


end Behavioral;
