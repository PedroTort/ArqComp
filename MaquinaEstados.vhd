library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;  

entity MaquinaEstados is
    port(
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        estado: out unsigned(1 downto 0)
    );
end entity MaquinaEstados;

architecture a_MaquinaEstados of MaquinaEstados is
    signal estado_s: unsigned(1 downto 0);
begin
    process(clk,rst)
    begin
        if(rst = '1') then
            estado_s <= "00";
        elsif (rising_edge(clk)) then 
            if estado_s = "10" then 
                estado_s <= "00";
             else
                estado_s <= estado_s + 1;
            end if;
        end if;
    end process;
    estado <= estado_s;

end architecture a_MaquinaEstados;