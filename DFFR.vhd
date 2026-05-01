LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DFFR IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        d : IN STD_LOGIC;
        q : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE arch OF DFFR IS
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            q <= '0';
        ELSIF (clk'event AND clk = '1') THEN
            q <= d;
        END IF;
    END PROCESS;
END ARCHITECTURE;
