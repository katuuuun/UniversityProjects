library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t2_code_converter_tb is
end t2_code_converter_tb;

architecture Behavioral of t2_code_converter_tb is
	signal input 	: std_logic_vector(3 downto 0) := (others => '0');
	signal output : std_logic_vector(3 downto 0) := (others => '0');
begin
	dut: entity work.code_converter(behav)
	port map (input => input,
						output => output);
	
	simulus: process is
		variable i : integer;
		constant TPC : time := 10 ns;
		
		type input_array is array (0 to 9) of std_logic_vector(3 downto 0);
		variable code_5421_array : input_array := (
		 "0000", "0001", "0010", "0011", "0100",
		 "1000", "1001", "1010", "1011", "1100");
	begin
		for i in 0 to code_5421_array'length-1 loop
			input <= code_5421_array(i);
			wait for TPC;
		end loop;
		wait;
	end process simulus;
end Behavioral;
