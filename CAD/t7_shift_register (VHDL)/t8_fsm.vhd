library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity t8_fsm is
	port(
	clock, reset : IN STD_LOGIC;
    z_in : IN STD_LOGIC_VECTOR(1 downto 0);
    w_out : OUT STD_LOGIC_vector (2 downto 0));
end t8_fsm;


architecture Behavioral of t8_fsm is

type state_values IS (a0, a1, a2, a3);
signal state, next_state: state_values;

begin

-- регистерный блок

reg: process(clock,reset)
	begin
	if (reset = '1') then state <= a0;
	elsif rising_edge(clock) then
		state <= next_state;
	end if;
end process reg;

-- комбинаторный блок (логика переходов)

process(state, z_in)
	begin
	case state is
        when a0 =>
            case z_in is
            when "00" => 
                next_state <= a3;
                w_out <= "011";
            when "01" => 
                next_state <= a0;
                w_out <= "010";
            when "10" =>
                next_state <= a1;
                w_out <= "101";
            when others =>
                next_state <= a0;
            end case;

        when a1 =>
            case z_in is
            when "00" => 
                next_state <= a1;
                w_out <= "010";
            when "01" => 
                next_state <= a2;
                w_out <= "001";
            when "10" =>
                next_state <= a3;
                w_out <= "100";
            when others =>
                next_state <= a1;
            end case;

        when a2 =>
            case z_in is
            when "00" => 
                next_state <= a1;
                w_out <= "100";
            when "01" => 
                next_state <= a3;
                w_out <= "101";
            when "10" =>
                next_state <= a2;
                w_out <= "001";
            when others =>
                next_state <= a2;
            end case;

        when a3 =>
            case z_in is
            when "00" => 
                next_state <= a0;
                w_out <= "001";
            when "01" => 
                next_state <= a2;
                w_out <= "010";
            when "10" =>
                next_state <= a3;
                w_out <= "100";
            when others =>
                next_state <= a3;
            end case;

        when others => next_state <= a0;
    end case;
end process;

end Behavioral;