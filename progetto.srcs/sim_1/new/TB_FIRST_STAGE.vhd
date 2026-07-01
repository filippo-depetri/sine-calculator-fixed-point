library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_FIRST_STAGE is
end TB_FIRST_STAGE;

architecture BEH of TB_FIRST_STAGE is

    component FIRST_STAGE
        port(
            ANGLE           : in  std_logic_vector(9 downto 0);
            ANGLE_ADAPTED   : out std_logic_vector(6 downto 0);
            SIGN_CALCULATED : out std_logic
        );
    end component FIRST_STAGE;

    signal ANGLE           : std_logic_vector(9 downto 0);
    signal ANGLE_ADAPTED   : std_logic_vector(6 downto 0);
    signal SIGN_CALCULATED : std_logic;

begin
    DUT: FIRST_STAGE
        port map(
            ANGLE           => ANGLE,
            ANGLE_ADAPTED   => ANGLE_ADAPTED,
            SIGN_CALCULATED => SIGN_CALCULATED
        );
    GEN: process
    begin

        wait for 10 ns;

        ANGLE <= "0000000000"; -- 0
        wait for 10 ns; 
        
        ANGLE <= "0000101101"; -- 45
        wait for 10 ns; 
        
        ANGLE <= "0001011010"; -- 90
        wait for 10 ns; 
        
        ANGLE <= "0010000111"; -- 135
        wait for 10 ns; 
        
        ANGLE <= "0010110100"; -- 180
        wait for 10 ns; 
        
        ANGLE <= "0011100001"; -- 225
        wait for 10 ns; 
        
        ANGLE <= "0100001110"; -- 270
        wait for 10 ns; 
        
        ANGLE <= "0100111011"; -- 315
        wait for 10 ns; 
        
        ANGLE <= "0101100111"; -- 359
        wait for 10 ns;

        wait; 
        
    end process GEN;

end BEH;
