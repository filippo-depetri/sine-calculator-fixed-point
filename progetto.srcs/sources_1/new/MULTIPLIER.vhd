library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MULTIPLIER is
    Port (
        DELTA_Y : in std_logic_vector(9 downto 0);
        DELTA_X : in std_logic_vector(2 downto 0);
        PP_0    : out std_logic_vector(11 downto 0);
        PP_1    : out std_logic_vector(11 downto 0);
        PP_2    : out std_logic_vector(11 downto 0)
    );
end MULTIPLIER;

architecture RTL of MULTIPLIER is

begin

    PP_0 <= "00" & (DELTA_Y and (9 downto 0 => DELTA_X(0))); 

    PP_1 <= '0' & (DELTA_Y and (10 downto 1 => DELTA_X(1))) & '0'; 

    PP_2 <= (DELTA_Y and (11 downto 2 => DELTA_X(2))) & "00";

end RTL;
