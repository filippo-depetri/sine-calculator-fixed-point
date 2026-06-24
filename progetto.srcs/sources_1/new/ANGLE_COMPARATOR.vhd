library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ANGLE_COMPARATOR is
    port (
        ANGLE   : in std_logic_vector(9 downto 0);
        CLK     : in std_logic;
        RST     : in std_logic;
        RESULT  : out std_logic_vector(1 downto 0)
    );
end ANGLE_COMPARATOR;

architecture RTL of ANGLE_COMPARATOR is
    component ADDER_SUBTRACTOR_N
        generic(N : integer);
        port(
            X    : in  std_logic_vector(N-1 downto 0);
            Y    : in  std_logic_vector(N-1 downto 0);
            S    : in  std_logic;
            Z    : out std_logic_vector(N-1 downto 0);
            COUT : out std_logic
        );
    end component ADDER_SUBTRACTOR_N;

    signal Z_sig_90  : std_logic_vector(9 downto 0);
    signal Z_sig_180 : std_logic_vector(9 downto 0);
    signal Z_sig_270 : std_logic_vector(9 downto 0);
    signal quad_sig  : std_logic_vector(1 downto 0);
    
begin
    ADD_SUB_90 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0001011010",   -- 90 in binary
            Y    => ANGLE,
            S    => '1',
            Z    => Z_sig_90,
            COUT => open
        );
    ADD_SUB_180 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0010110100",   -- 180 in binary
            Y    => ANGLE,
            S    => '1',
            Z    => Z_sig_180,
            COUT => open
        );
    ADD_SUB_270 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0100001110",   -- 270 in binary
            Y    => ANGLE,
            S    => '1',
            Z    => Z_sig_270,
            COUT => open
        );
process(Z_sig_90, Z_sig_180, Z_sig_270)
    begin
        if Z_sig_90(9) = '0' then
            quad_sig <= "00";
        elsif Z_sig_180(9) = '0' then
            quad_sig <= "01";
        elsif Z_sig_270(9) = '0' then
            quad_sig <= "10";
        else
            quad_sig <= "11";
        end if;
    end process;
process(CLK, RST)
    begin
        if RST = '1' then
            RESULT <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            RESULT <= quad_sig;
        end if;
    end process;
end RTL;
