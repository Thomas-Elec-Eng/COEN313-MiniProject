LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY counter4bit IS
    PORT (
        reset, clk, en : IN STD_LOGIC;
        n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        p : OUT STD_LOGIC);
    -- n is the number that the counter will reset at and pulse at.
END ENTITY;

ARCHITECTURE seq OF counter4bit IS
    SIGNAL r_reg, r_next, r_inc : unsigned(3 DOWNTO 0) := (others => '0');
    SIGNAL rollover : BOOLEAN;
BEGIN
    PROCESS (clk, reset, en)
    BEGIN
        IF (reset = '1') THEN
            r_reg <= (OTHERS => '0');
        ELSIF rising_edge(clk) AND en = '1' THEN
            r_reg <= r_next;
        END IF;
    END PROCESS;
    r_inc <= r_reg + "1";
    r_next <= (OTHERS => '0') WHEN rollover ELSE
              r_inc;
    rollover <= r_inc = unsigned(n);
    q <= STD_LOGIC_VECTOR(r_reg);
    p <= '1' WHEN rollover ELSE '0';
    --        PROCESS (rollover, reset)
    --        BEGIN
    --            IF (reset = '1') THEN
    --                p <= '0';
    --            ELSIF rollover THEN
    --                p <= '1';
    --            END IF;
    --        END PROCESS;
END ARCHITECTURE;
