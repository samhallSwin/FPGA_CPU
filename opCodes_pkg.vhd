---------------------------------------
-- This package names our instruction set we can use to program our CPU. It also lists registers for ease of use and contains some helper functions.
-- The helper functions are just there to dealk with some quirks of VHDL - don't worry about them too much.
-- All instructions are 4 bytes long, in the form [OpCode][Arg1][arg2][arg3]. Not all instructions need all arguments, so you can just zero it with (others => '0')
-- The requirements for each instruction are documented below. 
-- When creating a new instruction MAKE SURE TO COMMENT IT'S USAGE - it'll make life easier later.
--------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package opCodes_Pkg is

    -- Subtypes for 8-bit and 32-bit
    subtype Byte is STD_LOGIC_VECTOR(7 downto 0);
    subtype Word is STD_LOGIC_VECTOR(31 downto 0);

    -- ALU operations. 
    type ALU_Opcode is ( 
        OP_NOP, -- Does nothing..   
        OP_ADD, -- A + B. Arguments: A_reg, B_reg, Dest_reg 
        OP_SUB, -- A - B. Arguments: A_reg, B_reg, Dest_reg 
        OP_AND, -- A AND B. Arguments: A_reg, B_reg, Dest_reg 
        OP_OR, -- A OR B. Arguments: A_reg, B_reg, Dest_reg 
        OP_XOR, -- A XOR B. Arguments: A_reg, B_reg, Dest_reg 
        OP_MOV, -- Puts a value in a register. Arguments: Value, N/A, Dest_reg 
        OP_JEQ, -- Moves the program counter to target when A = B. Arguments: A_reg, B_reg, PC_target 
        OP_JLT, -- Moves the program counter to target when A < B. Arguments: A_reg, B_reg, PC_target
        OP_JGT,  -- Moves the program counter to target when A > B. Arguments: A_reg, B_reg, PC_target
        OP_IN,   -- Sends the input data to a register. Arguments: N/A, N/A, dest_reg
        OP_OUT  -- Sends the content of a register to the output. Arguments: A_reg, N/A, N/A
    );

    -- Register names
    type register_codes is (
        R0, R1, R2, R3, R4, R5, R6, R7
    );

    function to_opcode(vec : STD_LOGIC_VECTOR) return ALU_Opcode;
    function opcode_to_stdvec(op : ALU_Opcode) return Byte;
    function regcode_to_stdvec(r : register_codes) return Byte;
    function make_instr(
        op   : ALU_Opcode;
        arg1 : Byte;
        arg2 : Byte;
        arg3 : Byte
    ) return Word;

end package;


package body opCodes_Pkg is

    function to_opcode(vec : STD_LOGIC_VECTOR) return ALU_Opcode is
        variable v : integer;
    begin
        v := to_integer(unsigned(vec)); --When adding new instructions, make sure to add it here too
        case v is
            when 0  => return OP_NOP;
            when 1  => return OP_ADD;
            when 2  => return OP_SUB;
            when 3  => return OP_AND;
            when 4  => return OP_OR;
            when 5  => return OP_XOR;
            when 6  => return OP_MOV;
            when 7  => return OP_JEQ;
            when 8  => return OP_JLT;
            when 9  => return OP_JGT;
            when 10  => return OP_IN;
            when 11  => return OP_OUT;
            when others => return OP_NOP;
        end case;
    end function;

    function opcode_to_stdvec(op : ALU_Opcode) return Byte is
        variable opcode_int : integer;
    begin
        opcode_int := ALU_Opcode'pos(op);
        return std_logic_vector(to_unsigned(opcode_int, 8));
    end function;
    

    function regcode_to_stdvec(r : register_codes) return Byte is
        variable reg_int : integer;
    begin
        reg_int := register_codes'pos(r);
        return std_logic_vector(to_unsigned(reg_int, 8));
    end function;

    function make_instr(
        op   : ALU_Opcode;
        arg1 : Byte;
        arg2 : Byte;
        arg3 : Byte
    ) return Word is
    begin
        return opcode_to_stdvec(op) & arg1 & arg2 & arg3;
    end function;

end package body;
