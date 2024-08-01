library ieee; use ieee.std_logic_1164.all;

entity logical_function is
	port(
		input : in std_logic_vector(3 downto 0);
		y : out std_logic
	);
end entity logical_function;

architecture behav of logical_function is
	alias a is input(0);
	alias b is input(1);
	alias c is input(2);
	alias d is input(3);
begin
	y <= (not a and b) or
			 (c and not d) or
			 (a and not c);
end architecture behav;