library ieee;
use ieee.std_logic_1164.all;

entity reg is
	generic (size : positive);
	port (
		clk : in std_logic;
		d : in std_logic_vector(size - 1 downto 0);
		q : out std_logic_vector(size - 1 downto 0)
	);
end reg;

architecture behavioral of reg is
	signal current_stata, next_state : std_logic_vector(size - 1 downto 0);
begin
	next_state <= d;
	p1 : process(clk) is		
	begin
		if (clk'event and clk = '1') then
			current_stata <= next_state;
		end if;
	end process p1;
	q <= current_stata;	
end architecture behavioral;

