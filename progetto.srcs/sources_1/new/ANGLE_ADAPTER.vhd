library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ANGLE_ADAPTER is
    port (
        ANGLE   : in std_logic_vector(9 downto 0);
        QUADRANT: in std_logic_vector(1 downto 0);
        RESULT  : out std_logic_vector(6 downto 0);
        SIGN    : out std_logic
    );
end ANGLE_ADAPTER;

architecture RTL of ANGLE_ADAPTER is
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

    signal Z_sig_Q2 : std_logic_vector(9 downto 0);
    signal Z_sig_Q3 : std_logic_vector(9 downto 0);
    signal Z_sig_Q4 : std_logic_vector(9 downto 0);
    
begin
    SUB_Q2 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0010110100",   -- 180 in binary
            Y    => ANGLE,
            S    => '1',
            Z    => Z_sig_Q2,
            COUT => open
        );
    SUB_Q3 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => ANGLE,
            Y    => "0010110100",   -- 180 in binary
            S    => '1',
            Z    => Z_sig_Q3,
            COUT => open
        );
    SUB_Q4 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0101101000",   -- 360 in binary
            Y    => ANGLE,
            S    => '1',
            Z    => Z_sig_Q4,
            COUT => open
        );
    RESULT <= ANGLE(6 downto 0)     when QUADRANT = "00" else
              Z_sig_Q2(6 downto 0)  when QUADRANT = "01" else
              Z_sig_Q3(6 downto 0) when QUADRANT = "10" else
              Z_sig_Q4(6 downto 0);
    SIGN <= '0' when QUADRANT = "00" else
            '0' when QUADRANT = "01" else
            '1';
end RTL;
