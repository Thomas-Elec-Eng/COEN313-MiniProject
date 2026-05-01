LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY FlashLed IS
    PORT (
        clk, reset, pulse : IN STD_LOGIC;
        LED : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE arch OF FlashLed IS
    COMPONENT DFFR IS
        PORT (
            clk : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            d : IN STD_LOGIC;
            q : OUT STD_LOGIC
        );
    END COMPONENT;
    COMPONENT counter4bit IS
        PORT (
            reset, clk, en : IN STD_LOGIC;
            n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            p : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL p, flip, flip2 : STD_LOGIC;
    SIGNAL n, q : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    winner : DFFR
    PORT MAP(
        clk => p,
        reset => reset,
        d => flip,
        q => flip2
    );
    flash : counter4bit
    PORT MAP(
        reset => reset,
        clk => clk,
        en => pulse,
        n => n,
        q => q,
        p => p
    );
    flip <= NOT flip2;
    LED <= flip2;
    n <= "1111";
END ARCHITECTURE;
