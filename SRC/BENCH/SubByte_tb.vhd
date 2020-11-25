library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity SubByte_tb is
end SubByte_tb ;

architecture SubByte_tb_arch of SubByte_tb is

    component SubByte is
        port (
          data_i: in type_state;
          data_o: out type_state
        ) ;
      end component ;

      signal data_i_s : type_state;
      signal data_o_s : type_state;
begin

    DUT : SubByte
    port map(
        data_i => data_i_s,
        data_o => data_o_s
    );

    data_i_s<=((X"79", X"1b", X"66", X"62"), (X"47", X"8e", X"b7", X"c8"), (X"8b", X"81", X"7c", X"e4"), (X"65", X"aa", X"6f", X"03")) after 0 ns;

end architecture ;

configuration SubByte_tb_conf of SubByte_tb is
    
    for SubByte_tb_arch
    for DUT : SubByte
    use entity LIB_RTL.SubByte(SubByte_arch);
    end for;
    end for;
    
end configuration SubByte_tb_conf;