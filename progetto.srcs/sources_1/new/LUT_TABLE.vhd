library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LUT_TABLE is
    Port (
        ANGLE : in std_logic_vector(6 downto 0);
        Y1 : out std_logic_vector(9 downto 0);
        Y2 : out std_logic_vector(9 downto 0);
        DELTA_X : out std_logic_vector(2 downto 0)
    );
end LUT_TABLE;

architecture RTL of LUT_TABLE is

    signal index      : std_logic_vector(3 downto 0);
    signal Y1_no_edge : std_logic_vector(9 downto 0);
    signal Y2_no_edge : std_logic_vector(9 downto 0);

    signal val_sin_0  : std_logic_vector(9 downto 0);
    signal val_sin_8  : std_logic_vector(9 downto 0);
    signal val_sin_16 : std_logic_vector(9 downto 0);
    signal val_sin_24 : std_logic_vector(9 downto 0);
    signal val_sin_32 : std_logic_vector(9 downto 0);
    signal val_sin_40 : std_logic_vector(9 downto 0);
    signal val_sin_48 : std_logic_vector(9 downto 0);
    signal val_sin_56 : std_logic_vector(9 downto 0);
    signal val_sin_64 : std_logic_vector(9 downto 0);
    signal val_sin_72 : std_logic_vector(9 downto 0);
    signal val_sin_80 : std_logic_vector(9 downto 0);
    signal val_sin_88 : std_logic_vector(9 downto 0);
    signal val_sin_89 : std_logic_vector(9 downto 0);
    signal val_sin_90 : std_logic_vector(9 downto 0);
    
begin
    index <= ANGLE(6 downto 3);

    val_sin_0  <= "0000000000"; -- sin(0)  = 0
    val_sin_8  <= "0000100100"; -- sin(8)  = 36
    val_sin_16 <= "0001000111"; -- sin(16) = 71
    val_sin_24 <= "0001101000"; -- sin(24) = 104
    val_sin_32 <= "0010001000"; -- sin(32) = 136
    val_sin_40 <= "0010100101"; -- sin(40) = 165
    val_sin_48 <= "0010111110"; -- sin(48) = 190
    val_sin_56 <= "0011010100"; -- sin(56) = 212
    val_sin_64 <= "0011100110"; -- sin(64) = 230
    val_sin_72 <= "0011110011"; -- sin(72) = 243
    val_sin_80 <= "0011111100"; -- sin(80) = 252
    val_sin_88 <= "0100000000"; -- sin(88) = 256
    val_sin_89 <= "0100000000"; -- sin(89) = 256
    val_sin_90 <= "0100000000"; -- sin(90) = 256

    with index select
        Y1_no_edge <= val_sin_0  when "0000",
              val_sin_8  when "0001",
              val_sin_16 when "0010",
              val_sin_24 when "0011",
              val_sin_32 when "0100",
              val_sin_40 when "0101",
              val_sin_48 when "0110",
              val_sin_56 when "0111",
              val_sin_64 when "1000",
              val_sin_72 when "1001",
              val_sin_80 when "1010",
              val_sin_88 when "1011",
              "0000000000" when others;

    with index select
        Y2_no_edge <= val_sin_8  when "0000",
              val_sin_16 when "0001",
              val_sin_24 when "0010",
              val_sin_32 when "0011",
              val_sin_40 when "0100",
              val_sin_48 when "0101",
              val_sin_56 when "0110",
              val_sin_64 when "0111",
              val_sin_72 when "1000",
              val_sin_80 when "1001",
              val_sin_88 when "1010",
              val_sin_88 when "1011",
              "0000000000" when others;

    --Edge Cases and standard assignment
    Y1 <= val_sin_89 when ANGLE = "1011001" else -- 89 binary
          val_sin_90 when ANGLE = "1011010" else -- 90 binary
          Y1_no_edge;

    Y2 <= val_sin_89 when ANGLE = "1011001" else
          val_sin_90 when ANGLE = "1011010" else
          Y2_no_edge;
          
    DELTA_X <= ANGLE(2 downto 0);
end RTL;
