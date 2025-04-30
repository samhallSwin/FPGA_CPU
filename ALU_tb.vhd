library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL; 

entity ALU_tb is
end ALU_tb;

architecture behavior of ALU_tb is

    constant N : integer := 8;
    
    signal A_in      : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal B_in      : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal ALUOp     : ALU_Opcode;
    signal Result    : STD_LOGIC_VECTOR(N-1 downto 0);
    signal Zero      : STD_LOGIC;
    signal Negative  : STD_LOGIC;
    signal Overflow  : STD_LOGIC;

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

    stim_proc: process
    begin
        
        -- Test addition
        A_in <= std_logic_vector(to_unsigned(5, N));
        B_in <= std_logic_vector(to_unsigned(10, N));
        ALUOp <= OP_ADD;
        wait for 10 ns;

        -- Test subtraction
        A_in <= std_logic_vector(to_unsigned(15, N));
        B_in <= std_logic_vector(to_unsigned(5, N));
        ALUOp <= OP_SUB;
        wait for 10 ns;

        -- Test AND
        A_in <= "10101010";
        B_in <= "11001100";
        ALUOp <= OP_AND;
        wait for 10 ns;


        wait;
    end process;

end behavior;