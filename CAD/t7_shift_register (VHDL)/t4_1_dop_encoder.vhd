library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t4_priority_encoder is
	port(
		input : in std_logic_vector(6 downto 0);
		output : out std_logic_vector(2 downto 0)
	);
end t4_priority_encoder;

architecture behav of t4_priority_encoder is
begin
	decoding : process(input) is
	begin
		output <= (others => '0');
		for i in input'length-1 downto 0 loop
			if input(i) = '1' then
				output <= not std_logic_vector(to_unsigned(i, output'length));
				next;
			end if;
		end loop;
	end process decoding;
end architecture behav;