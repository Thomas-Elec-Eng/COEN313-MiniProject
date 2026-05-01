library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity Counter4bitTestbench is
end Counter4bitTestbench;

architecture arch of Counter4bitTestbench is
    component Counter4bit is
        port (
            reset, clk, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            p : OUT STD_LOGIC
        );
    end component;
    signal clk : STD_LOGIC := '0';
    signal n : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
    signal q : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    signal p : STD_LOGIC := '0';
    signal reset, success, en : std_logic := '1';
begin
    reset <= '1', '0' after 11 ns;
    clk <= not clk after 5 ns; --acts as a clock
    dut:counter4bit
    port map(
        reset => reset,
        clk => clk,
        n => n,
        q => q,
        p => p,
        en => en
    );
    stimulus:
    process begin
        wait until reset = '0';
        wait for 5 ns;
        if q /= "0001" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0010" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0011" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0100" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0101" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0110" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0111" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1000" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1001" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1010" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1011" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1100" then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "1101" then
            success <= '0';
        end if;
        wait for 10 ns;
        if (q /= "1110") and (p = '1') then
            success <= '0';
        end if;
        wait for 10 ns;
        if q /= "0000" then
            success <= '0';
        end if;
        n <= "1110";
        wait for 140 ns;
        if q /= "0000" then
            success <= '0';
        end if;
        n <= "1000";
        wait for 80 ns;
        if q /= "0000" then
            success <= '0';
        end if;
        wait for 16 ns;
        en <= '0';
        wait for 10 ns;
        if q /= "0001" then
            success <= '0';
        end if;
        wait;
    end process stimulus;
end arch;