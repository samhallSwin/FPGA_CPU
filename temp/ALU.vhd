library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL;

entity ALU is
    generic (
        N : integer := 8
    );
    port (
        A_in      : in  STD_LOGIC_VECTOR(N-1 downto 0);
        B_in      : in  STD_LOGIC_VECTOR(N-1 downto 0);
        ALUOp     : in  ALU_Opcode;
        Result    : out STD_LOGIC_VECTOR(N-1 downto 0);
        Zero      : out STD_LOGIC;
        Negative  : out STD_LOGIC;
        Overflow  : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is

    component RippleCarryAdder
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
    end component;

    -- Internal signals
    signal B_adder     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal adder_sum   : STD_LOGIC_VECTOR(N-1 downto 0);
    signal adder_ovf   : STD_LOGIC;
    signal Cin         : STD_LOGIC;
    signal result_comb : STD_LOGIC_VECTOR(N-1 downto 0);

begin

    -- ALU Operation Selection (combinational)
    process(A_in, B_in, ALUOp, adder_sum)
    begin
        -- Default assignments
        B_adder     <= (others => '0');
        Cin         <= '0';
        result_comb <= (others => '0');

        case ALUOp is
            when OP_ADD =>
                B_adder     <= B_in;
                Cin         <= '0';
                result_comb <= adder_sum;

            when OP_SUB =>
                B_adder     <= ;
                Cin         <= ;
                result_comb <= ;

            when OP_AND =>
                result_comb <= A_in and B_in;

            when OP_OR =>
                result_comb <= ;

            when OP_XOR =>
                result_comb <= ;

            when others =>
                result_comb <= (others => '0');
        end case;
    end process;

    -- Ripple Carry Adder instantiation
    RCA: RippleCarryAdder
        generic map (N => N)
        port map (
            A        => A_in,
            B        => B_adder,
            Cin      => Cin,
            S        => adder_sum,
            Cout     => open,
            Zero     => open,
            Overflow => adder_ovf,
            Negative => open
        );

    -- Final Outputs
    Result   <= result_comb;
    Zero <= '1' when result_comb = std_logic_vector(to_unsigned(0, result_comb'length)) else '0'; --when the result is all zeros, raise the zero flag
    Negative <= result_comb(N-1); --If the sign bit (Highest bit) is a 1, raise this flag
    Overflow <= adder_ovf when (ALUOp = OP_ADD or ALUOp = OP_SUB) else '0'; --This will only occur for add or subtract - if we exceed our number of bits, raise this flag.

end Behavioral;
