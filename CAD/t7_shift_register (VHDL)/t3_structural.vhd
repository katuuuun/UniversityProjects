library ieee;
use ieee.std_logic_1164.all;

entity t3_structural is
    Port ( x : in  STD_LOGIC_VECTOR (4 downto 1);
           y : out  STD_LOGIC_VECTOR (4 downto 1));
end t3_structural;

architecture Stuctural of t3_structural is

	signal N_0, N_1, N_2 : STD_LOGIC;
	signal NAO22_0 : STD_LOGIC;
	signal NOAO2_0 : STD_LOGIC;
	signal NA3_0 : STD_LOGIC;
	signal NO3_0 : STD_LOGIC;
	signal NO4_0 : STD_LOGIC;
	signal O2_0 : STD_LOGIC;
	signal NMX2_0 : STD_LOGIC;
	signal NO3A2_0 : STD_LOGIC;
	
begin

p0: entity work.N
    port map (x(3), N_0);
   
p1: entity work.N
    port map (x(2), N_1);
    
p2: entity work.N
    port map (NO3A2_0, N_2);
 
p3: entity work.N
    port map (NO3A2_0, N_2); 
 
p4: entity work.NO3
    port map (x(1), N_0, x(4), NO3_0); 
         
p5: entity work.NAO22
    port map (x(3), x(1), N_1, NOAO2_0, NAO22_0); 

p6: entity work.NO4
    port map (x(4), x(2), NMX2_0, NOAO2_0 , NO4_0); 
 
p7: entity work.NO3A2
    port map (NO3_0, NO4_0, x(4), NAO22_0, NO3A2_0); 
  
p8: entity work.NA3
    port map (x(2), x(4), x(1), NA3_0);
   
p9: entity work.O2
    port map (x(2), x(4), O2_0);
        
p10: entity work.NMX2
    port map (O2_0, N_1, x(3), NMX2_0);
        
p11: entity work.NOAO2
    port map (x(3), NA3_0, x(1), O2_0,  NOAO2_0);  
          
y(1) <= x(2);                            
y(2) <= N_2;  
y(3) <= NOAO2_0;
y(4) <= NMX2_0;     
end Stuctural;
