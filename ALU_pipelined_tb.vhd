library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL;

entity ALU_pipelined_tb is
-- Testbenches do not have ports
end ALU_pipelined_tb;

architecture Behavioral of ALU_pipelined_tb is

    -- Constants
    constant N : integer := 8;

    -- Signals to connect to the ALU
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal A_in      : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal B_in      : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal ALUOp     : ALU_Opcode := OP_NOP;
    signal Result    : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Zero      : STD_LOGIC;
    signal Negative  : STD_LOGIC;
    signal Overflow  : STD_LOGIC;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the ALU
    uut: entity work.ALU
        generic map (N => N)
        port map (
            A_in      => A_in,
            B_in      => B_in,
            ALUOp     => ALUOp,
            Result    => Result,
            Zero      => Zero,
            Negative  => Negative,
            Overflow  => Overflow
        );

    -- Clock generation
    clk_process : process
    begin
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin

        -- Reset the ALU
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- Test ADD (OP_ADD)
        A_in <= x"05";
        B_in <= x"03";
        ALUOp <= OP_ADD;
        wait for clk_period;

        -- Test SUB (OP_SUB)
        A_in <= x"08";
        B_in <= x"02";
        ALUOp <= OP_SUB;
        wait for clk_period;

        -- Test AND (OP_AND)
        A_in <= x"0F";
        B_in <= x"F0";
        ALUOp <= OP_AND;
        wait for clk_period;

        -- Test OR (OP_OR)
        A_in <= x"0F";
        B_in <= x"F0";
        ALUOp <= OP_OR;
        wait for clk_period;

        -- Test XOR (OP_XOR)
        A_in <= x"0F";
        B_in <= x"F0";
        ALUOp <= OP_XOR;
        wait for clk_period;

        -- Finish simulation
        wait;
    end process;

end Behavioral;
