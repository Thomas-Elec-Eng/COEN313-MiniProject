library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity PlayerHandler_Testbench is
end entity;

architecture rtl of PlayerHandler_Testbench is
    component PlayerHandler_v2 is
        port (
            clk, reset, GR, pulse, switch, start, fin : IN STD_LOGIC;
            display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            dead, win : OUT STD_LOGIC
        );
    end component;
    component TestingPulse is
        port (
            clk, reset : IN STD_LOGIC;
            pulse, pulse2 : OUT STD_LOGIC
        );
    end component;
    signal clk, GR, pulse, pulse2, switch, start, fin, dead, win : std_logic := '0';
    signal reset, success : STD_LOGIC := '1';
    signal display : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
--    reset <= '1', '0' after 11 ns;
    clk <= not clk after 5 ns; --acts as a clock
    dut:playerhandler_v2
    port map(
        clk => clk,
        reset => reset,
        GR => GR,
        pulse => pulse,
        switch => switch,
        start => start,
        fin => fin,
        display => display,
        dead => dead,
        win => win
    );
    pulser:TestingPulse
    port map(
        clk => clk,
        reset => reset,
        pulse => pulse,
        pulse2 => pulse2
    );
    stimulus:
    process begin
        wait for 11 ns;
        reset <= '0';
--        wait until reset = '0';
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        switch <= '1';
        wait for 10 ns;
        GR <= '1';
        wait for 10 ns;
        if dead /= '1' then
            success <= '0';
        end if;
        wait for 9 ns;
        --testing other players ending the game
        reset <= '1';
        GR <= '0';
        switch <= '0';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        fin <= '1';
        wait for 10 ns;
        if dead /= '1' then
            success <= '0';
        end if;
        wait for 10 ns;
        -- Letting the player win
        reset <= '1';
        fin <= '0';
        GR <= '0';
        switch <= '0';
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        switch <= '1';
        wait for 10 ns;
        wait for 500 us;
        GR <= '1';
        wait for 10 ns;
        if win /= '1' then
            success <= '0';
        end if;
        wait;
    end process stimulus;
    
end architecture;