library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity DisplayHandler_Testbench is
end entity;

architecture rtl of DisplayHandler_Testbench is
    component DisplayHandler_v2 is
        port (
            reset, start, clk, pulse, pulse2 : IN STD_LOGIC;
            sevenSegment : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            DP : OUT STD_LOGIC;
            whichsegment : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            iteration, play1, play2, play3, play4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    end component;
    component hextoFourDigit is
        port (
            i0 : in STD_LOGIC_VECTOR(7 downto 0);
            left, right, o0, o1, o2, o3 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    COMPONENT SevenSegmentDecoder IS
        PORT (
            i : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            abcdefg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT;
    signal start, goNext, prev, clk, DP, DP_check, pulse, pulse2 : STD_LOGIC := '0';
    signal sevenSegment, abcdefg: STD_LOGIC_VECTOR(6 DOWNTO 0) := (others => '0');
    signal reset, success : STD_LOGIC := '1';
    signal whichsegment: STD_LOGIC_VECTOR(7 Downto 0) := (others => '0');
    signal i0, iteration, play1, play2, play3, play4 : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
    signal left, right, o0, o1, o2, o3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
    signal i1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1110";
    signal debug : STD_LOGIC_VECTOR(2 DOWNTO 0);
begin
    clk <= not clk after 5 ns;
    dut:DisplayHandler_v2
    port map(
        reset => reset,
        start => start,
        clk => clk,
        sevenSegment => sevenSegment,
        DP => DP,
        whichsegment => whichsegment,
        iteration => iteration,
        play1 => play1,
        play2 => play2,
        play3 => play3,
        play4 => play4,
        pulse => pulse,
        pulse2 => pulse2
    );
    hextoFourDigit_inst:hextoFourDigit
    port map(
        i0 => i0,
        left => left,
        right => right,
        o0 => o0,
        o1 => o1,
        o2 => o2,
        o3 => o3
    );
    SevenSegmentDecoder_inst: SevenSegmentDecoder
    port map(
        i => i1,
        abcdefg => abcdefg
    );
    stimulus:
    process begin
        wait for 6 ns;
        reset <= '0';
        wait for 1 ns;
        for j in 0 to 255 loop
            iteration <= STD_LOGIC_VECTOR(to_unsigned(j, iteration'length));
            play1 <= STD_LOGIC_VECTOR(to_unsigned(j, play1'length));
            play2 <= STD_LOGIC_VECTOR(to_unsigned(j, play2'length));
            play3 <= STD_LOGIC_VECTOR(to_unsigned(j, play3'length));
            play4 <= STD_LOGIC_VECTOR(to_unsigned(j, play4'length));
            i0 <= STD_LOGIC_VECTOR(to_unsigned(j, iteration'length));
            for k in 0 to 7 loop
                for i in 0 to 1 loop
                    case whichsegment is
                        when "11111110" =>
                            case i is
                                when 0 =>
                                    i1 <= "1110";
                                when others =>
                                    i1 <= "1101";
                            end case;
                        when "11111101" =>
                            if i = 0 then
                                i1 <= "1111";
                            end if;
                        when "11111011" =>
                            i1 <= left;
                        when "11110111" =>
                            i1 <= right;
                        when "11101111" =>
                            i1 <= o0;
                        when "11011111" =>
                            i1 <= o1;
                        when "10111111" =>
                            i1 <= o2;
                        when "01111111" =>
                            i1 <= o3;
                        when others =>
                            i1 <= "1111";
                    end case;
                    wait for 1 fs;
                    if sevenSegment /= abcdefg then
                        success <= '0';
                    end if;
                    wait for 1 ps;
                    goNext <= '1';
                    wait for 10 ns;
                    goNext <= '0';
                    wait for 10 ns;
                end loop;
                wait for 10 ns;
                pulse <= '1';
                wait for 10 ns;
                pulse <= '0';
            end loop;
--            wait for 10 ns;
        end loop;
        wait;
    end process stimulus;

end architecture;