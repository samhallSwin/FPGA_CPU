library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    generic (
        N : integer := 8;  -- Register width
        R : integer := 8   -- Number of registers (must be a power of 2)
    );
    port (
        clk        : in  STD_LOGIC;
        reset      : in  STD_LOGIC;
        read_addr1 : in  STD_LOGIC_VECTOR(integer(ceil(log2(real(R)))) - 1 downto 0);
        read_addr2 : in  STD_LOGIC_VECTOR(integer(ceil(log2(real(R)))) - 1 downto 0);
        write_addr : in  STD_LOGIC_VECTOR(integer(ceil(log2(real(R)))) - 1 downto 0);
        write_data : in  STD_LOGIC_VECTOR(N-1 downto 0);
        write_en   : in  STD_LOGIC;
        read_data1 : out STD_LOGIC_VECTOR(N-1 downto 0);
        read_data2 : out STD_LOGIC_VECTOR(N-1 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    subtype reg_addr_t is INTEGER range 0 to R-1;
    type reg_array_t is array (reg_addr_t) of STD_LOGIC_VECTOR(N-1 downto 0);
    signal regs : reg_array_t := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                regs <= (others => (others => '0'));
            elsif write_en = '1' then
                regs(to_integer(unsigned(write_addr))) <= write_data;
            end if;
        end if;
    end process;

    read_data1 <= regs(to_integer(unsigned(read_addr1)));
    read_data2 <= regs(to_integer(unsigned(read_addr2)));

end Behavioral;
