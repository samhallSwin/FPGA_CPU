--------------------------------------------
-- This CPU is designed as a teaching tool and is horrifically unoptimised.
-- Does not contain any pipelining 
------------------------------------------- 


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL;

entity CPU is
    generic (
        N : integer := 8  -- How many bits is the CPU? This effects ALU size, program length
    );
    port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC
    );
end CPU;

architecture Behavioral of CPU is

    -- Program Counter
    signal PC        : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');

    -- Instruction fetch
    signal instr     : STD_LOGIC_VECTOR(31 downto 0);

    -- Instruction decode
    signal opcode    : ALU_Opcode;
    signal arg1, arg2, arg3 : STD_LOGIC_VECTOR(7 downto 0);

    -- Register file
    signal reg_read_data1, reg_read_data2 : STD_LOGIC_VECTOR(N-1 downto 0);
    signal reg_write_data : STD_LOGIC_VECTOR(N-1 downto 0);
    signal RegWrite       : STD_LOGIC;

    -- ALU
    signal ALUOp          : ALU_Opcode;
    signal alu_result     : STD_LOGIC_VECTOR(N-1 downto 0);
    signal alu_zero       : STD_LOGIC;
    signal alu_negative   : STD_LOGIC;
    signal alu_overflow   : STD_LOGIC;

begin

    U_IM: entity work.InstructionMemory
        generic map (N => N)
        port map (
            addr      => PC,
            instr_out => instr
        );

    U_RF: entity work.RegisterFile
        generic map (
            N => N,
            NUM_REGS => 8
        )
        port map (
            clk         => clk,
            we          => RegWrite,
            read_addr1  => arg1(2 downto 0),
            read_addr2  => arg2(2 downto 0),
            write_addr  => arg3(2 downto 0),
            write_data  => reg_write_data,
            read_data1  => reg_read_data1,
            read_data2  => reg_read_data2
        );

    U_ALU: entity work.ALU
        generic map (N => N)
        port map (
            A_in      => reg_read_data1,
            B_in      => reg_read_data2,
            ALUOp     => ALUOp,
            Result    => alu_result,
            Zero      => alu_zero,
            Negative  => alu_negative,
            Overflow  => alu_overflow
        );

    -- ALU opcode mapping 
    process(opcode)
    begin
        case opcode is
            when OP_JEQ | OP_JLT | OP_JGT =>
                ALUOp <= OP_SUB; --We need to do a subtraction to check jump logic
            when others =>
                ALUOp <= opcode;
        end case;
    end process;

    -- Control: register write logic
    process(opcode, arg1, alu_result)
    begin
        RegWrite       <= '0';
        reg_write_data <= (others => '0');

        case opcode is
            when OP_ADD | OP_SUB | OP_AND | OP_OR | OP_XOR =>
                RegWrite       <= '1';
                reg_write_data <= alu_result;

            when OP_MOV =>
                RegWrite       <= '1';
                reg_write_data <= arg1;

            when others =>
                RegWrite       <= '0';
        end case;
    end process;

    process(reset, instr)
    begin
        if reset = '1' then
            opcode    <= OP_NOP;
            arg1      <= (others => '0');
            arg2      <= (others => '0');
            arg3      <= (others => '0');
    
        else
    
            opcode <= to_opcode(instr(31 downto 24));
            arg1   <= instr(23 downto 16);
            arg2   <= instr(15 downto 8);
            arg3   <= instr(7 downto 0);
        end if;
    end process;    

    -- PC, fetch, and decode
    process(clk, reset)
    begin
        if reset = '1' then
            PC        <= (others => '0');

        elsif rising_edge(clk) then
    
            case opcode is
                when OP_JEQ =>
                    if alu_zero = '1' then
                        PC <= arg3;
                    else
                        PC <= std_logic_vector(unsigned(PC) + 1);
                    end if;
    
                when OP_JLT =>
                    if alu_negative = '1' then
                        PC <= arg3;
                    else
                        PC <= std_logic_vector(unsigned(PC) + 1);
                    end if;
    
                when OP_JGT =>
                    if alu_zero = '0' and alu_negative = '0' then
                        PC <= arg3;
                    else
                        PC <= std_logic_vector(unsigned(PC) + 1);
                    end if;
    
                when OP_JMP =>
                    PC <= arg3;
    
                when others =>
                    PC <= std_logic_vector(unsigned(PC) + 1);
            end case;
    
        end if;
    end process;
    

end Behavioral;
