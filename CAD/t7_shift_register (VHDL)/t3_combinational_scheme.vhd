library ieee; use ieee.std_logic_1164.all;

entity t3_combinational_scheme is
	port(
		x  : in std_logic_vector(4 downto 1);
		y : out std_logic_vector(4 downto 1)
);
end t3_combinational_scheme;

architecture Behavioral of t3_combinational_scheme is
	signal NO4, NO3, NAO22, O2, NA3, NO3A2, NMX2, NOAO2 : std_logic;
begin

NO4 <= not(x(4) or x(2) or NMX2 or NOAO2);
NO3 <= not(x(1) or not(x(3)) or x(4));
NAO22 <= not((x(3) and x(1)) or (not(x(2)) and NOAO2));
O2 <= x(2) or x(4);
NA3 <= not(x(2) and x(4) and x(1));
NO3A2 <= not(NO3 or NO4 or (x(4) and NAO22));
NMX2 <= not((O2 or x(2)) and (x(3) or not(x(2))));
NOAO2 <= not(x(3) or (NA3 and (x(1) or O2)));
    y(1) <= x(2);
    y(2) <= not(NO3A2);
    y(3) <= NOAO2;
    y(4) <= NMX2;
end Behavioral;
