library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port
    (
        clk_pc             : in std_logic;
        wr_en              : in std_logic;
        rst                : in std_logic;
        data_in_pc         : in unsigned(7 downto 0);
        data_out_pc        : out unsigned(7 downto 0)
    );
end entity;

architecture a_PC of PC is
    signal registro : unsigned(7 downto 0);

begin
    process(rst,clk_pc,wr_en) 
    begin
        if rst = '1' then
            registro <= "00000000";
        elsif wr_en = '1' then 
            if rising_edge(clk_pc) then
                registro <= data_in_pc;
            end if;
        end if;
    end process;

    data_out_pc <= registro; 

end architecture;