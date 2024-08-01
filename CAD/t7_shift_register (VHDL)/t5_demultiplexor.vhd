library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demultiplexor is
	port(
		input  : in std_logic;
		adress : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(15 downto 0)
	);
end entity demultiplexor;

architecture behav of demultiplexor is
begin
	main : process(input, adress) is
	begin
		output <= (others => '0');
		output(to_integer(unsigned(adress))) <= input; 
	end process;
end architecture behav;