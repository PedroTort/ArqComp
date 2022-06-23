library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Processador is
    port(
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        
        tl_estado: out unsigned(1 downto 0);
        tl_PC: out unsigned(7 downto 0);
        tl_instrucao: out unsigned(15 downto 0);
        tl_Reg1_out: out unsigned(15 downto 0);
        tl_Reg2_out: out unsigned(15 downto 0);
        tl_ULA_out:  out unsigned(15 downto 0)
    );
end entity Processador;

architecture a_Processador of Processador is
    component reg1bit is
        port
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : IN STD_LOGIC ;
            data_out : OUT STD_LOGIC
        );
    end component;
    component MaquinaEstados is
        port
        (
            clk    : IN STD_LOGIC ;
            rst    : IN STD_LOGIC ;
            estado : OUT unsigned (1 downto 0)
        );
    end component;
    
    component PC is
        port
        (
            clk_pc      : IN std_logic ;
            wr_en       : IN std_logic ;
            rst         : IN std_logic ;
            data_in_pc  : IN unsigned (7 downto 0);
            data_out_pc : OUT unsigned (7 downto 0)
        );
    end component;
    
    component ROM is
        port
        (
            clk      : IN STD_LOGIC ;
            adress   : IN unsigned (7 downto 0);
            data_ROM : OUT unsigned (15 downto 0);
            rom_read : IN STD_LOGIC
        );
    end component;
    
    component BancoRegistradores is
        port
        (
            clk           : IN STD_LOGIC ;
            rst           : IN STD_LOGIC ;
            wr_en         : IN STD_LOGIC ;
            sel_reg_write : IN unsigned (2 downto 0);
            sel_regA_read : IN unsigned (2 downto 0);
            sel_regB_read : IN unsigned (2 downto 0);
            data_in_banco : IN unsigned (15 downto 0);
            data_out_regA : OUT unsigned (15 downto 0);
            data_out_regB : OUT unsigned (15 downto 0)
        );
    end component;
    
    component ULA is
        port
        (
            ula_in_A         : IN unsigned (15 downto 0);
            ula_in_B         : IN unsigned (15 downto 0);
            ula_out          : OUT unsigned (15 downto 0);
            ula_flag         : OUT STD_LOGIC ;
            sel_op           : IN unsigned (1 downto 0)
        );
    end component;
    
    component mux2x1 is
        port
        (
            sel     : IN STD_LOGIC ;
            data_I0 : IN unsigned (15 downto 0);
            data_I1 : IN unsigned (15 downto 0);
            data_O0 : OUT unsigned (15 downto 0)
        );
    end component;
    
    component UC is
        port
        (
            clk         : IN STD_LOGIC ;
            rst         : IN STD_LOGIC ;
            instruction : IN unsigned (15 downto 0);
            data_in_pc  : OUT unsigned (7 downto 0);
            data_out_pc : IN unsigned (7 downto 0);
            pc_att      : OUT STD_LOGIC ;
            rom_read    : OUT STD_LOGIC ;
            estado      : IN unsigned (1 downto 0);
            reg_wr      : OUT STD_LOGIC ;
            ULA_op      : OUT unsigned (1 downto 0);
            ULAsrcB     : OUT STD_LOGIC ;
            sel_regA    : OUT unsigned (2 downto 0);
            sel_regB    : OUT unsigned (2 downto 0);
            sel_reg_wr  : OUT unsigned (2 downto 0);
            jump_en     : OUT STD_LOGIC ;
            branch_en   : OUT STD_LOGIC ;
            reg_wr_cc   : OUT STD_LOGIC ;
            ram_wr      : OUT STD_LOGIC;
            sel_banco_in : OUT STD_LOGIC
        );
    end component;
    
    component ram is
        port
        (
            clk      : IN STD_LOGIC ;
            endereco : IN unsigned (6 downto 0);
            wr_en    : IN STD_LOGIC ;
            dado_in  : IN unsigned (15 downto 0);
            dado_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal estado_s, ULA_op_s: unsigned(1 downto 0);
    signal pc_en_s,rom_read_s, reg_wr_en_s, jump_en_s, reg_wr_cc_s: STD_LOGIC;
    signal data_in_pc_s, data_out_pc_s: unsigned(7 downto 0);
    signal sel_reg_wr_s, sel_regA_s, sel_regB_s: unsigned(2 downto 0);
    signal regA_out_s, regB_out_s, ULA_out_s, instruction_s:unsigned(15 downto 0);
    signal mux_1_out_s: unsigned(15 downto 0);
    signal ULA_out_logic_s, flag_c_out_s: STD_LOGIC;
    signal ULAsrcB_s: STD_LOGIC;
    signal const: unsigned(15 downto 0);
    signal branch_offset: unsigned(7 downto 0);
    signal branch_en_s: STD_LOGIC;
    signal wr_en_ram_s: STD_LOGIC;
    signal dado_out_ram_s: unsigned(15 downto 0);
    signal endereco_ram_s: unsigned(6 downto 0);
    signal data_in_banco_s: unsigned(15 downto 0);
    signal sel_ram_s: STD_LOGIC;
    
begin
    flag_c: reg1bit
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => reg_wr_cc_s,
        data_in  => ULA_out_logic_s,
        data_out => flag_c_out_s
    );

    
    maqEstado0: MaquinaEstados
    port map
    (
        clk    => clk,
        rst    => rst,
        estado => estado_s
    );
    
    pc0: PC
    port map
    (
        clk_pc      => clk,
        wr_en       => pc_en_s,
        rst         => rst,
        data_in_pc  => data_in_pc_s,
        data_out_pc => data_out_pc_s
    );
    
    rom0: ROM
    port map
    (
        clk      => clk,
        adress   => data_out_pc_s,
        data_ROM => instruction_s,
        rom_read => rom_read_s
    );
    
    bancoReg0: BancoRegistradores
    port map
    (
        clk           => clk,
        rst           => rst,
        wr_en         => reg_wr_en_s,
        sel_reg_write => sel_reg_wr_s,
        sel_regA_read => sel_regA_s,
        sel_regB_read => sel_regB_s,
        data_in_banco => data_in_banco_s,
        data_out_regA => regA_out_s,
        data_out_regB => regB_out_s
    );
    
    ula0: ULA
    port map
    (
        ula_in_A         => regA_out_s,
        ula_in_B         => mux_1_out_s,
        ula_out          => ULA_out_s,
        ula_flag         => ULA_out_logic_s,
        sel_op           => ULA_op_s
    );
    
    mux2x1_1: mux2x1
    port map
    (
        sel     => ULAsrcB_s,
        data_I0 => regB_out_s,
        data_I1 => const,
        data_O0 => mux_1_out_s
    );
    
    mux2x1_2: mux2x1
    port map
    (
        sel     => sel_ram_s,
        data_I0 => ULA_out_s,
        data_I1 => dado_out_ram_s,
        data_O0 => data_in_banco_s
    );

    
    uc0: UC
    port map
    (
        clk         => clk,
        rst         => rst,
        instruction => instruction_s,
        data_in_pc  => data_in_pc_s,
        data_out_pc => data_out_pc_s,
        pc_att      => pc_en_s,
        rom_read    => rom_read_s,
        estado      => estado_s,
        reg_wr      => reg_wr_en_s,
        ULA_op      => ULA_op_s,
        ULAsrcB     => ULAsrcB_s,
        sel_regA    => sel_regA_s,
        sel_regB    => sel_regB_s,
        sel_reg_wr  => sel_reg_wr_s,
        jump_en     => jump_en_s,
        reg_wr_cc   => reg_wr_cc_s,
        branch_en   => branch_en_s,
        ram_wr      => wr_en_ram_s,
        sel_banco_in => sel_ram_s
    );
    ram0: ram
    port map
    (
        clk      => clk,
        endereco => endereco_ram_s,
        wr_en    => wr_en_ram_s,
        dado_in  => ULA_out_s,
        dado_out => dado_out_ram_s
    );

    const <= ("0000000") & instruction_s(8 downto 0) when instruction_s(8) = '0' and wr_en_ram_s = '0' else
             ("1111111") & instruction_s(8 downto 0) when  wr_en_ram_s = '0' else
             "0000000000000000";

    endereco_ram_s <= regB_out_s(6 downto 0);
    
    branch_offset <= instruction_s(7 downto 0);
    
    data_in_pc_s <= data_out_pc_s + branch_offset when flag_c_out_s = '1' and branch_en_s = '1' else
    instruction_s(7 downto 0) when jump_en_s = '1'
else data_out_pc_s+1;
    
    tl_estado <= estado_s;
    tl_PC <= data_out_pc_s;
    tl_instrucao <= instruction_s;
    tl_Reg1_out <= regA_out_s;
    tl_Reg2_out <= regB_out_s;
    tl_ULA_out <= ULA_out_s;

end architecture a_Processador;