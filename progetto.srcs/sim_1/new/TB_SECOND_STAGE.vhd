library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_SECOND_STAGE is
end TB_SECOND_STAGE;

architecture BEH of TB_SECOND_STAGE is

    component SECOND_STAGE
        port(
            ANGLE           : in  std_logic_vector(6 downto 0);
            SINE            : out std_logic_vector(9 downto 0)
        );
    end component SECOND_STAGE;

    signal ANGLE           : std_logic_vector(6 downto 0);
    signal SINE            : std_logic_vector(9 downto 0);

begin
    DUT : SECOND_STAGE
        port map(
            ANGLE => ANGLE,
            SINE => SINE
        );
    GEN: process
    begin

        wait for 10 ns;

        ANGLE <= "0000000"; -- 0
        wait for 20 ns;
        assert SINE = "0000000000" report "Errore a 0 gradi" severity error; -- 0
        
        ANGLE <= "0000100"; -- 4
        wait for 20 ns; 
        assert SINE = "0000010010" report "Errore a 4 gradi" severity error; -- 18
        
        ANGLE <= "0001000"; -- 8
        wait for 20 ns; 
        assert SINE = "0000100100" report "Errore a 8 gradi" severity error; -- 36
        
        ANGLE <= "0101101"; -- 45
        wait for 20 ns; 
        assert SINE = "0010110100" report "Errore a 45 gradi" severity error; -- 180
        
        ANGLE <= "1011000"; -- 88
        wait for 20 ns; 
        assert SINE = "0100000000" report "Errore a 88 gradi" severity error; -- 256
        
        ANGLE <= "1011001"; -- 89
        wait for 20 ns; 
        assert SINE = "0100000000" report "Errore a 89 gradi" severity error; -- 256
        
        ANGLE <= "1011010"; -- 90
        wait for 20 ns;
        assert SINE = "0100000000" report "Errore a 90 gradi" severity error; -- 256
        
    end process GEN;


end BEH;
