LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.NUMERIC_STD.ALL;
ENTITY Main IS
    PORT (
        clk : IN STD_LOGIC;
        start, gamereset : IN STD_LOGIC;
        ABCDEFGDP, Display_on : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        Switch_play1, Switch_play2, Switch_play3, Switch_play4 : IN STD_LOGIC;
        LED_play1, LED_play2, LED_play3, LED_play4, Green, Red : OUT STD_LOGIC
    );
END ENTITY;
-- signals will be created close to the component originator
ARCHITECTURE arch OF Main IS
    COMPONENT PlayerHandler_v2 IS -- four of these are needed
        PORT (
            clk, reset, GR, pulse, switch, start, fin : IN STD_LOGIC;
            display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            dead, win : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL play1_dead, play2_dead, play3_dead, play4_dead : STD_LOGIC := '0';
    SIGNAL play1_win, play2_win, play3_win, play4_win : STD_LOGIC := '0';
    SIGNAL play1_display, play2_display, play3_display, play4_display : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    COMPONENT GameHandler_v2 IS -- one of these is required
        PORT (
            clk, reset, all_dead, pulse, start : IN STD_LOGIC;
            display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            GR, gameReset, GameOver : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL GR, reset : STD_LOGIC := '1'; -- GR of 1 means red light; reset starts at 1 to get all components in correct setup
    SIGNAL GameOver, all_dead : STD_LOGIC := '0'; -- all_dead: play1 to play4 dead all connected to "and" gates
    SIGNAL IterationTime_display : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    COMPONENT DisplayHandler_v2 IS -- one of these is required
        PORT (
            reset, start, clk, pulse, pulse2 : IN STD_LOGIC;
            sevenSegment : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            DP : OUT STD_LOGIC;
            whichsegment : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            iteration, play1, play2, play3, play4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL special_reset : STD_LOGIC := '0'; -- Special reset required to return back to show next iteration time and player distance
    COMPONENT FlashLed IS -- one of these
        PORT (
            clk, reset, pulse : IN STD_LOGIC;
            LED : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL flash_LED : STD_LOGIC := '0';
    COMPONENT Pulse256hz IS -- one of these
        PORT (
            clk, reset : IN STD_LOGIC;
            pulse, pulse2 : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL pulse, pulse2 : STD_LOGIC := '0';
    SIGNAL temp : BOOLEAN := false;
    signal reset_unused : std_logic;
BEGIN
    -- Component Instantiation
    Pulser : Pulse256hz
    PORT MAP(
        clk => clk,
        reset => reset_unused,
        pulse => pulse,
        pulse2 => pulse2
    );
    GameHandler_inst : GameHandler_v2
    PORT MAP(
        clk => clk,
        reset => gamereset,
        all_dead => all_dead,
        pulse => pulse,
        start => start,
        display => IterationTime_display,
        GR => GR,
        gameReset => Reset,
        GameOver => GameOver
    );
    player1 : playerhandler_v2
    PORT MAP(
        clk => clk,
        reset => reset,
        GR => GR,
        pulse => pulse,
        switch => switch_play1,
        start => start,
        fin => GameOver,
        display => play1_display,
        dead => play1_dead,
        win => play1_win
    );
    player2 : playerhandler_v2
    PORT MAP(
        clk => clk,
        reset => reset,
        GR => GR,
        pulse => pulse,
        switch => switch_play2,
        start => start,
        fin => GameOver,
        display => play2_display,
        dead => play2_dead,
        win => play2_win
    );
    player3 : playerhandler_v2
    PORT MAP(
        clk => clk,
        reset => reset,
        GR => GR,
        pulse => pulse,
        switch => switch_play3,
        start => start,
        fin => GameOver,
        display => play3_display,
        dead => play3_dead,
        win => play3_win
    );
    player4 : playerhandler_v2
    PORT MAP(
        clk => clk,
        reset => reset,
        GR => GR,
        pulse => pulse,
        switch => switch_play4,
        start => start,
        fin => GameOver,
        display => play4_display,
        dead => play4_dead,
        win => play4_win
    );
    DisplayHandler_inst : DisplayHandler_v2
    PORT MAP(
        reset => special_reset,
        start => start,
        clk => clk,
        sevenSegment => ABCDEFGDP(7 DOWNTO 1),
        DP => ABCDEFGDP(0),
        whichsegment => Display_on,
        iteration => IterationTime_display,
        play1 => play1_display,
        play2 => play2_display,
        play3 => play3_display,
        play4 => play4_display,
        pulse => pulse,
        pulse2 => pulse2
    );
    FlashLed_inst : FlashLed
    PORT MAP(
        clk => clk,
        reset => reset,
        LED => flash_LED,
        pulse => pulse
    );
    -- interconnect logic
    all_dead <= (play1_dead AND play2_dead) AND (play3_dead AND play4_dead);
    special_reset <= '1' WHEN temp OR reset = '1' ELSE '0';
    temp <= rising_edge(GR) AND pulse = '0';
    LED_play1 <= ((NOT play1_dead) AND (NOT play1_win)) OR (flash_LED AND play1_win);
    LED_play2 <= ((NOT play2_dead) AND (NOT play2_win)) OR (flash_LED AND play2_win);
    LED_play3 <= ((NOT play3_dead) AND (NOT play3_win)) OR (flash_LED AND play3_win);
    LED_play4 <= ((NOT play4_dead) AND (NOT play4_win)) OR (flash_LED AND play4_win);
    Green <= NOT GR;
    Red <= GR;
END ARCHITECTURE;
