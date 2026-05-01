-- This code used to be only about the part to the right of the decimal point
-- But instead of just making a new code to do the left side, I just added it to this

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY hextoFourDigit IS
    PORT (
        i0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        left, right, o0, o1, o2, o3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF hextoFourDigit IS
BEGIN
    WITH i0(7 DOWNTO 4) SELECT
    left <= "0000" WHEN "0000" | "0001" | "0010" | "0011" | "0100" | "0101" | "0110" | "0111" | "1000" | "1001",
            "0001" WHEN OTHERS;
    WITH i0(7 DOWNTO 4) SELECT
    right <= "0000" WHEN "0000" | "1010",
             "0001" WHEN "0001" | "1011",
             "0010" WHEN "0010" | "1100",
             "0011" WHEN "0011" | "1101",
             "0100" WHEN "0100" | "1110",
             "0101" WHEN "0101" | "1111",
             "0110" WHEN "0110",
             "0111" WHEN "0111",
             "1000" WHEN "1000",
             "1001" WHEN OTHERS;
    WITH i0(3 DOWNTO 0) SELECT --increments of 0.0625
    o0 <= "0000" WHEN "0000" | "0001",
          "0001" WHEN "0010" | "0011",
          "0010" WHEN "0100",
          "0011" WHEN "0101" | "0110",
          "0100" WHEN "0111",
          "0101" WHEN "1000" | "1001",
          "0110" WHEN "1010" | "1011",
          "0111" WHEN "1100",
          "1000" WHEN "1101" | "1110",
          "1001" WHEN OTHERS;
    WITH i0(2 DOWNTO 0) SELECT
    o1 <= "0000" WHEN "000",
          "0001" WHEN "101",
          "0010" WHEN "010",
          "0011" WHEN "111",
          "0101" WHEN "100",
          "0110" WHEN "001",
          "0111" WHEN "110",
          "1000" WHEN OTHERS;
    WITH i0(1 DOWNTO 0) SELECT
    o2 <= "0000" WHEN "00",
          "0010" WHEN "01",
          "0101" WHEN "10",
          "0111" WHEN OTHERS;
    WITH i0(0) SELECT
    o3 <= "0000" WHEN '0',
          "0101" WHEN OTHERS;
END ARCHITECTURE;
