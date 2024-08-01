Library ieee;
use ieee.std_logic_1164.all;

 
entity Comparator is
  port (
      a,b : in std_logic_vector(15 downto 0);
      greater, equal, smaller  : out bit);
end Comparator ;
 
architecture bhv of Comparator is
begin
greater <= '1' when (a > b)
else '0';
equal <= '1' when (a = b)
else '0';
smaller <= '1' when (a < b)
else '0';
end bhv;

