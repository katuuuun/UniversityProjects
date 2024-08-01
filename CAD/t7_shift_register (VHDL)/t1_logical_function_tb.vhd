library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t1_logical_function_tb is
end t1_logical_function_tb;

architecture Behavioral of t1_logical_function_tb is
	signal input : std_logic_vector(3 downto 0) := (others => '0');
	signal y : std_logic := '0';
begin
	dut: entity work.logical_function(behav)
		port map (input => input,
							y => y);
							
	simulus: process is
		variable i : integer;
		constant TPC : time := 10 ns;
	begin
		for i in 0 to (2**input'length)-1 loop
			input <= std_logic_vector(unsigned(input) + 1);
			wait for TPC;
		end loop l_acc;
		wait;
	end process simulus;
end Behavioral;
