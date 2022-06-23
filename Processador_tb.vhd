library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Processador_tb is
end entity Processador_tb;

architecture a_Processador_tb of Processador_tb is
    component Processador is
        port
        (
            clk          : IN STD_LOGIC ;
            rst          : IN STD_LOGIC ;
            tl_estado    : OUT unsigned (1 downto 0);
            tl_PC        : OUT unsigned (7 downto 0);
            tl_instrucao : OUT unsigned (15 downto 0);
            tl_Reg1_out  : OUT unsigned (15 downto 0);
            tl_Reg2_out  : OUT unsigned (15 downto 0);
            tl_ULA_out   : OUT unsigned (15 downto 0)
        );
    end component;
    constant period_time: time := 100 ns;
    signal finished: STD_LOGIC := '0';
    signal clk, rst: STD_LOGIC;
    
    signal tl_estado    :  unsigned (1 downto 0);
    signal tl_PC        :  unsigned (7 downto 0);
    signal tl_instrucao :  unsigned (15 downto 0);
    signal tl_Reg1_out  :  unsigned (15 downto 0);
    signal tl_Reg2_out  :  unsigned (15 downto 0);
    signal tl_ULA_out   :  unsigned (15 downto 0);
    
begin
    
    doubleP: Processador
    port map
    (
        clk          => clk,
        rst          => rst,
        tl_estado    => tl_estado,
        tl_PC        => tl_PC,
        tl_instrucao => tl_instrucao,
        tl_Reg1_out  => tl_Reg1_out,
        tl_Reg2_out  => tl_Reg2_out,
        tl_ULA_out   => tl_ULA_out
    );
    
    reset_global:process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc:process
    begin 
        wait for 1 ms;
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clk_proc:process
    begin
        while finished /= '1' loop
            clk<='0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
end architecture a_Processador_tb;