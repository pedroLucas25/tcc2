library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
--use ieee.numeric_std.all;

entity top_level is
    Port ( clk, reset : in std_logic;
           in1 : in STD_LOGIC_VECTOR (15 downto 0);
           in2 : in STD_LOGIC_VECTOR (15 downto 0);
           in3 : in STD_LOGIC_VECTOR (15 downto 0);
           in4 : in STD_LOGIC_VECTOR (15 downto 0);
           saida_final : out std_logic_vector (15 downto 0));
--           saida1 : out signed (31 downto 0);
--           saida2 : out signed (31 downto 0);
--           saida3 : out signed (31 downto 0);
--           saida4 : out signed (31 downto 0));
end top_level;

architecture Behavioral of top_level is

component valor_absoluto is
    Port ( clk, reset : in std_logic;
           in1 : in STD_LOGIC_VECTOR (15 downto 0);
           in2 : in STD_LOGIC_VECTOR (15 downto 0);
           in3 : in STD_LOGIC_VECTOR (15 downto 0);
           in4 : in STD_LOGIC_VECTOR (15 downto 0);
           out1 : out STD_LOGIC_VECTOR (15 downto 0);
           out2 : out STD_LOGIC_VECTOR (15 downto 0);
           out3 : out STD_LOGIC_VECTOR (15 downto 0);
           out4 : out STD_LOGIC_VECTOR (15 downto 0));
    end component; 
    
    component filtro_fir is
        GENERIC (n: INTEGER := 101; m: INTEGER := 16);
        PORT ( x: IN SIGNED(m-1 downto 0);
               clk, rst: IN STD_LOGIC;
               y: OUT SIGNED(2*m-1 downto 0));
    end component;
    
    signal aux_in1 : std_logic_vector(15 downto 0) := (others => '0');
    signal aux_in2 : std_logic_vector(15 downto 0) := (others => '0');
    signal aux_in3 : std_logic_vector(15 downto 0) := (others => '0');
    signal aux_in4 : std_logic_vector(15 downto 0) := (others => '0');
    
    signal aux_saida_final : std_logic_vector (15 downto 0) := (others => '0');
    
    signal aux_saida1 : signed(31 downto 0) := (others => '0');
    signal aux_saida2 : signed(31 downto 0) := (others => '0');
    signal aux_saida3 : signed(31 downto 0) := (others => '0');
    signal aux_saida4 : signed(31 downto 0) := (others => '0');

begin

saida_abs: valor_absoluto port map (
    clk => clk,
    reset => reset,
    in1 => in1,
    in2 => in2,
    in3 => in3,
    in4 => in4,
    out1 => aux_in1,
    out2 => aux_in2,
    out3 => aux_in3,
    out4 => aux_in4    
    );
    
filtro1: filtro_fir port map (
    x => signed(aux_in1),
    clk => clk,
    rst => reset,
    y => aux_saida1
);

filtro2: filtro_fir port map (
    x => signed(aux_in2),
    clk => clk,
    rst => reset,
    y => aux_saida2
);

filtro3: filtro_fir port map (
    x => signed(aux_in3),
    clk => clk,
    rst => reset,
    y => aux_saida3
);

filtro4: filtro_fir port map (
    x => signed(aux_in4),
    clk => clk,
    rst => reset,
    y => aux_saida4
);

escolha_sinal : process (clk, reset)
begin

if reset = '1' then
    aux_saida_final <= (others => '0');
elsif rising_edge(clk) then
    if ((aux_saida1 > aux_saida2) and (aux_saida1 > aux_saida3) and (aux_saida1 > aux_saida4)) then
        aux_saida_final <= in1;
    elsif ((aux_saida2 > aux_saida1) and (aux_saida2 > aux_saida3) and (aux_saida2 > aux_saida4)) then
        aux_saida_final <= in2;
    elsif ((aux_saida3 > aux_saida1) and (aux_saida3 > aux_saida2) and (aux_saida3 > aux_saida4)) then
        aux_saida_final <= in3;
    elsif ((aux_saida4 > aux_saida1) and (aux_saida4 > aux_saida2) and (aux_saida4 > aux_saida3)) then
        aux_saida_final <= in4;
    else
        aux_saida_final <= in1;
    end if;
end if;

end process;

saida_final <= aux_saida_final;

--saida1 <= aux_saida1;
--saida2 <= aux_saida2;
--saida3 <= aux_saida3;
--saida4 <= aux_saida4;

end Behavioral;
