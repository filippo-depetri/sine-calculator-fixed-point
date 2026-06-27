library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_N is
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
end RCA_N;

architecture STRUCTURAL of RCA_N is
   component FA
    port(
        X    : in  std_logic;
        Y    : in  std_logic;
        CIN  : in  std_logic;
        S    : out std_logic;
        COUT : out std_logic
    );
   end component FA;
   signal C : std_logic_vector(N downto 0);
begin
	GEN: for i in 0 to N-1 generate
		FA_i: FA 
			port map(
				X       => A(i),
				Y       => B(i),
				CIN     => C(i),
				S       => S(i),
				COUT    => C(i+1)
			);
		end generate;
	C(0) <= CIN;
	COUT <= C(N);
end STRUCTURAL;
