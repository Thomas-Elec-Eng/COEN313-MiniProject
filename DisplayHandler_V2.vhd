LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY DisplayHandler_v2 IS
    PORT (
        reset, start, clk, pulse, pulse2 : IN STD_LOGIC;
        sevenSegment : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        DP : OUT STD_LOGIC;
        whichsegment : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        iteration, play1, play2, play3, play4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF DisplayHandler_v2 IS
    COMPONENT counter4bit
        PORT (
            reset, clk, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            p : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT hextoFourDigit IS
        PORT (
            i0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            left, right, o0, o1, o2, o3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT SevenSegmentDecoder IS
        PORT (
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            abcdefg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL q, gotodecoder, x1_de, x6_de : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL it_left, it_right, it_digit0, it_digit1, it_digit2, it_digit3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL p1_left, p1_right, p1_0, p1_1, p1_2, p1_3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL p2_left, p2_right, p2_0, p2_1, p2_2, p2_3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL p3_left, p3_right, p3_0, p3_1, p3_2, p3_3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL p4_left, p4_right, p4_0, p4_1, p4_2, p4_3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
    SIGNAL p, DP_type, dont, pulse_combined, reset_disconnect : STD_LOGIC := '0';
    SIGNAL x1_ex, x6_ex : BOOLEAN;
    Signal debug : std_logic_vector(2 downto 0);
    TYPE display_state IS (Timer, Running);
    SIGNAL state_reg, state_next : display_state;
BEGIN
    pulse_combined <= pulse OR pulse2; -- Get the frequency downto 512Hz
    cycle : counter4bit
    PORT MAP(
        reset => reset_disconnect, --The reset doesn't really matter
        clk => clk, --clk
        en => pulse_combined, -- Get the frequency downto 512Hz
        n => "1000", --Rollover at 8
        q => q, --used to decide which seven segment display to update
        p => p --pulse, unused
    );
    it : hextoFourDigit
    PORT MAP(
        i0 => iteration,
        left => it_left,
        right => it_right,
        o0 => it_digit0,
        o1 => it_digit1,
        o2 => it_digit2,
        o3 => it_digit3
    );
    p1 : hextoFourDigit
    PORT MAP(
        i0 => play1,
        left => p1_left,
        right => p1_right,
        o0 => p1_0,
        o1 => p1_1,
        o2 => p1_2,
        o3 => p1_3
    );
    p2 : hextoFourDigit
    PORT MAP(
        i0 => play2,
        left => p2_left,
        right => p2_right,
        o0 => p2_0,
        o1 => p2_1,
        o2 => p2_2,
        o3 => p2_3
    );
    p3 : hextoFourDigit
    PORT MAP(
        i0 => play3,
        left => p3_left,
        right => p3_right,
        o0 => p3_0,
        o1 => p3_1,
        o2 => p3_2,
        o3 => p3_3
    );
    p4 : hextoFourDigit
    PORT MAP(
        i0 => play4,
        left => p4_left,
        right => p4_right,
        o0 => p4_0,
        o1 => p4_1,
        o2 => p4_2,
        o3 => p4_3
    );
    decoder : SevenSegmentDecoder
    PORT MAP(
        i => gotodecoder,
        abcdefg => sevenSegment
    );
    -- steps
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            state_reg <= Timer;
        ELSIF rising_edge(clk) THEN
            state_reg <= state_next;
        END IF;
    END PROCESS;
    -- transitions
    PROCESS (state_reg, start)
    BEGIN
        CASE state_reg IS
            WHEN Timer =>
                    IF start = '1' THEN
                        state_next <= Running;
                    else
                        state_next <= Timer;
                    end if;
            WHEN running =>
                state_next <= Running;
        END CASE;
    END PROCESS;
    -- actions
    PROCESS (state_reg)
    BEGIN
        x1_ex <= FALSE;
        x6_ex <= FALSE;
        DP_type <= '1';
        debug <= "000";
        CASE state_reg IS
            WHEN timer =>
                x1_ex <= TRUE;
                debug <= "001";
            WHEN Running =>
                x6_ex <= TRUE;
                DP_type <= '0';
                debug <= "110";
        END CASE;
    END PROCESS;
    gotodecoder <= x1_de WHEN x1_ex ELSE (OTHERS => 'Z');
    gotodecoder <= x6_de WHEN x6_ex ELSE (OTHERS => 'Z');
    -- scrolling through the 8 seven segment display
    -- Iteration time
    WITH q SELECT
        x1_de <= "1110" WHEN "0000", --t
        it_left WHEN "0010", -- digit left
        it_right WHEN "0011", -- digit right
        it_digit0 WHEN "0100", -- digit 1
        it_digit1 WHEN "0101", -- digit 2
        it_digit2 WHEN "0110", -- digit 3
        it_digit3 WHEN "0111", -- digit 4
        "1111" WHEN OTHERS; -- <blank>
    -- Game running all player showed
    WITH q SELECT
        x6_de <= play1(7 DOWNTO 4) WHEN "0000", -- Player 1
        p1_0 WHEN "0001", -- Player 1
        play2(7 DOWNTO 4) WHEN "0010", -- Player 2
        p2_0 WHEN "0011", -- Player 2
        play3(7 DOWNTO 4) WHEN "0100", -- Player 3
        p3_0 WHEN "0101", -- Player 3
        play4(7 DOWNTO 4) WHEN "0110", -- Player 4
        p4_0 WHEN "0111", -- Player 4
        "1111" WHEN OTHERS; -- <blank>
    --Decimal point selector
    WITH q SELECT
        DP <= (NOT DP_type) WHEN "0011",
        DP_type WHEN "0000",
        DP_type WHEN "0010",
        DP_type WHEN "0100",
        DP_type WHEN "0110",
        '1' WHEN OTHERS;
    -- Segment selector
    WITH q SELECT
        whichsegment <= "11111110" WHEN "0000",
        "11111101" WHEN "0001",
        "11111011" WHEN "0010",
        "11110111" WHEN "0011",
        "11101111" WHEN "0100",
        "11011111" WHEN "0101",
        "10111111" WHEN "0110",
        "01111111" WHEN "0111",
        "11111111" WHEN OTHERS;
END ARCHITECTURE;
