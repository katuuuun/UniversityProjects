library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t9_block_ram is
	generic(
		addr_width   : natural := 7;
		data_width   : natural := 32;
		words_number : natural := 128 );
	port(
		clk			 : in std_logic;
		--Port A
		port_A_mode : in std_logic; -- read - '0', write - '1'
		addr_A 		  : in std_logic_vector(addr_width-1 downto 0);
		data_in_A   : in std_logic_vector(data_width-1 downto 0);
		data_out_A  : out std_logic_vector(data_width-1 downto 0);
		--Port B
		addr_B 		 : in std_logic_vector(addr_width-1 downto 0);
		data_out_B : out std_logic_vector(data_width-1 downto 0)
	);
end entity t9_block_ram;

architecture behav of t9_block_ram is
	type mem is array (0 to words_number-1)
		of std_logic_vector(data_width-1 downto 0);
	signal block_ram : mem := (0 to words_number-1 => (others => '0'));
	attribute RAM_STYLE : string;
	attribute RAM_STYLE of block_ram : signal is "BLOCK";
begin
	process (clk, addr_A, addr_B) is
	begin
		if rising_edge(clk) then
			--Port A
			if port_A_mode = '0' then
				data_out_A <= block_ram(to_integer(unsigned(addr_A)));
			else
				block_ram(to_integer(unsigned(addr_A))) <= data_in_A;
			end if;
			--Port B
			data_out_B <= block_ram(to_integer(unsigned(addr_B)));
 		end if;
	end process;
end architecture behav;