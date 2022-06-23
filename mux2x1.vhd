library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux2x1 is
    port(
        sel               : in STD_LOGIC;
        data_I0, data_I1  : in unsigned (15 downto 0);
        data_O0           : out unsigned (15 downto 0)
    );
end entity mux2x1;

architecture a_mux2x1 of mux2x1 is
begin
    data_O0 <=    data_I0 when sel='0' else
                  data_I1 when sel='1' else
                  "0000000000000000";
end architecture a_mux2x1;