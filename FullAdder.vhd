library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        S  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end FullAdder;

architecture Behavioral of FullAdder is
begin
    process(A, B, Cin)
    begin
        S  <= A XOR B XOR Cin;
        Cout <= (A AND B) OR (B AND Cin) OR (A AND Cin);
    end process;
end Behavioral;