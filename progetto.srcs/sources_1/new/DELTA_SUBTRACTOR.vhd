library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DELTA_SUBTRACTOR is
    Port (
        Y1      : in std_logic_vector(9 downto 0);
        Y2      : in std_logic_vector(9 downto 0);
        DELTA_Y   : out std_logic_vector(9 downto 0)
    );
end DELTA_SUBTRACTOR;

architecture RTL of DELTA_SUBTRACTOR is
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

begin
    SUBTRACTOR_inst : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => Y2,
            Y    => Y1,
            S    => '1',
            Z    => DELTA_Y,
            COUT => open
        );
end RTL;
