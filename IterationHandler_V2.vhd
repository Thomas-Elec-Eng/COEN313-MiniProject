LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
ENTITY IterationHandler_v2 IS
    PORT (
        clk, goNext, reset : IN STD_LOGIC;
        timer : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
        final : OUT STD_LOGIC);
    -- Next tells the sequence handler to go to next
END ENTITY;

ARCHITECTURE arch OF IterationHandler_v2 IS

    TYPE Iteration_state IS (First, Second, Third, Fourth, Fifth, Sixth, Seventh, Eighth, Ninth, Tenth);
    SIGNAL state_reg, state_next : Iteration_state;
BEGIN
    -- Steps
    PROCESS (clk, reset, state_next)
    BEGIN
        if rising_edge(clk) then
            if reset = '1' then
                state_reg <= First;
            else
                state_reg <= state_next;
            end if;
        END IF;
    END PROCESS;
    -- transitions
    PROCESS (state_reg, goNext)
    BEGIN
        CASE state_reg IS
            WHEN First =>
                IF goNext = '1' THEN
                    state_next <= Second;
                else
                    state_next <= First;
                END IF;
            WHEN Second =>
                IF goNext = '1' THEN
                    state_next <= Third;
                else
                    state_next <= Second;
                END IF;
            WHEN Third =>
                IF goNext = '1' THEN
                    state_next <= Fourth;
                else
                    state_next <= Third;
                END IF;
            WHEN Fourth =>
                IF goNext = '1' THEN
                    state_next <= Fifth;
                else
                    state_next <= Fourth;
                END IF;
            WHEN Fifth =>
                IF goNext = '1' THEN
                    state_next <= Sixth;
                else
                    state_next <= Fifth;
                END IF;
            WHEN Sixth =>
                IF goNext = '1' THEN
                    state_next <= Seventh;
                else
                    state_next <= Sixth;
                END IF;
            WHEN Seventh =>
                IF goNext = '1' THEN
                    state_next <= Eighth;
                else
                    state_next <= Seventh;
                END IF;
            WHEN Eighth =>
                IF goNext = '1' THEN
                    state_next <= Ninth;
                else
                    state_next <= Eighth;
                END IF;
            WHEN Ninth =>
                IF goNext = '1' THEN
                    state_next <= Tenth;
                else
                    state_next <= Ninth;
                END IF;
            WHEN Tenth =>
                state_next <= Tenth;
        END CASE;
    END PROCESS;
    -- actions
    PROCESS (State_reg)
    BEGIN
        timer <= (OTHERS => '0');
        final <= '0';
        CASE state_reg IS
            WHEN First =>
                timer <= "011000000000"; -- 6s
            WHEN Second =>
                timer <= "010010000000"; -- 4.5s
            WHEN Third =>
                timer <= "001101100000"; -- 3.375s
            WHEN Fourth =>
                timer <= "001010001000"; -- 2.53125s
            WHEN Fifth =>
                timer <= "000111100110"; -- 1.8984375s
            WHEN Sixth =>
                timer <= "000101101100"; -- 1.421875s
            WHEN Seventh =>
                timer <= "000100010001"; -- 1.06640625s
            WHEN Eighth =>
                timer <= "000011001101"; -- 0.80078125s
            WHEN Ninth =>
                timer <= "000010011001"; -- 0.59765625s
            WHEN Tenth =>
                timer <= "000001110011"; -- 0.44921875s
                final <= '1';
        END CASE;
    END PROCESS;
END ARCHITECTURE;
