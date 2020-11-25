library IEEE;
use IEEE.std_logic_1164.all;
-- Pour la ocnversion du bit8 en entier
use IEEE.numeric_std.all;

--Pour bit8
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity SBox_I_O_tb is
end SBox_I_O_tb ;

architecture SBox_I_O_tb_arch of SBox_I_O_tb is

    component SBox_I_O
        port(
            data_i: in bit8;
            data_o: out bit8
        );
    end component;

    signal data_i_s : bit8;
    signal data_o_s : bit8;

begin

    DUT : SBox_I_O
        port map(
            data_i => data_i_s,
            data_o => data_o_s
        );

    data_i_s <= x"00", x"1F" after 50 ns;

end architecture ; 

configuration SBox_I_O_tb_conf of SBox_I_O_tb is
    
    for SBox_I_O_tb_arch
    for DUT : SBox_I_O
    use entity LIB_RTL.SBox_I_O(SBox_I_O_arch);
    end for;
    end for;
    
end configuration SBox_I_O_tb_conf;
