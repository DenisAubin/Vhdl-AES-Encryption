library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity ShiftRows_tb is
    end ShiftRows_tb ;

architecture ShiftRows_tb_arch of ShiftRows_tb is

    component ShiftRows
        port(
            data_i: in type_state;
            data_o: out type_state
        );
    end component;

    signal data_i_s : type_state;
    signal data_o_s : type_state;

begin

    DUT : ShiftRows
        port map(
            data_i => data_i_s,
            data_o => data_o_s
        );

    data_i_s(0)<=(X"52", X"09", X"6a", X"d5") after 0 ns;
    data_i_s(1)<=(X"7c" ,X"e3" ,X"39" ,X"82") after 0 ns;
    data_i_s(2)<=(X"54" ,X"7b" ,X"94" ,X"32") after 0 ns;
    data_i_s(3)<=(X"08" ,X"2e" ,X"a1" ,X"66") after 0 ns;
    
end architecture ; 

configuration ShiftRows_tb_conf of ShiftRows_tb is
    
    for ShiftRows_tb_arch
    for DUT : ShiftRows
    use entity LIB_RTL.ShiftRows(ShiftRows_arch);
    end for;
    end for;
    
end configuration ShiftRows_tb_conf ;