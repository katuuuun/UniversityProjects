library ieee; use ieee.std_logic_1164.all;

entity decoder_3_to_6 is
	port(
		input  : in std_logic_vector(2 downto 0);
		output : out std_logic_vector(5 downto 0)
	);
end entity decoder_3_to_6;

architecture behav of decoder_3_to_6 is
begin
	decoding : process(input) is
	begin
		case input is
			when "000" => output  <= "100000";
			when "001" => output  <= "010000";
			when "010" => output  <= "001000";
			when "011" => output  <= "000100";
			when "100" => output  <= "000010";
			when "101" => output  <= "000001";
			when others => output <= "ZZZZZZ";
		end case;
	end process decoding;
end architecture behav;