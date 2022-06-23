library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ULA_tb is
end entity ULA_tb;

architecture a_ULA_tb of ULA_tb is
    component ULA is
        port(
            ula_in_A: in unsigned(15 downto 0);
            ula_in_B: in unsigned(15 downto 0);
            
            ula_out: out unsigned(15 downto 0);
            ula_greater_flag: out STD_LOGIC;
            
            sel_op: in unsigned(1 downto 0)
        );
    end component;
    
    signal ula_in_A, ula_in_B, ula_out: unsigned(15 downto 0);
    signal ula_greater_flag: STD_LOGIC;
    signal sel_op: unsigned(1 downto 0);
    
begin
    
    ula0: ULA port map(
        ula_in_A => ula_in_A,
        ula_in_B => ula_in_B,
        ula_out  => ula_out,
        ula_greater_flag => ula_greater_flag,
        sel_op   => sel_op
    );

    process
    begin
        --Soma: 2 + 1 = 3
        ula_in_A <= "0000000000000010";
        ula_in_B <= "0000000000000001";
        sel_op <= "00";
        
        wait for 50 ns;
        
        --Soma: 4 + (-2) = 2
        ula_in_A <= "0000000000000100";
        ula_in_B <= "1111111111111110";
        sel_op <= "00";
        
        wait for 50 ns;
        
        -- Soma: 1 + (-2) = -1
        ula_in_A <= "0000000000000001";
        ula_in_B <= "1111111111111110";
        sel_op <= "00";
        
        wait for 50 ns;
        
        --Subtração: 2 - 1 = 1
        ula_in_A <= "0000000000000010";
        ula_in_B <= "0000000000000001";
        sel_op <= "01";
        
        wait for 50 ns;
        
        --Subtração: 4 - (-2) = 6
        ula_in_A <= "0000000000000100";
        ula_in_B <= "1111111111111110";
        sel_op <= "01";
        
        wait for 50 ns;
        
        -- Subtração: 1 - 4 = -3
        ula_in_A <= "0000000000000001";
        ula_in_B <= "0000000000000100";
        sel_op <= "01";
        
        wait for 50 ns;
        
        -- Subtração: -1 - 4 = -5
        ula_in_A <= "1111111111111111";
        ula_in_B <= "0000000000000100";
        sel_op <= "01";
        
        wait for 50 ns;
        
        -- AND
        ula_in_A <= "1111111111111111";
        ula_in_B <= "1001000100100100";
        sel_op <= "10";
        
        wait for 50 ns;
        
        -- se 2 > 1
        ula_in_A <="0000000000000010";
        ula_in_B <="0000000000000001";
        sel_op <= "11";
        
        wait for 50 ns;
        
        -- se 64 > 128
        ula_in_A <="0000000001000000";
        ula_in_B <="0000000010000000";
        sel_op <= "11";
        
        wait for 50 ns;
        
        -- se -2 > -1;
        ula_in_A <="1111111111111110";
        ula_in_B <="1111111111111111";
        sel_op <= "11";
        
        wait for 50 ns;
        
        -- se -1 > -2;
        ula_in_A <="1111111111111111";
        ula_in_B <="1111111111111110";
        sel_op <= "11";
        
        wait for 50 ns;
        
        -- se 2 > 2;
        ula_in_A <="0000000000000010";
        ula_in_B <="0000000000000010";
        sel_op <= "11";
        
        wait for 50 ns;
        
        
        -- se A negativo e B postivo;
        ula_in_A <="1000000000000010";
        ula_in_B <="0000000000000010";
        sel_op <= "11";
        
        wait for 50 ns;
        
        -- se A positivo e B negativo;
        ula_in_A <="0000000000000010";
        ula_in_B <="1000000000000010";
        sel_op <= "11";
        
        wait for 50 ns;
        
        wait;
    end process;
end architecture a_ULA_tb;

