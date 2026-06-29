library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SINE_FUNCTION_FIXED_POINT is
    PORT(
        ANGLE   : in std_logic_vector(9 downto 0);
        SINE    : out std_logic_vector(9 downto 0);
        CLK     : in std_logic;
        RST     : in std_logic
    );
end SINE_FUNCTION_FIXED_POINT;

architecture STRUCTURAL of SINE_FUNCTION_FIXED_POINT is
    component REG_PP_N_BIT
        generic(N : integer);
        port(
            CLK : in  std_logic;
            RST : in  std_logic;
            D   : in  std_logic_vector(N-1 downto 0);
            Q   : out std_logic_vector(N-1 downto 0)
        );
    end component REG_PP_N_BIT;

    component REG_D
        PORT(
            CLK : in  std_logic;
            RST : in  std_logic;
            D   : in  std_logic;
            Q   : out std_logic
        );
    end component REG_D;

    component FIRST_STAGE
        PORT(
            ANGLE               : in std_logic_vector(9 downto 0);
            ANGLE_ADAPTED       : out std_logic_vector(6 downto 0);
            SIGN_CALCULATED     : out std_logic
        );
    end component FIRST_STAGE;

    component SECOND_STAGE
        port(
            ANGLE : in  std_logic_vector(6 downto 0);
            SINE  : out std_logic_vector(9 downto 0)
        );
    end component SECOND_STAGE;

    component THIRD_STAGE
        PORT(
            SINE        : in std_logic_vector(9 downto 0);
            SIGN        : in std_logic;
            SINE_DEF    : out std_logic_vector(9 downto 0)
        );
    end component THIRD_STAGE;

    signal ANGLE_sign               : std_logic_vector(9 downto 0);
    signal ANGLE_ADAPTED_sign       : std_logic_vector(6 downto 0);
    signal ANGLE_ADAPTED_sign_reg   : std_logic_vector(6 downto 0);
    signal SINE_sign                : std_logic_vector(9 downto 0);
    signal SINE_sign_reg            : std_logic_vector(9 downto 0);
    signal SINE_sign_reg_2            : std_logic_vector(9 downto 0);
    signal SIGN_sign                : std_logic;
    signal SIGN_sign_reg            : std_logic;
    signal SIGN_sign_reg_2          : std_logic;

begin
    REG_PP_ENTRY: REG_PP_N_BIT
        GENERIC MAP(N => 10)
        PORT MAP(
            CLK => CLK,
            RST => RST,
            D   => ANGLE,
            Q   => ANGLE_sign
        );
    FIRST_STAGE_inst: FIRST_STAGE
        PORT MAP(
            ANGLE               => ANGLE_sign,
            ANGLE_ADAPTED       => ANGLE_ADAPTED_sign,
            SIGN_CALCULATED     => SIGN_sign
        );
    REG_PP_AFTER_FIRST_STAGE: REG_PP_N_BIT
        GENERIC MAP(N => 7)
        PORT MAP(
            CLK => CLK,
            RST => RST,
            D   => ANGLE_ADAPTED_sign,
            Q   => ANGLE_ADAPTED_sign_reg
        );
    REG_SIGN_AFTER_FIRST_STAGE: REG_D
        PORT MAP(
            CLK => CLK,
            RST => RST,
            D   => SIGN_sign,
            Q   => SIGN_sign_reg
        );
    SECOND_STAGE_inst : SECOND_STAGE
        port map(
            ANGLE => ANGLE_ADAPTED_sign_reg,
            SINE  => SINE_sign
        );
    REG_PP_AFTER_SECOND_STAGE : component REG_PP_N_BIT
        generic map(
            N => 10
        )
        port map(
            CLK => CLK,
            RST => RST,
            D   => SINE_sign,
            Q   => SINE_sign_reg
        );
    REG_SIGN_AFTER_SECOND_STAGE : component REG_D
        port map(
            CLK => CLK,
            RST => RST,
            D   => SIGN_sign_reg,
            Q   => SIGN_sign_reg_2
        );
    
    THIRD_STAGE_inst : THIRD_STAGE
        PORT MAP(
            SINE        => SINE_sign_reg,
            SIGN        => SIGN_sign_reg_2,
            SINE_DEF    => SINE_sign_reg_2
        );

    REG_PP_OUTPUT : component REG_PP_N_BIT
        generic map(
            N => 10
        )
        port map(
            CLK => CLK,
            RST => RST,
            D   => SINE_sign_reg_2,
            Q   => SINE
        );

end STRUCTURAL;
