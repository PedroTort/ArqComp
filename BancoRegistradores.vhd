library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BancoRegistradores is
    port(
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        wr_en: in STD_LOGIC;
        
        sel_reg_write: in unsigned(2 downto 0);
        sel_regA_read: in unsigned(2 downto 0);
        sel_regB_read: in unsigned(2 downto 0);
        
        data_in_banco: in unsigned(15 downto 0);
        data_out_regA: out unsigned(15 downto 0);
        data_out_regB: out unsigned(15 downto 0)
        
    );
end entity BancoRegistradores;

architecture a_BancoRegistradores of BancoRegistradores is
    component reg16bits is
        port
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    constant reg0_wr_en : STD_LOGIC := '0';
    signal reg0_out, reg1_out, reg2_out, reg3_out, reg4_out, reg5_out, reg6_out, reg7_out: unsigned(15 downto 0);
    signal  reg1_wr_en, reg2_wr_en, reg3_wr_en, reg4_wr_en, reg5_wr_en, reg6_wr_en, reg7_wr_en: STD_LOGIC;

begin
    reg0: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg0_wr_en, data_in=>data_in_banco, data_out=>reg0_out);
    reg1: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg1_wr_en, data_in=>data_in_banco, data_out=>reg1_out);
    reg2: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg2_wr_en, data_in=>data_in_banco, data_out=>reg2_out);
    reg3: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg3_wr_en, data_in=>data_in_banco, data_out=>reg3_out);
    reg4: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg4_wr_en, data_in=>data_in_banco, data_out=>reg4_out);
    reg5: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg5_wr_en, data_in=>data_in_banco, data_out=>reg5_out);
    reg6: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg6_wr_en, data_in=>data_in_banco, data_out=>reg6_out);
    reg7: reg16bits port map(clk=>clk, rst=>rst, wr_en => reg7_wr_en, data_in=>data_in_banco, data_out=>reg7_out);
    
    reg1_wr_en <='1' when sel_reg_write = "001" and wr_en = '1' else '0';
    reg2_wr_en <='1' when sel_reg_write = "010" and wr_en = '1' else '0';
    reg3_wr_en <='1' when sel_reg_write = "011" and wr_en = '1' else '0';
    reg4_wr_en <='1' when sel_reg_write = "100" and wr_en = '1' else '0';
    reg5_wr_en <='1' when sel_reg_write = "101" and wr_en = '1' else '0';
    reg6_wr_en <='1' when sel_reg_write = "110" and wr_en = '1' else '0';
    reg7_wr_en <='1' when sel_reg_write = "111" and wr_en = '1' else '0';
    
    data_out_regA <=    reg0_out when sel_regA_read ="000" else
                        reg1_out when sel_regA_read ="001" else
                        reg2_out when sel_regA_read ="010" else
                        reg3_out when sel_regA_read ="011" else
                        reg4_out when sel_regA_read ="100" else
                        reg5_out when sel_regA_read ="101" else
                        reg6_out when sel_regA_read ="110" else
                        reg7_out when sel_regA_read ="111" else
                        "0000000000000000";

    data_out_regB <=    reg0_out when sel_regB_read ="000" else
                        reg1_out when sel_regB_read ="001" else
                        reg2_out when sel_regB_read ="010" else
                        reg3_out when sel_regB_read ="011" else
                        reg4_out when sel_regB_read ="100" else
                        reg5_out when sel_regB_read ="101" else
                        reg6_out when sel_regB_read ="110" else
                        reg7_out when sel_regB_read ="111" else
                        "0000000000000000";

end architecture a_BancoRegistradores;