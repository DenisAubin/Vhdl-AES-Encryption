library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity AddRoundKey_tb is
    end AddRoundKey_tb ;

architecture AddRoundKey_tb_arch of AddRoundKey_tb is

    component AddRoundKey
        port(
            data_i: in type_state;
            data_o: out type_state;
            key_i: in type_state
        );
    end component;

    signal data_i_s : type_state;
    signal data_o_s : type_state;
    signal key_i_s : type_state;

begin

    DUT : AddRoundKey
        port map(
            data_i => data_i_s,
            data_o => data_o_s,
            key_i => key_i_s
        );

    data_i_s(0)<=(X"52", X"09", X"6a", X"d5") after 0 ns;
    data_i_s(1)<=(X"7c" ,X"e3" ,X"39" ,X"82") after 0 ns;
    data_i_s(2)<=(X"54" ,X"7b" ,X"94" ,X"32") after 0 ns;
    data_i_s(3)<=(X"08" ,X"2e" ,X"a1" ,X"66") after 0 ns;

    key_i_s(0)<=(X"52", X"09", X"6a", X"d5") after 0 ns;
    key_i_s(1)<=(X"7c" ,X"e3" ,X"39" ,X"82") after 0 ns;
    key_i_s(2)<=(X"54" ,X"7b" ,X"94" ,X"32") after 0 ns;
    key_i_s(3)<=(X"08" ,X"2e" ,X"a1" ,X"66") after 0 ns;
    
end architecture ; 

configuration AddRoundKey_tb_conf of AddRoundKey_tb is
    
    for AddRoundKey_tb_arch
    for DUT : AddRoundKey
    use entity LIB_RTL.AddRoundKey(AddRoundKey_arch);
    end for;
    end for;
    
end configuration AddRoundKey_tb_conf ;