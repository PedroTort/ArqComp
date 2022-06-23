library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UC is
    port(
        clk,rst: in STD_LOGIC;
        instruction: in unsigned(15 downto 0);
        data_in_pc: out unsigned(7 downto 0);
        data_out_pc: in unsigned(7 downto 0);
        pc_att: out STD_LOGIC;
        rom_read: out STD_LOGIC;
        estado: in unsigned(1 downto 0);
        reg_wr: out STD_LOGIC;
        ULA_op: out unsigned(1 downto 0);
        ULAsrcB: out STD_LOGIC;
        sel_regA, sel_regB, sel_reg_wr: out unsigned(2 downto 0);
        jump_en: out STD_LOGIC;
        branch_en: out STD_LOGIC;
        reg_wr_cc: out STD_LOGIC;
        ram_wr: out STD_LOGIC;
        sel_banco_in: out STD_LOGIC
    );
end entity UC;

architecture a_UC of UC is
    signal opcode: unsigned(3 downto 0);
    signal func: unsigned(2 downto 0);
    signal ram_wr_s: std_logic;
begin
    pc_att <= '1' when estado = "01" else '0';
    rom_read <= '1' when estado = "00" else '0';
    ram_wr_s <= '1' when opcode = "1110" and func = "110" else '0' ;
    
    opcode <= instruction(15 downto 12);
    
    func <= instruction(5 downto 3) when opcode ="0000" or opcode = "1110" else "000";
    
    jump_en <= '1' when opcode="1111" else '0'; --jump
    
    reg_wr_cc <= '0' when opcode = "1111" or opcode = "0111" or opcode = "1101" or opcode = "1110"  else 
                 '0' when estado /= "01" else '1';
    
    ULA_op <= "11" when opcode ="1011" or func = "011" else -- compara
              "01" when opcode ="1001" or func = "001" else -- sub
              "10" when opcode ="1010" or func = "010" else -- and
              "00";                                         -- soma
    
    sel_regA <= "000" when opcode = "1100" or func = "100"  else
                "000" when opcode = "1110" and func = "101" else
                instruction(11 downto 9);
    
    sel_regB <= instruction(8 downto 6);
    
    sel_reg_wr <= instruction(11 downto 9);
    
    ULAsrcB <= '0' when opcode = "0000" else '1';
    
    branch_en <= '1' when opcode = "1101" else '0';
    
    reg_wr <= '0' when opcode = "1111" or opcode = "1011" or opcode = "0111" or func= "011" or opcode = "1101" or (opcode = "1110" and func = "110") else
    '0' when estado /= "01" else '1';
    
    ram_wr <= ram_wr_s when estado = "10" else '0';
    
    sel_banco_in <= '1' when opcode = "1110" and func = "101" else '0';

end architecture a_UC;