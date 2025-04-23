library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AndGate is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        S    : out STD_LOGIC
    );
end AndGate;

architecture Behavioral of AndGate is
begin
    process(A, B)
    begin
        S  <= A AND B;
    end process;
end Behavioral;