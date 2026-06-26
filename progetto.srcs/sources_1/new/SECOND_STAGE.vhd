library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SECOND_STAGE is
    Port (
        ANGLE   : in std_logic_vector(6 downto 0);    
        SINE    : out std_logic_vector(9 downto 0)
    );
end SECOND_STAGE;

architecture STRUCTURAL of SECOND_STAGE is
    component LUT_TABLE
        Port (
            ANGLE   : in std_logic_vector(6 downto 0);
            Y1      : out std_logic_vector(9 downto 0);
            Y2      : out std_logic_vector(9 downto 0);
            DELTA_X   : out std_logic_vector(2 downto 0)
        );
    end component LUT_TABLE;
    component DELTA_SUBTRACTOR
        Port (
            Y1      : in std_logic_vector(9 downto 0);
            Y2      : in std_logic_vector(9 downto 0);
            DELTA_Y   : out std_logic_vector(9 downto 0)
        );
    end component DELTA_SUBTRACTOR;
    component MULTIPLIER
        Port (
            DELTA_Y : in std_logic_vector(9 downto 0);
            DELTA_X : in std_logic_vector(2 downto 0);
            PP_0    : out std_logic_vector(11 downto 0);
            PP_1    : out std_logic_vector(11 downto 0);
            PP_2    : out std_logic_vector(11 downto 0)
        );
    end component MULTIPLIER;
    component INTERPOLATOR
        Port (
            Y1    : in std_logic_vector(9 downto 0);
            PP_0  : in std_logic_vector(11 downto 0);
            PP_1  : in std_logic_vector(11 downto 0);
            PP_2  : in std_logic_vector(11 downto 0);
            RESULT  : out std_logic_vector(9 downto 0)
        );
    end component INTERPOLATOR;

    signal Y1_sign : std_logic_vector(9 downto 0);
    signal Y2_sign : std_logic_vector(9 downto 0);
    signal DELTA_X_sign : std_logic_vector(2 downto 0);
    signal DELTA_Y_sign : std_logic_vector(9 downto 0);
    signal PP_0_sign : std_logic_vector(11 downto 0);
    signal PP_1_sign : std_logic_vector(11 downto 0);
    signal PP_2_sign : std_logic_vector(11 downto 0);

begin
    LUT_TABLE_inst : LUT_TABLE
        port map(
            ANGLE => ANGLE,
            Y1 => Y1_sign,
            Y2 => Y2_sign,
            DELTA_X => DELTA_X_sign
        );

    DELTA_SUBTRACTOR_inst : DELTA_SUBTRACTOR
        port map(
            Y1 => Y1_sign,
            Y2 => Y2_sign,
            DELTA_Y => DELTA_Y_sign
        );

    MULTIPLIER_inst : MULTIPLIER
        port map(
            DELTA_Y => DELTA_Y_sign,
            DELTA_X => DELTA_X_sign,
            PP_0 => PP_0_sign,
            PP_1 => PP_1_sign,
            PP_2 => PP_2_sign
        );

    INTERPOLATOR_inst : INTERPOLATOR
        port map(
            Y1 => Y1_sign,
            PP_0 => PP_0_sign,
            PP_1 => PP_1_sign,
            PP_2 => PP_2_sign,
            RESULT => SINE
        );
end STRUCTURAL;
