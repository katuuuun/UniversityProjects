library ieee; use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t7_shift_register is
	port(
		clk 	 			: in std_logic;
		input  			: in std_logic;
		load   			: in std_logic;
		reset  			: in std_logic;
		shift  			: in std_logic;
		shift_size  : in std_logic_vector(3 downto 0);
		output 			: out std_logic_vector(11 downto 0)
	);
end t7_shift_register;

architecture Behavioral of t7_shift_register is
	signal reg : std_logic_vector(output'length-1 downto 0) := (others => '0');
	signal bit_counter : natural range 0 to output'length-1 := 0;
	signal current_shift : natural range 0 to output'length-1 := 0;
	signal max_number_of_shifts : natural := 0;
begin
	process (clk)
		constant zeros : std_logic_vector(output'length downto 0) := (others => '0');
	begin
		if rising_edge(clk) then
			if reset = '1' then
				reg <= (others => '0');
				bit_counter <= 0;
			elsif load = '1' then
				reg(bit_counter) <= input;
				bit_counter <= bit_counter + 1;
				check_overload : 
				if bit_counter = 11 then
					bit_counter <= 0;
				end if check_overload;
			elsif shift = '1' then
				reg <= zeros(to_integer(unsigned(shift_size)) - 1 downto 0) & 
					reg(reg'length - 1 downto to_integer(unsigned(shift_size)));
			end if;
		end if;
	end process;
	output <= reg;
end Behavioral;
