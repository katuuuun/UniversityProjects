library ieee; use ieee.std_logic_1164.all;

entity code_converter is
	port(
		input  : in std_logic_vector(3 downto 0);
		output : out std_logic_vector(3 downto 0)
	);
end entity code_converter;

architecture behav of code_converter is
begin
	convert_code : process(input) is
	begin
		case input is
			when "0000" => output <= "0000";
			when "0001" => output <= "0001";
			when "0010" => output <= "0010";
			when "0011" => output <= "0011";
			when "0100" => output <= "0100";
			when "1000" => output <= "1011";
			when "1001" => output <= "1100";
			when "1010" => output <= "1101";
			when "1011" => output <= "1110";
			when "1100" => output <= "1111";
			when others => output <= "ZZZZ";
		end case;
	end process convert_code;
end architecture behav;