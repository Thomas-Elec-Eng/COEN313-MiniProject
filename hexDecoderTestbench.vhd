library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity hexDecoderTestbench is
end hexDecoderTestbench;

architecture arch of hexDecoderTestbench is
    component hextoFourDigit is
        port (
            i0 : in STD_LOGIC_VECTOR(7 downto 0);
            left, right, o0, o1, o2, o3 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    signal reset, success : std_logic := '1';
    signal i0 : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal left, right, o0, o1, o2, o3 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    reset <= '1', '0' after 5 ns;
    dut:hextoFourDigit
    port map(
        i0 => i0,
        left => left,
        right => right,
        o0 => o0,
        o1 => o1,
        o2 => o2,
        o3 => o3
    );
    stimulus:
    process begin
        wait until reset = '0';
        i0(7 downto 4) <= "0000";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0000") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0001";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0001") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0010";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0010") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0011";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0011") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0100";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0100") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0101";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0101") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0110";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0110") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0111";
        wait for 2 ns;
        if (left /= "0000") and (right /= "0111") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1000";
        wait for 2 ns;
        if (left /= "0000") and (right /= "1000") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1001";
        wait for 2 ns;
        if (left /= "0000") and (right /= "1001") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1010";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0000") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1011";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0001") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1100";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0010") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1101";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0011") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1110";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0100") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "1111";
        wait for 2 ns;
        if (left /= "0001") and (right /= "0101") then
            success <= '0';
        end if;
        i0(7 downto 4) <= "0000";
        i0(3 downto 0) <= "0000";
        wait for 2 ns;
        if (o0 /= "0000") and (o1 /= "0000") and (o2 /= "0000") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0001";
        wait for 2 ns;
        if (o0 /= "0000") and (o1 /= "0110") and (o2 /= "0010") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0010";
        wait for 2 ns;
        if (o0 /= "0001") and (o1 /= "0010") and (o2 /= "0101") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0011";
        wait for 2 ns;
        if (o0 /= "0001") and (o1 /= "1000") and (o2 /= "0111") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0100";
        wait for 2 ns;
        if (o0 /= "0010") and (o1 /= "0101") and (o2 /= "0000") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0101";
        wait for 2 ns;
        if (o0 /= "0011") and (o1 /= "0001") and (o2 /= "0010") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0110";
        wait for 2 ns;
        if (o0 /= "0011") and (o1 /= "0111") and (o2 /= "0101") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "0111";
        wait for 2 ns;
        if (o0 /= "0100") and (o1 /= "0011") and (o2 /= "0111") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1000";
        wait for 2 ns;
        if (o0 /= "0101") and (o1 /= "0000") and (o2 /= "0000") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1001";
        wait for 2 ns;
        if (o0 /= "0101") and (o1 /= "0110") and (o2 /= "0010") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1010";
        wait for 2 ns;
        if (o0 /= "0110") and (o1 /= "0010") and (o2 /= "0101") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1011";
        wait for 2 ns;
        if (o0 /= "0110") and (o1 /= "1000") and (o2 /= "0111") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1100";
        wait for 2 ns;
        if (o0 /= "0111") and (o1 /= "0101") and (o2 /= "0000") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1101";
        wait for 2 ns;
        if (o0 /= "1000") and (o1 /= "0001") and (o2 /= "0010") and (o3 /= "0101") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1110";
        wait for 2 ns;
        if (o0 /= "1000") and (o1 /= "0111") and (o2 /= "0101") and (o3 /= "0000") then
            success <= '0';
        end if;
        i0(3 downto 0) <= "1111";
        wait for 2 ns;
        if (o0 /= "1001") and (o1 /= "0011") and (o2 /= "0111") and (o3 /= "0101") then
            success <= '0';
        end if;
        wait;
    end process stimulus;
end arch;