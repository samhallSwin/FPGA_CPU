library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AndGate_tb is
-- Testbench has no ports
end AndGate_tb;

architecture Behavioral of AndGate_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component AndGate is
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            S    : out STD_LOGIC
        );
    end component;

    signal A, B : STD_LOGIC := '0';
    signal S    : STD_LOGIC;

begin

    uut: AndGate
        Port Map (
            A => A,
            B => B,
            S => S
        );


    stim_proc: process
    begin
        -- Test all input combinations (2^2 = 4 cases)
        A <= '0'; B <= '0';  wait for 10 ns;
        A <= '0'; B <= '1';  wait for 10 ns;
        A <= '1'; B <= '0';  wait for 10 ns;
        A <= '1'; B <= '1';  wait for 10 ns;
        wait;
    end process;

end Behavioral;
