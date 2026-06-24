library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_PP_N_BIT is
    generic(
        N : integer
    );
    port (
        CLK     : in std_logic;
        RST     : in std_logic;
        D       : in std_logic_vector(N-1 downto 0);
        Q       : out std_logic_vector(N-1 downto 0)
    );
end REG_PP_N_BIT;

architecture RTL of REG_PP_N_BIT is
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            Q <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            Q <= D;
        end if;
    end process;

end RTL;
