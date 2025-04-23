library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder_tb is
-- Testbench has no ports
end FullAdder_tb;

architecture Behavioral of FullAdder_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component FullAdder is
        Port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal A, B, Cin : STD_LOGIC := '0';
    signal S, Cout : STD_LOGIC;

begin

    uut: FullAdder
        Port Map (
            A => A,
            B => B,
            Cin => Cin,
            S => S,
            Cout => Cout
        );


    stim_proc: process
    begin
        -- Test all input combinations (2^3 = 8 cases)
        A <= '0'; B <= '0'; Cin <= '0'; wait for 10 ns;
        A <= '0'; B <= '0'; Cin <= '1'; wait for 10 ns;
        A <= '0'; B <= '1'; Cin <= '0'; wait for 10 ns;
        A <= '0'; B <= '1'; Cin <= '1'; wait for 10 ns;
        A <= '1'; B <= '0'; Cin <= '0'; wait for 10 ns;
        A <= '1'; B <= '0'; Cin <= '1'; wait for 10 ns;
        A <= '1'; B <= '1'; Cin <= '0'; wait for 10 ns;
        A <= '1'; B <= '1'; Cin <= '1'; wait for 10 ns;

        wait;
    end process;

end Behavioral;
