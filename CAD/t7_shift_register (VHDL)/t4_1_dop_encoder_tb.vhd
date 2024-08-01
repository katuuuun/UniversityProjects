library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t4_1_dop_encoder_tb is
end t4_1_dop_encoder_tb;

architecture Behavioral of t4_1_dop_encoder_tb is
	signal input 	: std_logic_vector(6 downto 0) := (others => '0');
	signal output : std_logic_vector(2 downto 0) := (others => '0');
begin
	dut: entity work.t4_priority_encoder(behav)
	port map (input => input,
						output => output);
						
	simulus: process is
		variable i : integer;
		constant TPC : time := 10 ns;
		
		type input_array is array (0 to 6) of std_logic_vector(6 downto 0);
		variable encoder_input : input_array := (
		 "0000000", "1000000", "0100000", "0010000",
		 "0001000", "0000100", "0000010");
	begin
		for i in 0 to encoder_input'length-1 loop
			input <= encoder_input(i);
			wait for TPC;
		end loop;
		wait;
	end process simulus;
end Behavioral;
