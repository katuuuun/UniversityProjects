library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t6_rev_counter_modulo_16_tb is
end entity t6_rev_counter_modulo_16_tb;

architecture behav of t6_rev_counter_modulo_16_tb is
	signal clk 	: std_logic := '0';
	signal reset 	: std_logic := '0';
	signal count : std_logic_vector(3 downto 0) := (others => '0');
begin
	dut: entity work.t6_rev_counter_modulo_16(Behavioral)
	port map (clk => clk,
						reset => reset,
						count => count);
						
	clock_gen: process is
		constant TPC : time := 10 ns;
	begin
		clk <= '1'; wait for TPC / 2; 
		clk <= '0'; wait for TPC / 2; 
	end process clock_gen;
end behav;