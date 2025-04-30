library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL;

entity ALU_pipelined is
    generic (
        N : integer := 8
    );
    port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        A_in      : in  STD_LOGIC_VECTOR(N-1 downto 0);
        B_in      : in  STD_LOGIC_VECTOR(N-1 downto 0);
        ALUOp     : in  ALU_Opcode; -- 8-bit opcode
        Result    : out STD_LOGIC_VECTOR(N-1 downto 0);
        Zero      : out STD_LOGIC;
        Negative  : out STD_LOGIC;
        Overflow  : out STD_LOGIC
    );
end ALU_pipelined;

architecture Behavioral of ALU_pipelined is

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

    signal A_reg, B_reg : STD_LOGIC_VECTOR(N-1 downto 0);
    signal B_adder : STD_LOGIC_VECTOR(N-1 downto 0);
    signal result_comb  : STD_LOGIC_VECTOR(N-1 downto 0);
    signal zero_comb, neg_comb, ovf_comb : STD_LOGIC;
    signal adder_sum    : STD_LOGIC_VECTOR(N-1 downto 0);
    signal adder_zero, adder_ovf, adder_neg : STD_LOGIC;
    signal Cin : STD_LOGIC := '0';

begin

    -- Clocked input registers
    process(clk, reset)
    begin
        if reset = '1' then
            A_reg <= (others => '0');
            B_reg <= (others => '0');
        elsif rising_edge(clk) then
            A_reg <= A_in;
            B_reg <= B_in;
        end if;
    end process;

    -- ALU operation selection (combinational)
    process(A_reg, B_reg, ALUOp, adder_sum)
    begin
        case ALUOp is
            when OP_ADD => 
                B_adder <= B_reg; --just pass the reg in when adding
                result_comb <= adder_sum;
                Cin <= '0';
            when OP_SUB =>  
                B_adder <= not B_reg; -- convert to 2's compliment for subtraction:  A + not(B) + 1 = A - B  
                result_comb <= adder_sum;
                Cin <= '1';
            when OP_AND =>  
                result_comb <= A_reg and B_reg;
                Cin <= '0';
            when OP_OR =>
                result_comb <= A_reg or B_reg;
                Cin <= '0';
            when OP_XOR =>  
                result_comb <= A_reg xor B_reg;
                Cin <= '0';
            when others =>
                result_comb <= (others => '0');
                Cin <= '0';
        end case;
    end process;

    -- RippleCarryAdder instantiation (combinational core)
    RCA: RippleCarryAdder
        generic map (N => N)
        port map (
            A          => A_reg,
            B          => B_adder,
            Cin        => Cin,
            S          => adder_sum,
            Cout       => open,
            Zero       => adder_zero,
            Overflow   => adder_ovf,
            Negative   => adder_neg
        );

    -- Clocked outputs
    process(clk, reset)
    begin
        if reset = '1' then
            Result   <= (others => '0');
            Zero     <= '0';
            Negative <= '0';
            Overflow <= '0';
        elsif rising_edge(clk) then
            Result   <= result_comb;
            Zero     <= adder_zero;
            Negative <= adder_neg;
            Overflow <= adder_ovf;
        end if;
    end process;

end Behavioral;
