library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
    port(
        clk : in STD_LOGIC;
        adress: in unsigned(7 downto 0);
        data_ROM: out unsigned(15 downto 0);
        rom_read: in STD_LOGIC
    );
end entity ROM;

architecture a_ROM of ROM is
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant rom_content : mem := (
        0=> B"1100_011_000000000",      -- MOVE 0, $R3
        1=> B"1000_011_000000001",      -- ADDI $R3, 1
        2=> B"1110_011_011_110_000",    -- STORE $R3, (r3)
        3=> B"1011_000_000000000",      -- CMP $R0, 0  (RESETA A FLAG)
        4=> B"1011_011_000100000",      -- CMP $R3, 32
        5=> B"1101_0000_11111100",      -- BRANCH -4

        6=> B"1100_100_000000010",      -- MOVE 2, $R4
        7=> B"1100_101_000000010",      -- MOVE 2, $R5
        8=> B"0000_101_100_000_000",    -- ADD $R5, $R4
        9=> B"1110_000_101_110_000",    -- STORE $R0, (r5)
        10=> B"1011_000_000000000",     -- CMP $R0, 0  (RESETA A FLAG)
        11=> B"1011_101_000100000",     -- CMP $R4, 32
        12=> B"1101_0000_11111100",      -- BRANCH -4

        13=> B"1100_100_000000011",     -- MOVE 3, $R4
        14=> B"1100_101_000000011",     -- MOVE 3, $R5
        15=> B"0000_101_100_000_000",   -- ADD $R5, $R4
        16=> B"1110_000_101_110_000",   -- STORE $R0, (r5)
        17=> B"1011_000_000000000",     -- CMP $R0, 0  (RESETA A FLAG)
        18=> B"1011_101_000100000",     -- CMP $R5, 32
        19=> B"1101_0000_11111100",     -- BRANCH -4

        20=> B"1100_100_000000101",     -- MOVE 5, $R4
        21=> B"1100_101_000000101",     -- MOVE 5, $R5
        22=> B"0000_101_100_000_000",   -- ADD $R5, $R4
        23=> B"1110_000_101_110_000",   -- STORE $R0, (r5)
        24=> B"1011_000_000000000",     -- CMP $R0, 0  (RESETA A FLAG)
        25=> B"1011_101_000100000",     -- CMP $R5, 32
        26=> B"1101_0000_11111100",     -- BRANCH -4

        27=> B"1100_100_000000111",     -- MOVE 7, $R4
        28=> B"1100_101_000000111",     -- MOVE 7, $R5
        29=> B"0000_101_100_000_000",   -- ADD $R5, $R4
        30=> B"1110_000_101_110_000",   -- STORE $R0, (r5)
        31=> B"1011_000_000000000",     -- CMP $R0, 0  (RESETA A FLAG)
        32=> B"1011_101_000100000",     -- CMP $R5, 32
        33=> B"1101_0000_11111100",     -- BRANCH -4

        34=> B"1100_011_000000001",      -- MOVE 0, $R3
        35=> B"1000_011_000000001",      -- ADDI $R3, 1
        36=> B"1110_110_011_101_000",    -- LOAD $R6, (r3)
        37=> B"1011_000_000000000",      -- CMP $R0, 0  (RESETA A FLAG)
        38=> B"1011_011_000100000",      -- CMP $R3, 32
        39=> B"1101_0000_11111100",      -- BRANCH -4

        others => (others => '0')
    );
begin
    process(clk,rom_read)
    begin
        if(rom_read = '1') then
            if rising_edge(clk) then
                data_ROM <= rom_content(to_integer(adress));
            end if;
        end if;
    end process;

end architecture a_ROM;