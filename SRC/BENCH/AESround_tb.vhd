LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;

library LIB_RTL;

entity AESround_tb is
end AESround_tb ;

architecture AESround_tb_arch of AESround_tb is

    component AESround
    port(
        text_i : IN bit128;
        clock_i : IN std_logic;
        resetb_i: IN std_logic;
        enableRoundComputing_i: IN std_logic;
        enable_MC_i: IN std_logic;
        currentKey_i: IN type_state;
        cipher_o: OUT bit128 
    );
    end component;

    signal text_i_s : bit128;
    signal clock_i_s : std_logic:='0';
    signal resetb_i_s: std_logic;
    signal enableRoundComputing_i_s: std_logic;
    signal enable_MC_i_s: std_logic;
    signal currentKey_i_s: type_state;
    signal cipher_o_s:  bit128;

begin

    DUT : AESround
    port map(
        text_i=> text_i_s,
        clock_i=> clock_i_s,
        resetb_i=> resetb_i_s,
        enableRoundComputing_i=> enableRoundComputing_i_s,
        enable_MC_i=> enable_MC_i_s,
        currentKey_i=> currentKey_i_s,
        cipher_o=> cipher_o_s
    );

    text_i_s<=(X"526573746f20656e2076696c6c65203f")after 0 ns;
    clock_i_s<=not(clock_i_s) after 50 ns;
    resetb_i_s<='0' after 0 ns, '1' after 10 ns;
    enableRoundComputing_i_s<= '0' after 0 ns, '1' after 55 ns;
    enable_MC_i_s<='1' after 0 ns;
    currentKey_i_s<=((X"2b", X"7e", X"15", X"16"),(X"28" ,X"ae" ,X"d2" ,X"a6"),
    (X"ab" ,X"f7" ,X"15" ,X"88"),(X"09" ,X"cf" ,X"4f" ,X"3c")) after 0 ns, 
    ((X"75", X"ec", X"78", X"56"),(X"5d" ,X"42" ,X"aa" ,X"f0"),
    (X"f6" ,X"b5" ,X"bf" ,X"78"),(X"ff" ,X"7a" ,X"f0" ,X"44"))after 55 ns;

end architecture ;

configuration AESround_tb_conf of AESround_tb is
    
    for AESround_tb_arch
    for DUT : AESround
    use entity LIB_RTL.AESround(AESround_arch);
    end for;
    end for;
    
end configuration AESround_tb_conf;