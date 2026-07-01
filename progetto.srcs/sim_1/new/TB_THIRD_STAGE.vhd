library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_THIRD_STAGE is
end TB_THIRD_STAGE;

architecture BEH of TB_THIRD_STAGE is
    component THIRD_STAGE
        port (
        SINE        : in std_logic_vector(9 downto 0);
        SIGN        : in std_logic;
        SINE_DEF    : out std_logic_vector(9 downto 0)
        );
    end component THIRD_STAGE;

    signal SINE        : std_logic_vector(9 downto 0);
    signal SIGN        : std_logic;
    signal SINE_DEF    : std_logic_vector(9 downto 0);

begin
    DUT : THIRD_STAGE
        port map(
            SINE => SINE,
            SIGN => SIGN,
            SINE_DEF => SINE_DEF
        );
    GEN: process
    begin
        wait for 10 ns; 

        SINE <= "0000000000"; SIGN <= '0';
        wait for 10 ns;
        assert SINE_DEF = "0000000000" report "Errore a 0 pos" severity error;

        SINE <= "0000000000"; SIGN <= '1';
        wait for 10 ns;
        assert SINE_DEF = "0000000000" report "Errore a 0 neg" severity error;

        SINE <= "0010001000"; SIGN <= '0';
        wait for 10 ns;
        assert SINE_DEF = "0010001000" report "Errore a 136 pos" severity error;

        SINE <= "0010001000"; SIGN <= '1';
        wait for 10 ns;
        assert SINE_DEF = "1101111000" report "Errore a 136 neg" severity error;

        SINE <= "0100000000"; SIGN <= '0';
        wait for 10 ns;
        assert SINE_DEF = "0100000000" report "Errore a 256 pos" severity error;

        SINE <= "0100000000"; SIGN <= '1';
        wait for 10 ns;
        assert SINE_DEF = "1100000000" report "Errore a 256 neg" severity error;

        wait;
        
    end process GEN;


end BEH;
