library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.opCodes_pkg.ALL;

entity ControlUnit is
    port (
        clk         : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        opcode      : in  opCode_t;
        reg_write   : out STD_LOGIC;
        alu_op      : out STD_LOGIC_VECTOR(7 downto 0);
        alu_src     : out STD_LOGIC; -- '0' = register, '1' = immediate
        mem_read    : out STD_LOGIC;
        mem_write   : out STD_LOGIC;
        mem_to_reg  : out STD_LOGIC; -- '1' = load from memory to register
        jump        : out STD_LOGIC;
        branch      : out STD_LOGIC
    );
end ControlUnit;

architecture Behavioral of ControlUnit is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg_write  <= '0';
            alu_op     <= (others => '0');
            alu_src    <= '0';
            mem_read   <= '0';
            mem_write  <= '0';
            mem_to_reg <= '0';
            jump       <= '0';
            branch     <= '0';

        elsif rising_edge(clk) then
            case opcode is
                when OP_ADD =>
                    reg_write  <= '1';
                    alu_op     <= x"00";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_SUB =>
                    reg_write  <= '1';
                    alu_op     <= x"01";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_AND =>
                    reg_write  <= '1';
                    alu_op     <= x"02";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_OR =>
                    reg_write  <= '1';
                    alu_op     <= x"03";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_XOR =>
                    reg_write  <= '1';
                    alu_op     <= x"04";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_LOAD =>
                    reg_write  <= '1';
                    alu_op     <= x"00"; -- ADD for address calc
                    alu_src    <= '1';
                    mem_read   <= '1';
                    mem_write  <= '0';
                    mem_to_reg <= '1';
                    jump       <= '0';
                    branch     <= '0';

                when OP_STORE =>
                    reg_write  <= '0';
                    alu_op     <= x"00"; -- ADD for address calc
                    alu_src    <= '1';
                    mem_read   <= '0';
                    mem_write  <= '1';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';

                when OP_JMP =>
                    reg_write  <= '0';
                    alu_op     <= x"00"; -- NOP placeholder
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '1';
                    branch     <= '0';

                when OP_BEQ =>
                    reg_write  <= '0';
                    alu_op     <= x"01"; -- SUB for compare
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '1';

                when others =>
                    reg_write  <= '0';
                    alu_op     <= x"00";
                    alu_src    <= '0';
                    mem_read   <= '0';
                    mem_write  <= '0';
                    mem_to_reg <= '0';
                    jump       <= '0';
                    branch     <= '0';
            end case;
        end if;
    end process;
end Behavioral;
