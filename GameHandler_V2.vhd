LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
ENTITY GameHandler_v2 IS
    PORT (
        clk, reset, all_dead, pulse, start : IN STD_LOGIC;
        display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        GR, gameReset, GameOver : OUT STD_LOGIC);
    -- Clock is clock, reset resets the whole game, pulse is for the pulse from the 256hz pulser, start is the pulse to start the iteration.
    -- display is ouput for display
    -- GR is the Green/Red light output; 0 is green, 1 is red. gameReset sents the pulse to reset the game to all the other systems.
END ENTITY;

ARCHITECTURE rtl OF GameHandler_v2 IS
    COMPONENT counter12bit IS
        PORT (
            clk, reset, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            p : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT IterationHandler_v2 IS
        PORT (
            clk, goNext, reset : IN STD_LOGIC;
            timer : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            final : OUT STD_LOGIC);
    END COMPONENT;
    TYPE Game_state IS (standby, game_running, nextIterations, betweenIterations, TheEnd);
    SIGNAL state_reg, state_next : game_state;
    SIGNAL number, current : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL run, goNext, enable_run : STD_LOGIC;
    SIGNAL IterationEnd, finalIteration, counter_reset, reset2 : STD_LOGIC := '0';
BEGIN
    -- steps
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            state_reg <= standby;
        ELSIF rising_edge(clk) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS;
    -- transitions
    PROCESS (state_reg, start, iterationEnd, finalIteration, all_dead)
    BEGIN
        CASE state_reg IS
            WHEN standby =>
                IF start = '1' THEN
                    state_next <= game_running;
                ELSE
                    state_next <= standby;
                END IF;
            WHEN game_running =>
                IF IterationEnd = '1' THEN
                    IF finalIteration = '1' THEN
                        state_next <= TheEnd;
                    ELSE
                        state_next <= nextIterations;
                    END IF;
                ELSIF all_dead = '1' THEN
                    state_next <= TheEnd;
                ELSE
                    state_next <= game_running;
                END IF;
            when nextIterations =>
                state_next <= betweenIterations;
            WHEN betweenIterations =>
                IF start = '1' THEN
                    state_next <= game_running;
                ELSIF all_dead = '1' THEN
                    state_next <= TheEnd;
                ELSE
                    state_next <= betweenIterations;
                END IF;
            WHEN TheEnd =>
                state_next <= TheEnd;
        END CASE;
    END PROCESS;
    -- actions
    PROCESS (state_reg)
    BEGIN
        reset2 <= '0';
        GR <= '1';
        enable_run <= '0';
        counter_reset <= '0';
        gameOver <= '0';
        goNext <= '0';
        CASE state_reg IS
            WHEN standby =>
                counter_reset <= '1';
                reset2 <= '1';
            WHEN game_running =>
                GR <= '0';
                enable_run <= '1';
            when nextIterations =>
                goNext <= '1';
            WHEN betweenIterations =>
                counter_reset <= '1';
            WHEN TheEnd =>
                GameOver <= '1';
        END CASE;
    END PROCESS;
    run <= enable_run AND pulse;
    gameReset <= reset2;

    IterationHandler_inst : IterationHandler_v2
    PORT MAP(
        clk => clk,
        goNext => goNext,
        reset => reset2,
        timer => number,
        final => finalIteration
    );
    counter12bit_inst : counter12bit
    PORT MAP(
        clk => clk,
        reset => counter_reset,
        en => run,
        n => number,
        p => IterationEnd,
        q => current
    );
    display <= number(11 DOWNTO 4); -- We do not need the complete accuracy to display to the player
END ARCHITECTURE;
