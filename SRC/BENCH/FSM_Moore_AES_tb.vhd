library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--Pour bit8
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity FSM_Moore_AES_tb is
end FSM_Moore_AES_tb ;

architecture FSM_Moore_AES_tb_arch of FSM_Moore_AES_tb is

    component FSM_Moore_AES
        port(
            clk_i: IN std_logic;
            resetb_i: IN std_logic;
            start_i: IN std_logic;
            end_key_expander_i: IN std_logic;
            round_o: OUT bit4 ;
            enable_output_o: OUT std_logic;  
            reset_key_expander_o: OUT std_logic;
            start_key_expander_o: OUT std_logic;
            aes_on_o: OUT std_logic;
            enableRoundComputing_o: OUT std_logic;
            enable_MC_o: OUT std_logic
        );
    end component;

    signal clk_s: std_logic:='0';
    signal resetb_s: std_logic;
    signal start_s: std_logic;
    signal end_key_expander_s: std_logic;
    signal round_s: bit4 ;
    signal enable_output_s: std_logic;  
    signal init_s: std_logic;
    signal reset_key_expander_s: std_logic;
    signal start_key_expander_s: std_logic;
    signal aes_on_s: std_logic;
    signal enableRoundComputing_s: std_logic;
    signal enable_MC_s: std_logic;


begin

    DUT : FSM_Moore_AES
        port map(
            clk_i=> clk_s,
            resetb_i=>resetb_s,
            start_i=>start_s,
            end_key_expander_i=>end_key_expander_s,
            round_o=>round_s,
            enable_output_o=>enable_output_s,
            reset_key_expander_o=> reset_key_expander_s,
            start_key_expander_o=>start_key_expander_s,
            aes_on_o=>aes_on_s,
            enableRoundComputing_o=>enableRoundComputing_s,
            enable_MC_o =>enable_MC_s
        );

        end_key_expander_s <= '1' after 0 ns;
        clk_s<=not(clk_s) after 50 ns;
        resetb_s<='0' after 0 ns, '1' after 10 ns;
        start_s<='1' after 0 ns;
        
end architecture ; 

configuration FSM_Moore_AES_tb_conf of FSM_Moore_AES_tb is
    
    for FSM_Moore_AES_tb_arch
    for DUT : FSM_Moore_AES
    use entity LIB_RTL.FSM_Moore_AES(FSM_Moore_AES_arch);
    end for;
    end for;
    
end configuration FSM_Moore_AES_tb_conf;
