LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY TestingPulse IS
    PORT (
        clk, reset : IN STD_LOGIC;
        pulse, pulse2 : OUT STD_LOGIC);
    -- Every 0.00390625 seconds, a 10ns pulse will be sent. This will be used by other counters.
END ENTITY;

ARCHITECTURE arch OF TestingPulse IS
    COMPONENT ClockPulse19bit
    PORT (
        clk, reset : IN STD_LOGIC;
        n, n2 : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
        p, p2 : OUT STD_LOGIC);
END COMPONENT;
SIGNAL number, second_number : STD_LOGIC_VECTOR(18 DOWNTO 0);
BEGIN
    number <= "0000000000000010000"; -- used for testing
    second_number <= "0000000000000001000"; -- Used for testing
    unit1 : ClockPulse19bit PORT MAP(clk => clk, reset => reset, n => number, n2 => second_number, p => pulse, p2 => pulse2);
END ARCHITECTURE;
