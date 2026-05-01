library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity GameHandler_Testbench is
end entity;

architecture rtl of GameHandler_Testbench is
    component GameHandler_v2 is
        port (
            clk, reset, all_dead, pulse, start : IN STD_LOGIC;
            display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            GR, gameReset, GameOver : OUT STD_LOGIC
        );
    end component;
    component TestingPulse is
        port (
            clk, reset : IN STD_LOGIC;
            pulse, pulse2 : OUT STD_LOGIC
        );
    end component;
    signal clk, all_dead, pulse, pulse2, start, GR, gameReset, GameOver : STD_LOGIC := '0';
    signal display, base : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    signal reset, success : STD_LOGIC := '1';
begin
    clk <= not clk after 5 ns;
--    reset <= '1', '0' after 7 ns;
    dut:GameHandler_v2
    port map(
        clk => clk,
        reset => reset,
        all_dead => all_dead,
        pulse => pulse,
        start => start,
        display => display,
        GR => GR,
        gameReset => gameReset,
        GameOver => GameOver
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
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait for 20 ns;
        for i in 0 to 9 loop -- Check full Iteration loop
            case i is
                when 0 => base <= "01100000"; --1 6s
                when 1 => base <= "01001000"; --2 4.5s
                when 2 => base <= "00110110"; --3 3.375s
                when 3 => base <= "00101000"; --4 2.53125s
                when 4 => base <= "00011110"; --5 1.8984375s
                when 5 => base <= "00010110"; --6 1.421875s
                when 6 => base <= "00010001"; --7 1.06640625s
                when 7 => base <= "00001100"; --8 0.80078125s
                when 8 => base <= "00001001"; --9 0.59765625s
                when 9 => base <= "00000111"; --10 0.44921875s
--            when 10 => base <= "00000000"; --11 Winner iteration
                when others => base <= "00000000"; -- Nothing should ever get into here
            end case;
            wait for 10 ns;
            start <= '1';
            wait for 10 ns;
            start <= '0';
            wait for 10 ns;
            if display /= base then
                success <= '0';
            end if;
            wait until gr = '1';
        end loop;
        reset <= '1';
        wait for 11 ns;
        reset <= '0';
        wait for 1009 ns; -- Check all_dead signal
        start <= '1';
        wait for 10 ns;
        start <= '0';
        wait for 1000 ns;
        all_dead <= '1';
        wait for 20 ns;
        if GameOver /= '1' then
            success <= '0';
        end if;
        wait for 10 ns;
        reset <= '1';
        all_dead <= '0';
        wait for 11 ns;
        reset <= '0';
        wait for 9 ns;
        start <= '1';
        wait for 10 ns; -- See what happens when start is pressed and left running
        start <= '0';
        wait for 500 us;
        reset <= '1';
        wait;
    end process stimulus;

end architecture;