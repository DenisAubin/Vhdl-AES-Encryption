library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity AES_tb is
end AES_tb ;

architecture AES_tb_arch of AES_tb is

    component AES
    port(
        clock_i: IN std_logic;
        resetb_i: IN std_logic;
        start_i: IN std_logic;
        text_i: IN bit128;
        cipher_o: OUT bit128;
        cas_on_o: OUT std_logic 
    );
    end component;

    signal clock_s: std_logic:='0';
    signal resetb_s: std_logic;
    signal start_s: std_logic;
    signal text_s: bit128;
    signal cipher_s: bit128;
    signal cas_on_s: std_logic;

begin

    DUT : AES
    port map(
        clock_i=> clock_s,
        resetb_i=>resetb_s,
        start_i=>start_s,
        text_i=>text_s,
        cipher_o=>cipher_s,
        cas_on_o=>cas_on_s
    );

    clock_s<=not(clock_s) after 50 ns;
    resetb_s<='1' after 0 ns;
    start_s<='1' after 0 ns;
    text_s<=(X"526573746f20656e2076696c6c65203f")after 0 ns;

end architecture ; -- arch

configuration AES_tb_conf of AES_tb is
    
    for AES_tb_arch
    for DUT : AES
    use entity LIB_RTL.AES(AES_arch);
    end for;
    end for;
    
end configuration AES_tb_conf ;