library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity Main_testbench is
end entity;

architecture rtl of Main_testbench is
    component Main is
        port (
            clk : IN STD_LOGIC;
            start, gamereset : IN STD_LOGIC;
            ABCDEFGDP, Display_on : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            Switch_play1, Switch_play2, Switch_play3, Switch_play4 : IN STD_LOGIC;
            LED_play1, LED_play2, LED_play3, LED_play4, Green, Red : OUT STD_LOGIC
        );
    end component;
    signal clk : std_logic := '0';
    signal start, Green, Red : std_logic := '0';
    signal ABCDEFGDP, Display_on : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Switch_play1, switch_play2, Switch_play3, Switch_play4 : STD_LOGIC := '0';
    signal LED_play1, LED_play2, LED_play3, LED_play4 : STD_LOGIC := '0';
    signal gamereset, success : STD_LOGIC := '1';
begin
    --gamereset <= '1', '0' after 7 ns;
    clk <= not clk after 5 ns; --acts as a clock
    dut:Main
    port map(
        clk => clk,
        start => start,
        gamereset => gamereset,
        ABCDEFGDP => ABCDEFGDP,
        Display_on => Display_on,
        Switch_play1 => Switch_play1,
        switch_play2 => switch_play2,
        Switch_play3 => Switch_play3,
        Switch_play4 => Switch_play4,
        LED_play1 => LED_play1,
        LED_play2 => LED_play2,
        LED_play3 => LED_play3,
        LED_play4 => LED_play4,
        Red => Red,
        Green => Green
    );
    stimulus:
    process begin
        --wait until gamereset = '0';
        gamereset <= '1';
        wait for 7 ns;
        gamereset <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 10 ns;
        Switch_play1 <= '1';
        switch_play2 <= '1';
        wait for 245 us;
        Switch_play1 <= '0';
        wait for 1 us;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        Switch_play1 <= '1';
        wait for 183 us;
        Switch_play1 <= '0';
        switch_play2 <= '0';
        wait for 2 us;
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 10 ns;
        Switch_play1 <= '1'; -- Player 1 will win
        wait for 179 us;
        Switch_play1 <= '0';
        wait for 1 us;
        gamereset <= '1';
        wait for 10 ns;
        gamereset <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 10 ns;
        Switch_play1 <= '1'; -- All player die
        switch_play2 <= '1';
        Switch_play3 <= '1';
        switch_play4 <= '1';
        wait for 255 us;
        gamereset <= '1';
        wait for 10 ns;
        gamereset <= '0';
        Switch_play1 <= '0';
        switch_play2 <= '0';
        Switch_play3 <= '0';
        switch_play4 <= '0';
        wait for 10 ns;
        start <= '1';
        wait until LED_play1='0'; -- Let all iterations run
        start <= '0';
        wait for 10 ns;
        gamereset <= '1';
        wait for 10 ns;
        gamereset <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        Switch_play1 <= '1';
        wait for 245 us;
        Switch_play1 <= '0';
        wait;
    end process stimulus;

end architecture;