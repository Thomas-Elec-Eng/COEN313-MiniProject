library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity DFFR_Testbench is
end DFFR_Testbench;

architecture rtl of DFFR_Testbench is
    component DFFR is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            d : in STD_LOGIC;
            q : out STD_LOGIC
        );
    end component;
    signal clk : std_logic := '0';
    signal reset, success, d, q_expected : std_logic := '1';
    signal q : STD_LOGIC;
begin
    reset <= '1', '0' after 11 ns;
    clk <= not clk after 5 ns; --acts as a clock
    q_expected <= not q_expected after 10 ns;
    d <= not q;
    dut:DFFR
    port map(
        clk => clk,
        reset => reset,
        d => d,
        q => q
    );
    stimulus:
    process begin
        wait until reset = '0';
        if (q /= q_expected) then
            success <= '0';
        end if;
    end process stimulus;

end architecture;