library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t4_decoder_3_to_6_tb is
end t4_decoder_3_to_6_tb;

architecture Behavioral of t4_decoder_3_to_6_tb is
	signal input  : std_logic_vector(2 downto 0) := (others => '0');
	signal output : std_logic_vector(5 downto 0) := (others => '0');
begin
	dut: entity work.decoder_3_to_6(behav)
		port map (input => input,
							output => output);
							
	simulus: process is
		variable i : integer;
		constant TPC : time := 10 ns;
		
		type input_array is array (0 to 5) of std_logic_vector(2 downto 0);
		variable inpute_code : input_array := (
		 "000", "001", "010", "011", "100", "101");
	begin
		for i in 0 to inpute_code'length loop
			input <= inpute_code(i);
			wait for TPC;
		end loop l_acc;
		wait;
	end process simulus;
end Behavioral;
