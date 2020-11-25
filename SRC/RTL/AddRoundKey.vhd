LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;

entity AddRoundKey is
  port (
    data_i : IN type_state;
    data_o : OUT type_state;
    key_i : IN type_state
  ) ;
end AddRoundKey ;

architecture AddRoundKey_arch of AddRoundKey is


begin

    L1: for I in 0 to 3 generate
      L2: for J in 0 to 3 generate
        data_o(I)(J)<= data_i(I)(J) XOR key_i(I)(J);
      end generate;
    end generate;

end architecture ;