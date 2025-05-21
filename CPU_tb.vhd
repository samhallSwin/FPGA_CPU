library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_tb is
end CPU_tb;

architecture Behavioral of CPU_tb is

    -- Signals to connect to CPU
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '1'; -- start with reset asserted
    signal cpu_run      : STD_LOGIC := '0'; -- start with reset asserted

    -- Instruction Memory write interface
    signal write_enable : STD_LOGIC := '0';
    signal write_addr   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal byte_select  : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal write_data   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    signal data_out     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data_in      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    -- Instantiate CPU with extended ports
    UUT: entity work.CPU
        generic map (
            N => 8
        )
        port map (
            clk          => clk,
            cpu_run      => cpu_run,
            reset        => reset,
            data_out     => data_out,
            data_in      => data_in,
            write_enable => write_enable,
            write_addr   => write_addr,
            byte_select  => byte_select,
            write_data   => write_data
        );

    -- Clock Generation: 10ns period
    clk_process : process
    begin
        while True loop
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
        end loop;
    end process;

    -- Instruction Memory Loader
    imem_loader : process
        procedure write_instr_byte(
            addr : in STD_LOGIC_VECTOR(7 downto 0);
            sel  : in STD_LOGIC_VECTOR(1 downto 0);
            data : in STD_LOGIC_VECTOR(7 downto 0)
        ) is
        begin
            write_enable <= '1';
            write_addr   <= addr;
            byte_select  <= sel;
            write_data   <= data;
            wait for 10 ns;
            write_enable <= '0';
            wait for 10 ns;
        end procedure;
    begin

        wait for 40 ns;
        reset <= '0';

        data_in <= x"FA";
        wait for 20 ns;
        cpu_run <= '1';

        wait;
    end process;

end Behavioral;
