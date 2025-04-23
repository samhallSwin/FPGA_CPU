library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RippleCarryAdder is
    generic (
        N : integer := 8  -- Width of the adder
    );
    port (
        A    : in  STD_LOGIC_VECTOR(N-1 downto 0);
        B    : in  STD_LOGIC_VECTOR(N-1 downto 0);
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC_VECTOR(N-1 downto 0);
        Cout : out STD_LOGIC
    );
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is

    component FullAdder
        port (
            A    : in  STD_LOGIC;
            B    : in  STD_LOGIC;
            Cin  : in  STD_LOGIC;
            Sum  : out STD_LOGIC;
            Cout : out STD_LOGIC
        );
    end component;

    signal carry : STD_LOGIC_VECTOR(N downto 0);

begin
    carry(0) <= Cin;

    gen_adders: for i in 0 to N-1 generate
        FA_inst : FullAdder
            port map (
                A    => A(i),
                B    => B(i),
                Cin  => carry(i),
                Sum  => Sum(i),
                Cout => carry(i+1)
            );
    end generate;

    Cout <= carry(N);

end Structural;
