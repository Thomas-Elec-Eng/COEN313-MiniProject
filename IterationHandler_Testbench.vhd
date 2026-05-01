library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity IterationHandler_Testbench is
end entity;

architecture arch of IterationHandler_Testbench is
    component IterationHandler_v2 is
        port (
            clk, goNext, reset : IN STD_LOGIC;
            timer : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            final : OUT STD_LOGIC
        );
    end component;
    signal goNext, final, clk : STD_LOGIC := '0';
    signal reset, success : STD_LOGIC := '1';
    signal timer : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
begin
    clk <= not clk after 5 ns;
    goNext <= not goNext after 10 ns;
    dut:IterationHandler_v2
    port map(
        goNext => goNext,
        reset => reset,
        timer => timer,
        final => final,
        clk => clk
    );
    stimulus:
    process begin
        reset <= '1';
        wait for 7 ns;
        reset <= '0';
        wait for 180 ns;
        if final /= '1' then
            success <= '0';
        end if;
        wait for 3 ns;
        reset <= '1';
        wait for 7 ns;
        reset <= '0';
        wait;
    end process stimulus;
end arch;