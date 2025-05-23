library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RippleCarryAdder is
    generic (
        N : integer := 8
    );
    port (
        A        : in  STD_LOGIC_VECTOR(N-1 downto 0);
        B        : in  STD_LOGIC_VECTOR(N-1 downto 0);
        Cin      : in  STD_LOGIC;
        S        : out STD_LOGIC_VECTOR(N-1 downto 0);
        Cout     : out STD_LOGIC;
        Zero     : out STD_LOGIC;
        Overflow : out STD_LOGIC;
        Negative : out STD_LOGIC
    );
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is

    component FullAdder
        port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            S    : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal carry : STD_LOGIC_VECTOR(N downto 0);
    signal sum_internal : STD_LOGIC_VECTOR(N-1 downto 0);

begin
    carry(0) <= Cin;

    gen_adders: for i in 0 to N-1 generate
        FA_inst : FullAdder
            port map (
                A    => A(i),
                B    => B(i),
                Cin  => carry(i),
                S    => sum_internal(i),
                Cout => carry(i+1)
            );
    end generate;

    S    <= sum_internal;
    Cout <= carry(N);

    -- Flags
    Zero <= '1' when sum_internal = std_logic_vector(to_unsigned(0, N)) else '0';
    Negative <= sum_internal(N-1);
    Overflow <= carry(N) xor carry(N-1);

end Structural;
