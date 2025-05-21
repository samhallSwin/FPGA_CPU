library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU_tb is
end CPU_tb;

architecture Behavioral of CPU_tb is

    constant CLK_PERIOD : time := 10 ns;

    -- Signals to connect to CPU
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '1'; -- start with reset asserted
    signal cpu_run      : STD_LOGIC := '0'; 

    -- Instruction Memory write interface
    signal write_enable : STD_LOGIC := '0';
    signal write_addr   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal byte_select  : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal write_data   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    signal data_out     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data_in      : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

    -- Instantiate CPU
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

    -- Clock Generation
    clk_process : process
    begin
        while True loop
            clk <= '1';
            wait for CLK_PERIOD / 2;
            clk <= '0';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Instruction Memory Loader (ignore this)
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
            wait for CLK_PERIOD;
            write_enable <= '0';
            wait for CLK_PERIOD;
        end procedure;
    begin

        wait for CLK_PERIOD * 4;
        reset <= '0';

        wait for CLK_PERIOD * 2;
        cpu_run <= '1';
        --------------
        --Add test logic below this
        -------------

        
        wait;
    end process;

end Behavioral;
