library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity MixColumns_tb is
end MixColumns_tb ;

architecture MixColumns_tb_arch of MixColumns_tb is

    component MixColumns
    port(
        data_in : IN type_state ;
        enable_i : IN std_logic; 
        data_out : OUT type_state  
    );
    end component;

    signal data_in_s : type_state;
    signal enable_i_s : std_logic;
    signal data_out_s : type_state;

begin

    DUT : MixColumns
    port map(
        data_in => data_in_s,
        enable_i => enable_i_s,
        data_out => data_out_s
    );

    data_in_s<=((X"af", X"e6", X"01", X"d5"), (X"16", X"91", X"06", X"ab"), (X"ce", X"62", X"d3", X"b1"), (X"bc", X"44", X"20", X"ae")) after 0 ns;
    enable_i_s<= '0' after 0 ns, '1' after 25 ns;

end architecture ; -- arch

configuration MixColumns_tb_conf of MixColumns_tb is
    
    for MixColumns_tb_arch
    for DUT : MixColumns
    use entity LIB_RTL.MixColumns(MixColumns_arch);
    end for;
    end for;
    
end configuration MixColumns_tb_conf ;