library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t9_block_ram_tb is
end entity t9_block_ram_tb;

architecture testbench of t9_block_ram_tb is
    constant ADDR_WIDTH   : natural := 7;
    constant DATA_WIDTH   : natural := 32; 
    constant WORDS_NUMBER : natural := 128;
    
    signal clk          : std_logic := '0';
    signal port_A_mode  : std_logic := '1'; 
    signal addr_A       : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal data_in_A    : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal data_out_A   : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal addr_B       : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal data_out_B   : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
    -- Создание экземпляра блока RAM
    dut: entity work.t9_block_ram
        generic map (
            addr_width   => ADDR_WIDTH,
            data_width   => DATA_WIDTH,
            words_number => WORDS_NUMBER
        )
        port map (
            clk          => clk,
            port_A_mode  => port_A_mode,
            addr_A       => addr_A,
            data_in_A    => data_in_A,
            data_out_A   => data_out_A,
            addr_B       => addr_B,
            data_out_B   => data_out_B
        );

    -- Процесс для генерации тактового сигнала
    process
    begin
            clk <= not clk;
            wait for 5 ns;
    end process;
    
    -- Процесс для тестирования чтения и записи данных
    process
    begin
        -- Запись данных в порт A
        port_A_mode <= '1'; -- Режим записи
        addr_A <= "0000001"; -- Адрес записи
        data_in_A <= (others => '1'); -- Данные для записи (все биты установлены в '1')
        wait for 50 ns;
        
        -- Чтение данных из порта A
        port_A_mode <= '0'; -- Режим чтения
        addr_A <= "0000001"; -- Адрес чтения
        wait for 50 ns;
        
        -- Чтение данных из порта B
        addr_B <= "0000001"; -- Адрес чтения
        wait for 50 ns;
        
        -- Запись данных в порт A
        port_A_mode <= '1'; -- Режим записи
        addr_A <= "0000001"; -- Адрес записи
        data_in_A <= "00000000001000000100000010000001"; -- Данные для записи (все биты установлены в '1')
        wait for 50 ns;  
         -- Чтение данных из порта A
        port_A_mode <= '0'; -- Режим чтения
        addr_A <= "0000001"; -- Адрес чтения
        wait for 50 ns;    
                -- Запись данных в порт A
        port_A_mode <= '1'; -- Режим записи
        addr_A <= "0000001"; -- Адрес записи
        data_in_A <= (others => '0'); -- Данные для записи (все биты установлены в '1')
        wait for 50 ns;
        
        -- Чтение данных из порта A
        port_A_mode <= '0'; -- Режим чтения
        addr_A <= "0000001"; -- Адрес чтения
        wait for 50 ns;  
        wait;
    end process;
end architecture testbench;
