library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram is
    port(
        clk: in STD_LOGIC;
        endereco :in unsigned(6 downto 0);
        wr_en: in STD_LOGIC;
        dado_in : in unsigned(15 downto 0);
        dado_out: out unsigned(15 downto 0)
    );
    
end entity ram;

architecture ram_a of ram is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    signal ram_content : mem;
begin
    process(clk,wr_en)
    begin
        if rising_edge(clk) then
            if wr_en = '1' then
                ram_content(to_integer(endereco)) <= dado_in;
            end if;
        end if;
    end process;
    dado_out <= ram_content(to_integer(endereco));
    
end architecture ram_a;