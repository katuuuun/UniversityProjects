library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t6_rev_counter_modulo_16 is
	port(
		reset : in std_logic;
		clk : in std_logic;
		count : out std_logic_vector(3 downto 0)
	);
end entity t6_rev_counter_modulo_16;

architecture Behavioral of t6_rev_counter_modulo_16 is
	signal counter : unsigned(3 downto 0) := (others => '0');
begin
	process(reset, clk)
	begin
		if reset = '1' then
			counter <= (others => '1');
		else
			if counter = "0000" then
				counter <= "1111";
			else
				counter <= counter - 1;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(counter);
end Behavioral;
