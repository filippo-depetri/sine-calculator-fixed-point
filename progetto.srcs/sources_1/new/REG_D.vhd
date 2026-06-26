library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_D is
    PORT(
        CLK : in  std_logic;
        RST : in  std_logic;
        D   : in  std_logic;
        Q   : out std_logic
    );
end REG_D;

architecture RTL of REG_D is
begin
    
    process(CLK, RST)
    begin
        if RST = '1' then
            Q <= '0';
        elsif (CLK'event and CLK = '1') then
            Q <= D;
        end if;
    end process;

end RTL;
