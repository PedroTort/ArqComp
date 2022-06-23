library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

entity reg16bits is
    port(
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        wr_en: in STD_LOGIC;
        data_in: in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity reg16bits;

architecture a_reg16bits of reg16bits is
    
    signal data_register : unsigned(15 downto 0);

begin
    process(clk,rst,wr_en)
    begin
        if rst = '1' then
            data_register <= "0000000000000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then 
                data_register <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= data_register;
    
end architecture a_reg16bits;