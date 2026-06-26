library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity INTERPOLATOR is
    Port (
        Y1    : in std_logic_vector(9 downto 0);
        PP_0  : in std_logic_vector(11 downto 0);
        PP_1  : in std_logic_vector(11 downto 0);
        PP_2  : in std_logic_vector(11 downto 0);
        RESULT: out std_logic_vector(9 downto 0)
    );
end INTERPOLATOR;

architecture RTL of INTERPOLATOR is
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

    signal Z_sum_1_inst     : std_logic_vector(11 downto 0);
    signal COUT_sum_1_inst  : std_logic;
    signal PP_2_inst        : std_logic_vector(12 downto 0);
    signal Z_sum_1          : std_logic_vector(12 downto 0);
    signal Z_sum_2          : std_logic_vector(12 downto 0);
    signal Z_shifted        : std_logic_vector(9 downto 0);

begin
    ADDER_inst_PP0_to_PP1 : ADDER_SUBTRACTOR_N
        generic map(N => 12)
        port map(
            X    => PP_0,
            Y    => PP_1,
            S    => '0',
            Z    => Z_sum_1_inst,
            COUT => COUT_sum_1_inst
        );

    Z_sum_1 <= COUT_sum_1_inst & Z_sum_1_inst;
    PP_2_inst <= '0' & PP_2;

    ADDER_inst_PP1_to_PP2 : ADDER_SUBTRACTOR_N
        generic map(N => 13)
        port map(
            X    => Z_sum_1,
            Y    => PP_2_inst,
            S    => '0',
            Z    => Z_sum_2,
            COUT => open
        );
    
    Z_shifted <= Z_sum_2(12 downto 3);

    ADDER_inst_mult_with_Y1 : ADDER_SUBTRACTOR_N
        generic map(N => 10)
        port map(
            X    => Z_shifted,
            Y    => Y1,
            S    => '0',
            Z    => RESULT,
            COUT => open
        );
end RTL;
