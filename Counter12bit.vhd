LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY counter12bit IS
    PORT (
        clk, reset, en : IN STD_LOGIC;
        n : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        p : OUT STD_LOGIC);
    -- n is the number that the counter will reset at and pulse at.
    -- p is the pulse output.
END ENTITY;

ARCHITECTURE seq OF counter12bit IS
    SIGNAL r_reg, r_next, r_inc : unsigned(11 DOWNTO 0);
    SIGNAL rollover : BOOLEAN; -- This was originally only intended for player counters; but it's also used for green and red light counter
    SIGNAL p_temp : STD_LOGIC;
BEGIN
    PROCESS (clk, reset, en)
    BEGIN
        IF (reset = '1') THEN
            r_reg <= (OTHERS => '0');
        ELSIF (clk'event AND clk = '1' AND en = '1') THEN
            r_reg <= r_next;
        END IF;
    END PROCESS;
    r_inc <= r_reg + "1";
    r_next <= (OTHERS => '0') WHEN rollover ELSE
              r_inc;
    rollover <= r_inc = UNSIGNED(n);
    q <= STD_LOGIC_VECTOR(r_reg);
    p_temp <= '1' WHEN rollover ELSE '0';
    PROCESS (p_temp, reset)
    BEGIN
        IF (reset = '1') THEN
            p <= '0';
        ELSE
            p <= p_temp;
        END IF;
    END PROCESS;
END ARCHITECTURE;
