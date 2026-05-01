LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.std_logic_unsigned.ALL;
ENTITY playerhandler_v2 IS
    PORT (
        clk, reset, GR, pulse, switch, start, fin : IN STD_LOGIC;
        display : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        dead, win : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE rtl OF playerhandler_v2 IS
    COMPONENT counter12bit
        PORT (
            clk, reset, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            p : OUT STD_LOGIC);
    END COMPONENT;
    TYPE player_state IS (standby, game_running, died, winner);
    SIGNAL state_reg, state_next : player_state;
    SIGNAL number, current : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL preCounterEnable, CounterEnable, CounterDone, kill, debugger : STD_LOGIC := '0';
BEGIN
    -- Steps
    PROCESS (clk, reset, pulse)
    BEGIN
        IF reset = '1' THEN
            state_reg <= standby;
        ELSIF rising_edge(clk) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS;
    -- Transitions
    kill <= GR AND switch;
    PROCESS (start, fin, kill, CounterDone, state_reg)
    BEGIN
        CASE state_reg IS
            WHEN standby =>
                IF start = '1' THEN
                    state_next <= game_running;
                ELSE
                    state_next <= standby;
                END IF;
            WHEN game_running =>
                IF kill = '1' OR fin = '1' THEN
                    state_next <= died;
                ELSIF CounterDone = '1' THEN
                    state_next <= winner;
                ELSE
                    state_next <= game_running;
                END IF;
            WHEN died =>
                state_next <= died;
            WHEN winner =>
                state_next <= winner;
        END CASE;
    END PROCESS;
    -- Actions
    PROCESS (state_reg)
    BEGIN
        dead <= '0';
        win <= '0';
        preCounterEnable <= '0';
        debugger <= '0';
        CASE state_reg IS
            WHEN standby =>
                debugger <= '1';
            WHEN game_running =>
                preCounterEnable <= '1';
            WHEN died =>
                dead <= '1';
            WHEN winner =>
                win <= '1';
        END CASE;
    END PROCESS;
    CounterEnable <= preCounterEnable AND switch AND pulse;

    number <= "110000000001"; --this is 12 meters with accuracy down to 3.90625 millimeter
    unit1 : counter12bit PORT MAP(clk => clk, reset => reset, en => CounterEnable, n => number, p => CounterDone, q => current);
    display <= current(11 DOWNTO 4); -- We do not need the complete accuracy to display to the player
END ARCHITECTURE;
