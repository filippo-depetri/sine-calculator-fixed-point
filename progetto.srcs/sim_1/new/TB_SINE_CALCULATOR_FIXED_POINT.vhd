library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_SINE_CALCULATOR_FIXED_POINT is
end TB_SINE_CALCULATOR_FIXED_POINT;

architecture BEH of TB_SINE_CALCULATOR_FIXED_POINT is
    component SINE_FUNCTION_FIXED_POINT
        port(
            ANGLE   : in std_logic_vector(9 downto 0);
            SINE    : out std_logic_vector(9 downto 0);
            CLK     : in std_logic;
            RST     : in std_logic
        );
    end component SINE_FUNCTION_FIXED_POINT;

    constant CLK_PERIOD : time := 20 ns;
    constant RST_PERIOD : time := 40 ns;
    constant REG_PIPE: integer := 4;

    signal ANGLE   : std_logic_vector(9 downto 0);
    signal SINE    : std_logic_vector(9 downto 0);
    signal CLK     : std_logic := '0';
    signal RST     : std_logic := '0';

begin
    DUT : SINE_FUNCTION_FIXED_POINT
        port map(
            ANGLE   => ANGLE,
            SINE    => SINE,
            CLK     => CLK,
            RST     => RST
        );

    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_PERIOD/2;
        CLK <= '1';
        wait for CLK_PERIOD/2;
    end process;

    TEST: process
    begin
        wait for CLK_PERIOD * REG_PIPE;

        RST <= '1';
        wait for RST_PERIOD;
        RST <= '0';

        ANGLE <= "0000000000"; -- 0
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000000000" report "Errore a 0" severity error; -- 0

        ANGLE <= "0000000001"; -- 1
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000000100" report "Errore a 1" severity error; -- 4

        ANGLE <= "0000000100"; -- 4
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000010010" report "Errore a 4" severity error; -- 18

        ANGLE <= "0000001000"; -- 8
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000100100" report "Errore a 8" severity error; -- 36

        ANGLE <= "0000101101"; -- 45
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0010110100" report "Errore a 45" severity error; -- 180

        ANGLE <= "0001011000"; -- 88
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0100000000" report "Errore a 88" severity error; -- 256

        ANGLE <= "0001011001"; -- 89
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0100000000" report "Errore a 89" severity error; -- 256

        ANGLE <= "0001011010"; -- 90
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0100000000" report "Errore a 90" severity error; -- 256

        ANGLE <= "0001011011"; -- 91
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0100000000" report "Errore a 91" severity error; -- 256

        ANGLE <= "0001011100"; -- 92
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0100000000" report "Errore a 92" severity error; -- 256

        ANGLE <= "0010000111"; -- 135
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0010110100" report "Errore a 135" severity error; -- 180

        ANGLE <= "0010110000"; -- 176
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000010010" report "Errore a 176" severity error; -- 18

        ANGLE <= "0010110011"; -- 179
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000000100" report "Errore a 179" severity error; -- 4

        ANGLE <= "0010110100"; -- 180
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "0000000000" report "Errore a 180" severity error; -- 0

        ANGLE <= "0010110101"; -- 181
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1111111100" report "Errore a 181" severity error; -- -4

        ANGLE <= "0010111000"; -- 184
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1111101110" report "Errore a 184" severity error; -- -18

        ANGLE <= "0011100001"; -- 225
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1101001100" report "Errore a 225" severity error; -- -180

        ANGLE <= "0100001100"; -- 268
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1100000000" report "Errore a 268" severity error; -- -256

        ANGLE <= "0100001101"; -- 269
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1100000000" report "Errore a 269" severity error; -- -256

        ANGLE <= "0100001110"; -- 270
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1100000000" report "Errore a 270" severity error; -- -256

        ANGLE <= "0100001111"; -- 271
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1100000000" report "Errore a 271" severity error; -- -256

        ANGLE <= "0100111011"; -- 315
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1101001100" report "Errore a 315" severity error; -- -180

        ANGLE <= "0101100111"; -- 359
        wait for CLK_PERIOD * REG_PIPE;
        assert SINE = "1111111100" report "Errore a 359" severity error; -- -4

        wait;

    end process;

end BEH;