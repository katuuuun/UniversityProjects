library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t7_shift_register_tb is
end entity t7_shift_register_tb;

architecture behav of t7_shift_register_tb is
	constant TPC : time := 10 ns;

	signal clk 	 			: std_logic := '0';
	signal input 			: std_logic := '0';
	signal load  			: std_logic := '1';
	signal reset 			: std_logic := '0';
	signal shift 			: std_logic := '0';
	signal shift_size : std_logic_vector(3 downto 0) := (others => '0');
	signal output 		: std_logic_vector(11 downto 0) := (others => '0');
begin
	dut: entity work.t7_shift_register(Behavioral)
	port map (clk => clk,
						input => input,
						load => load,
						reset => reset,
						shift => shift,
						shift_size => shift_size,
						output => output);
						
	clock_gen: process is
	begin
		clk <= '1'; wait for TPC / 2; 
		clk <= '0'; wait for TPC / 2; 
	end process clock_gen;
	
	simulus : process is
		constant test_input : std_logic_vector(output'length - 1 downto 0)
														:= (others => '1');
	begin
		load_input : for i in 0 to output'length - 1 loop
			input <= test_input(i);
			wait for TPC;
		end loop load_input;
		
		load <= '0';
		shift_size <= "0011";
		
		wait for TPC * 10;
		shift <= '1';
		
		wait for TPC * 2;
		shift <= '0';
		wait for TPC * 2;
		shift <= '1';
		wait;
	end process;
end behav;