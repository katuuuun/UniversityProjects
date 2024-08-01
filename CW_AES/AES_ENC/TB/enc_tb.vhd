library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity test_enc is 
end test_enc;

architecture behavior of test_enc is
	component aes_enc
		port(
			clk        : in  std_logic;
			rst        : in  std_logic;
			key        : in  std_logic_vector(127 downto 0);
			plaintext  : in  std_logic_vector(127 downto 0);
			ciphertext : out std_logic_vector(127 downto 0);
			done       : out std_logic
		);		
	end component aes_enc;	

	signal clk : std_logic := '0';
	signal rst : std_logic := '0';
	signal plaintext : std_logic_vector(127 downto 0);
	signal key : std_logic_vector(127 downto 0);	
	
	signal done : std_logic;
	signal ciphertext : std_logic_vector(127 downto 0);	
	
	constant clk_period : time := 10 ns;
	file output_file : text;
	
begin
	enc_inst : aes_enc
		port map(
			clk        => clk,
			rst        => rst,
			key        => key,
			plaintext  => plaintext,
			ciphertext => ciphertext,
			done       => done
		);	

	clk_process : process is
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process clk_process;
	
	file_open(output_file, "VHDL.txt", WRITE_MODE);

	sim_proc : process is
	variable AES_line : line;
	begin	
		plaintext <= x"00000000000000000000000000000000";
		key <= x"00000000000000000000000000000000";
		rst <= '0';	
		wait for clk_period * 1;
		rst <= '1';
		wait until done = '1';
		wait for clk_period/2;			
      write(AES_line, to_integer(unsigned(ciphertext)));
		writeline (output_file, AES_line);
	end process sim_proc;
	file_close (output_file);
end architecture behavior;

