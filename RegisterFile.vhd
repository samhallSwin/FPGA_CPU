library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    generic (
        N : integer := 8;   -- Data width
        NUM_REGS : integer := 8  -- Number of registers
    );
    port (
        clk         : in  STD_LOGIC;
        we          : in  STD_LOGIC; -- Write enable
        read_addr1  : in  STD_LOGIC_VECTOR(2 downto 0); -- 3 bits for 8 regs
        read_addr2  : in  STD_LOGIC_VECTOR(2 downto 0);
        write_addr  : in  STD_LOGIC_VECTOR(2 downto 0);
        write_data  : in  STD_LOGIC_VECTOR(N-1 downto 0);
        read_data1  : out STD_LOGIC_VECTOR(N-1 downto 0);
        read_data2  : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type reg_array is array (0 to NUM_REGS-1) of STD_LOGIC_VECTOR(N-1 downto 0);
    signal regs : reg_array := (others => (others => '0'));
begin

    -- Read ports (combinational)
    read_data1 <= regs(to_integer(unsigned(read_addr1)));
    read_data2 <= regs(to_integer(unsigned(read_addr2)));

    -- Write port (clocked)
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                regs(to_integer(unsigned(write_addr))) <= write_data;
            end if;
        end if;
    end process;

end Behavioral;