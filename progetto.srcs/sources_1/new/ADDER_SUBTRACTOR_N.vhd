library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADDER_SUBTRACTOR_N is
    generic(
        N : integer
    );
    port (
        X       : in std_logic_vector(N-1 downto 0);
        Y       : in std_logic_vector(N-1 downto 0);
        S       : in std_logic;
        Z       : out std_logic_vector(N-1 downto 0);
        COUT    : out std_logic
    );
end ADDER_SUBTRACTOR_N;

architecture RTL of ADDER_SUBTRACTOR_N is
    component RCA_N
     generic(
          N : integer
     );
     port (
          A       : in std_logic_vector(N-1 downto 0);
          B       : in std_logic_vector(N-1 downto 0);
          CIN     : in std_logic;
          S       : out std_logic_vector(N-1 downto 0);
          COUT    : out std_logic
     );
    end component RCA_N;
    signal B_int : std_logic_vector(N-1 downto 0);
begin
    B_int <= Y xor (N-1 downto 0 => S);
    RCA_N_i: RCA_N
        generic map(
            N => N
        )
        port map(
            A       => X,
            B       => B_int,
            CIN     => S,
            S       => Z,
            COUT    => COUT
        );
end RTL;
