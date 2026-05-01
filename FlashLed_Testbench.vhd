library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity FlashLed_Testbench is
end FlashLed_Testbench;

architecture arch of FlashLed_Testbench is
    component FlashLed is
        port (
            clk, reset, pulse: in STD_LOGIC;
            LED : out std_logic
        );
    end component;
    signal clk, pulse, LED : STD_LOGIC := '0';
    signal reset, success : STD_LOGIC := '1';
begin
    reset <= '1', '0' after 11 ns;
    clk <= not clk after 5 ns; --acts as a clock
    dut:FlashLed
    port map(
        clk => clk,
        pulse => pulse,
        reset => reset,
        LED => LED
    );
    stimulus:
    process begin
        wait until reset = '0';
        for i in 0 to 14 loop
            pulse <= '1';
            wait for 10 ns;
            pulse <= '0';
            wait for 10 ns;
        end loop;
        if LED /= '1' then
            success <= '0';
        end if;
        for i in 0 to 14 loop
            pulse <= '1';
            wait for 10 ns;
            pulse <= '0';
            wait for 10 ns;
        end loop;
        if LED /= '0' then
            success <= '0';
        end if;
    end process stimulus;

end arch;