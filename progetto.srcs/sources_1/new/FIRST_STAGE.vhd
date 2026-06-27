library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FIRST_STAGE is
    Port (
        ANGLE : in std_logic_vector(8 downto 0);
        ANGLE_ADAPTED : out std_logic_vector(6 downto 0);
        SIGN_CALCULATED : out std_logic
    );
end FIRST_STAGE;

architecture STRUCTURAL of FIRST_STAGE is
    component ANGLE_ADAPTER
        port(
            ANGLE    : in  std_logic_vector(9 downto 0);
            QUADRANT : in  std_logic_vector(1 downto 0);
            RESULT   : out std_logic_vector(6 downto 0);
            SIGN     : out std_logic
        );
    end component ANGLE_ADAPTER;
    component ANGLE_COMPARATOR
        port(
            ANGLE  : in  std_logic_vector(9 downto 0);
            RESULT : out std_logic_vector(1 downto 0)
        );
    end component ANGLE_COMPARATOR;

    signal ANGLE_EXTENDED : std_logic_vector(9 downto 0);
    signal quadrant : std_logic_vector(1 downto 0);
begin
    angle_extended <= '0' & ANGLE;
    ANGLE_COMPARATOR_inst : ANGLE_COMPARATOR
        port map(
            ANGLE  => ANGLE_EXTENDED,
            RESULT => quadrant
        );

    ANGLE_ADAPTER_inst : ANGLE_ADAPTER
        port map(
            ANGLE    => ANGLE_EXTENDED,
            QUADRANT => quadrant,
            RESULT   => ANGLE_ADAPTED,
            SIGN     => SIGN_CALCULATED
        );
end STRUCTURAL;
