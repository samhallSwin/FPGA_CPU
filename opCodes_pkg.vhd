library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package ALU_Pkg is

    -- Define enumerated ALU operations
    type ALU_Opcode is (
        OP_ADD,    -- 000
        OP_SUB,    -- 001
        OP_AND,    -- 010
        OP_OR,     -- 011
        OP_XOR,    -- 100
        OP_NOP     -- 101 (default/no operation)
    );