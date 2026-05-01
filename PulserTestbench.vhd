library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity PulserTestbench is
end PulserTestbench;

architecture arch of PulserTestbench is
    component Pulse256hz is
        port (
            clk, reset : IN STD_LOGIC;
            pulse, pulse2 : OUT STD_LOGIC
        );
    end component;
    signal clk : STD_LOGIC := '0';
    signal pulse, pulse2 : STD_LOGIC := '0';
    signal reset, success : std_logic := '1';
begin
    reset <= '1', '0' after 11 ns;
    clk <= not clk after 5 ns; --acts as a clock
    dut:Pulse256hz
    port map(
        clk => clk,
        reset => reset,
        pulse => pulse,
        pulse2 => pulse2
    );
    stimulus:
    process begin
        wait until reset = '0';
        wait for 1953119 ns;
        if pulse2 /= '1' then
            success <= '0';
        end if;
        wait for 1953120 ns;
        if pulse /= '1' then
            success <= '0';
        end if;
        wait;
    end process stimulus;
end arch;