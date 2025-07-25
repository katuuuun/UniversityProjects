library ieee;
use ieee.std_logic_1164.all;

entity inv_shift_rows is
	port (
		input : in std_logic_vector(127 downto 0);
		output : out std_logic_vector(127 downto 0)
	);
end inv_shift_rows;

architecture rtl of inv_shift_rows is
	
begin
	--output(8*16 - 1 downto 8*15) <= input(8*12 - 1 downto 8*11);
	output(8*12 - 1 downto 8*11) <= input(8*16 - 1 downto 8*15);
		
	--output(8*15 - 1 downto 8*14) <= input(8*7 - 1 downto 8*6);
	output(8*7 - 1 downto 8*6) <= input(8*15 - 1 downto 8*14);
		
	--output(8*14 - 1 downto 8*13) <= input(8*2 - 1   downto  8*1);
	output(8*2 - 1   downto  8*1) <= input(8*14 - 1 downto 8*13);
		 
	--output(8*13 - 1 downto 8*12) <= input(8*13 - 1  downto  8*12);
	output(8*13 - 1  downto  8*12) <= input(8*13 - 1 downto 8*12);
		
	--output(8*12 - 1 downto 8*11) <= input(8*8 - 1   downto  8*7);
	output(8*8 - 1   downto  8*7) <= input(8*12 - 1 downto 8*11);
		
	--output(8*11 - 1 downto 8*10) <= input(8*3 - 1   downto  8*2);
	output(8*3 - 1   downto  8*2) <= input(8*11 - 1 downto 8*10);
		
	--output(8*10 - 1 downto 8*9) <= input(8*14 - 1  downto  8*13);
	output(8*14 - 1  downto  8*13) <= input(8*10 - 1 downto 8*9); 
		
	--output(8*9 - 1 downto 8*8) <= input(8*9 - 1   downto  8*8);
	output(8*9 - 1   downto  8*8) <= input(8*9 - 1 downto 8*8);
		
	--output(8*8 - 1 downto 8*7) <= input(8*4 - 1   downto  8*3);
	output(8*4 - 1   downto  8*3) <= input(8*8 - 1 downto 8*7);
		
	--output(8*7 - 1 downto 8*6) <= input(8*15 - 1  downto  8*14);
	output(8*15 - 1  downto  8*14) <= input(8*7 - 1 downto 8*6);
		
	--output(8*6 - 1 downto 8*5) <= input(8*10 - 1  downto  8*9);
	output(8*10 - 1  downto  8*9) <= input(8*6 - 1 downto 8*5);
		
	--output(8*5 - 1 downto 8*4) <= input(8*5 - 1   downto  8*4);
	output(8*5 - 1   downto  8*4) <= input(8*5 - 1 downto 8*4);
		
	--output(8*4 - 1 downto 8*3) <= input(8*16 - 1  downto  8*15);
	output(8*16 - 1  downto  8*15) <= input(8*4 - 1 downto 8*3);
		
	--output(8*3 - 1 downto 8*2) <= input(8*11 - 1  downto  8*10);
	output(8*11 - 1  downto  8*10) <= input(8*3 - 1 downto 8*2);
		
	--output(8*2 - 1 downto 8*1) <= input(8*6 - 1   downto  8*5);
	output(8*6 - 1   downto  8*5) <= input(8*2 - 1 downto 8*1) ;
		
	--output(8*1 - 1 downto 8*0) <= input(8*1 - 1   downto  8*0);
	output(8*1 - 1   downto  8*0) <= input(8*1 - 1 downto 8*0);	 
end architecture rtl;
