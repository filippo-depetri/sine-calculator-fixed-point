library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    port ( 
        X : in std_logic;
        Y : in std_logic;
        Cin : in std_logic;
        S : out std_logic;
        Cout : out std_logic
    );
end FA;

architecture RTL of FA is
begin
    S <= X xor Y xor Cin;
    Cout <= (X and Y) or (Y and Cin) or (X and Cin);
end RTL;