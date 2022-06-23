library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg1bit is
    port(
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        wr_en: in STD_LOGIC;
        data_in: in STD_LOGIC;
        data_out: out STD_LOGIC
    );
end entity reg1bit;

architecture a_reg1bit of reg1bit is
    
    signal data_register : STD_LOGIC;

begin
    process(clk,rst,wr_en)
    begin
        if rst = '1' then
            data_register <= '0';
        elsif wr_en = '1' then
            if rising_edge(clk) then
                data_register <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= data_register;
    
end architecture a_reg1bit;