library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_tb is
end CPU_tb;

architecture Behavioral of CPU_tb is

    -- Signals to connect to CPU
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '1'; -- start with reset asserted

begin

    -- Instantiate CPU
    UUT: entity work.CPU
        generic map (
            N => 8  -- 8-bit address for PC
        )
        port map (
            clk    => clk,
            reset  => reset
        );

    -- Clock Generation: 10ns period (100 MHz)
    clk_process : process
    begin
        while True loop
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
        end loop;
    end process;

    -- Reset Process: hold reset high for some time
    reset_process : process
    begin
        -- Start with reset high
        reset <= '1';
        wait for 20 ns; -- Hold reset high for 20 ns
        reset <= '0';
        wait; -- continue forever
    end process;

end Behavioral;
