library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t5_demultiplexor_tb is
end t5_demultiplexor_tb;

architecture Behavioral of t5_demultiplexor_tb is
	signal input 	: std_logic := '1';
	signal adress : std_logic_vector(3 downto 0) := (others => '0');
	signal output : std_logic_vector(15 downto 0) := (others => '0');
begin
	dut: entity work.demultiplexor(behav)
	port map (input => input,
						adress => adress,
						output => output);
						
	simulus: process is
		constant TPC : time := 10 ns;
	begin
		for i in 0 to output'length-1 loop
			adress <= std_logic_vector(to_unsigned(i, adress'length));
			wait for TPC;
		end loop l_acc;
		wait;
	end process simulus;
end Behavioral;
