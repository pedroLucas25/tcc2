----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2019 13:34:27
-- Design Name: 
-- Module Name: in_read1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL;

entity in_read1 is
    Port ( in1 : in std_logic_vector (15 downto 0);
           out1 : out std_logic_vector (15 downto 0);
           out2 : out std_logic_vector (15 downto 0);
           clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end in_read1;

architecture Behavioral of in_read1 is

signal saida1 : std_logic_vector(15 downto 0) := (others => '0');
signal saida2 : std_logic_vector(15 downto 0) := (others => '0');

begin

process(clk, reset)

begin

if (reset = '1') then
    saida1 <= (others => '0');
    saida2 <= (others => '0');
elsif rising_edge(clk) then
        saida2 <= std_logic_vector(abs(signed(in1)));
        saida1 <= in1;
end if;

end process;

out1 <= saida1;
out2 <= saida2;

end Behavioral;
