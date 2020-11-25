library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

library LIB_RTL;

entity SubByte is
  port (
    data_i: in type_state;
    data_o: out type_state
  ) ;
end SubByte ;

architecture SubByte_arch of SubByte is
  component SBox_I_O
    port (
        data_i: in bit8;
        data_o: out bit8
      );
    end component;

    signal data_s: type_state;

begin

  L1: for i in 0 to 3 generate
    L2: for j in 0 to 3 generate
      SBox_I_Oij : SBox_I_O
        port map (
          data_i  => data_i(i)(j),
          data_o => data_s(i)(j)
          );
    end generate L2; 
  end generate L1;

    data_o<=data_s;

end architecture ; 


configuration SubByte_conf of SubByte is
  for SubByte_arch 
    for L1 
      for L2 
        for SBox_I_Oij : SBox_I_O
          use entity LIB_RTL.SBOX_I_O(SBOX_I_O_arch);
        end for;
      end for;
    end for;
  end for;
end configuration SubByte_conf;
