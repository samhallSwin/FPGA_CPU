library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_RippleCarryAdder is
end tb_RippleCarryAdder;

architecture Behavioral of tb_RippleCarryAdder is

    constant N : integer := 8;

    -- DUT signals
    signal A, B  : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Cin   : STD_LOGIC;
    signal S     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Cout  : STD_LOGIC;

    -- Component declaration for DUT
    component RippleCarryAdder
        generic (
            N : integer := 8
        );
        port (
            A    : in  STD_LOGIC_VECTOR(N-1 downto 0);
            B    : in  STD_LOGIC_VECTOR(N-1 downto 0);
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC_VECTOR(N-1 downto 0);
            Cout : out STD_LOGIC
        );
    end component;

begin

    -- Instantiate the DUT
    UUT: RippleCarryAdder
        generic map (N => N)
        port map (
            A    => A,
            B    => B,
            Cin  => Cin,
            S    => S,
            Cout => Cout
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test 1: All zeros
        A <= "00000000";
        B <= "00000000";
        Cin <= '0';
        wait for 10 ns;

        -- Test 2: 00000101 + 00000011 = 00001000
        A <= "00000101";
        B <= "00000011";
        Cin <= '0';
        wait for 10 ns;

        -- Test 3: 00000111 + 00001000 + Cin
        A <= "00000111";
        B <= "00001000";
        Cin <= '1';
        wait for 10 ns;

        -- Test 4: Overflow test
        A <= "11111111";
        B <= "00000001";
        Cin <= '0';
        wait for 10 ns;

        -- Test 5: Arbitrary test case
        A <= "01111111";
        B <= "10000001";
        Cin <= '0';
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
