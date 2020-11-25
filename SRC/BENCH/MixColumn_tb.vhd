library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity MixColumn_tb is
end MixColumn_tb ;

architecture MixColumn_tb_arch of MixColumn_tb is

    component MixColumn
    port(
        data_in : IN row_state ;
        data_out : OUT row_state 
    );
    end component;

    signal data_in_s : row_state;
    signal data_out_s : row_state;

begin

    DUT : MixColumn
    port map(
        data_in => data_in_s,
        data_out => data_out_s
    );

    data_in_s<=(X"af", X"e6", X"01", X"d5") after 0 ns;

end architecture ; -- arch

configuration MixColumn_tb_conf of MixColumn_tb is
    
    for MixColumn_tb_arch
    for DUT : MixColumn
    use entity LIB_RTL.MixColumn(MixColumn_arch);
    end for;
    end for;
    
end configuration MixColumn_tb_conf ;