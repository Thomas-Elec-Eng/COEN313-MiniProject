LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;
ENTITY Counter12bit_testbench IS
END ENTITY;

ARCHITECTURE rtl OF Counter12bit_testbench IS
    COMPONENT Counter12bit IS
        PORT (
            clk, reset, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
            p : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL clk, p : STD_LOGIC := '0';
    SIGNAL reset, en, success : STD_LOGIC := '1';
    SIGNAL n : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '1');
    SIGNAL q : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');

BEGIN
    reset <= '1', '0' AFTER 11 ns;
    clk <= NOT clk AFTER 5 ns; --acts as a clock
    dut : Counter12bit
    PORT MAP(
        clk => clk,
        reset => reset,
        en => en,
        n => n,
        q => q,
        p => p
    );
    stimulus :
    PROCESS BEGIN
        WAIT UNTIL reset = '0';
        for i in 0 to 4094 loop
            if q /= STD_LOGIC_VECTOR(to_unsigned(i, q'length)) then
                success <= '0';
            end if;
            if q = "111111111110" then
                if p /= '1' then
                    success <= '0';
                end if;
            end if;
            wait for 10 ns;
        end loop;
        wait;
    END PROCESS stimulus;

END ARCHITECTURE;
