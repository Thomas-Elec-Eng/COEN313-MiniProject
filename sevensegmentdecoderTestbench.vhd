LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
ENTITY sevensegmentdecodertestbench IS
END sevensegmentdecodertestbench;

ARCHITECTURE arch OF sevensegmentdecoderTestbench IS
    COMPONENT sevensegmentdecoder IS
        PORT (
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            abcdefg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL i : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL abcdefg : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL reset, success : STD_LOGIC := '1';
BEGIN
    reset <= '1', '0' AFTER 5 ns;
    dut : SevenSegmentDecoder
    PORT MAP(
        i => i,
        abcdefg => abcdefg
    );
    stimulus :
    PROCESS BEGIN
        WAIT UNTIL reset = '0';
        i <= "0000";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0000001") THEN
            success <= '0';
        END IF;
        i <= "0001";
        WAIT FOR 2 ns;
        IF (abcdefg /= "1001111") THEN
            success <= '0';
        END IF;
        i <= "0010";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0010010") THEN
            success <= '0';
        END IF;
        i <= "0011";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0000110") THEN
            success <= '0';
        END IF;
        i <= "0100";
        WAIT FOR 2 ns;
        IF (abcdefg /= "1001100") THEN
            success <= '0';
        END IF;
        i <= "0101";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0100100") THEN
            success <= '0';
        END IF;
        i <= "0110";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0100000") THEN
            success <= '0';
        END IF;
        i <= "0111";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0001111") THEN
            success <= '0';
        END IF;
        i <= "1000";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0000000") THEN
            success <= '0';
        END IF;
        i <= "1001";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0000100") THEN
            success <= '0';
        END IF;
        i <= "1010";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0000010") THEN
            success <= '0';
        END IF;
        i <= "1011";
        WAIT FOR 2 ns;
        IF (abcdefg /= "1100000") THEN
            success <= '0';
        END IF;
        i <= "1100";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0110001") THEN
            success <= '0';
        END IF;
        i <= "1101";
        WAIT FOR 2 ns;
        IF (abcdefg /= "0011000") THEN
            success <= '0';
        END IF;
        i <= "1110";
        WAIT FOR 2 ns;
        IF (abcdefg /= "1110000") THEN
            success <= '0';
        END IF;
        i <= "1111";
        WAIT FOR 2 ns;
        IF (abcdefg /= "1111111") THEN
            success <= '0';
        END IF;
        WAIT;
    END PROCESS stimulus;

END arch;
