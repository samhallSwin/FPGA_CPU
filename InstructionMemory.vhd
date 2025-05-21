library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_Pkg.ALL;

entity InstructionMemory is
    generic (
        N : integer := 8
    );
    port (
        addr        : in  STD_LOGIC_VECTOR(N-1 downto 0); 
        instr_out   : out STD_LOGIC_VECTOR(31 downto 0);

        -- New ports for writing
        write_enable : in STD_LOGIC;
        write_addr   : in STD_LOGIC_VECTOR(N-1 downto 0);  -- address to write to
        byte_select  : in STD_LOGIC_VECTOR(1 downto 0);    -- select which byte (00 to 11)
        write_data   : in STD_LOGIC_VECTOR(7 downto 0)     -- data to write
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is

    signal updated_instr : STD_LOGIC_VECTOR(31 downto 0);
    -- Instruction memory array: each entry is a 32-bit instruction
    type instruction_mem_type is array(0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal instr_mem : instruction_mem_type := (
        
    0 => make_instr(OP_NOP, (others => '0'), (others => '0'), (others => '0')), --As a quick hacky fix, we need the first instruction to be nothing as it's skipped. 
    --------------------------------------------------
    --Here's where we can write our program
    -- the format of each instruction should be '[PC number] => marke_instr([OpCode], [arg1], [arg2], arg3]),' 
    -- If you want to refernce a register it needs to be in the form 'regcode_to_stdvec([register number])'
    -------------------------------------------------

    1 => make_instr(OP_MOV, x"01", (others => '0'), regcode_to_stdvec(R0)), --put 1 in R0
    2 => make_instr(OP_MOV, x"05", (others => '0'), regcode_to_stdvec(R1)), -- put 5 in R1
    3 => make_instr(OP_ADD, regcode_to_stdvec(R0), regcode_to_stdvec(R1), regcode_to_stdvec(R2)), --add R0 to R1, store results in R2

    --end program here
    -------------------------------------------------
        others => (others => '0') --All locations not defined in the program above will be zeroes.
    );

begin

    instr_out <= instr_mem(to_integer(unsigned(addr)));

    -- Asynchronous write to memory
    process(write_enable, write_addr, byte_select, write_data)
    begin
        if write_enable = '1' then
            case byte_select is
                when "11" =>
                    instr_mem(to_integer(unsigned(write_addr)))(31 downto 24) <= write_data;
                when "10" =>
                    instr_mem(to_integer(unsigned(write_addr)))(23 downto 16) <= write_data;
                when "01" =>
                    instr_mem(to_integer(unsigned(write_addr)))(15 downto 8) <= write_data;
                when "00" =>
                    instr_mem(to_integer(unsigned(write_addr)))(7 downto 0) <= write_data;
                when others =>

            end case;
        end if;
    end process;

end Behavioral;
