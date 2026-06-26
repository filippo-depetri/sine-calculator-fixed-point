library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity THIRD_STAGE is
    Port (
        SINE        : in std_logic_vector(9 downto 0);
        SIGN        : in std_logic;
        SINE_DEF    : out std_logic_vector(9 downto 0)
    );
end THIRD_STAGE;

architecture RTL of THIRD_STAGE is
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

    signal SINE_NEGATIVE : std_logic_vector(9 downto 0);

begin

    MODIFY_SIGN_NEGATIVE : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => "0000000000",
            Y    => SINE,
            S    => '1',
            Z    => SINE_NEGATIVE,
            COUT => open
        );
    with SIGN select
        SINE_DEF <= SINE_NEGATIVE when '1',
                    SINE          when others;
end RTL;
