library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

entity Comparator_Test is
end Comparator_Test;

architecture tb_arch of Comparator_Test is
  component Comparator is
    port (
      a, b: in std_logic_vector(15 downto 0);
      greater, equal, smaller: out bit
    );
  end component;

  signal a, b: std_logic_vector(15 downto 0);
  signal greater, equal, smaller: bit;
  file output_file : text;

begin

  uut: Comparator
    port map (
      a => a,
      b => b,
      greater => greater,
      equal => equal,
      smaller => smaller
    );

 
  stimulus: process is
  variable out_line : line;
  variable cctv: FILE_OPEN_STATUS;
  begin
  file_open (cctv, output_file, "VHDL.txt", write_mode);

    a <= "0000001111100000";
    b <= "0000001111100000";
    wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);
    
    a <= "1110000000000000";
    b <= "0000000001000101";
    wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);
   
    a <= "0000000011100000";
    b <= "0011110000000000";
    wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);
  
    a <= "1111111111111111";
    b <= "1111111111111111";
    wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);

    a <= "1111111100000000";
    b <= "0000000011111111";
wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);

    a <= "0000000001000111";
    b <= "0000000001000111";
wait for 50 ns;
    write(out_line, greater, left, 1);
    write(out_line, equal, left, 1);
    write(out_line, smaller, left, 1);
writeline(output_file, out_line);

file_close(output_file);
wait;
  end process stimulus;

end tb_arch;

