LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;

ENTITY ShiftRows IS
    PORT (
        data_i : IN type_state;
        data_o : OUT type_state
    );
END ShiftRows;

ARCHITECTURE ShiftRows_arch OF ShiftRows IS

BEGIN

    L1: for I in 0 to 3 generate
        L2: for J in 0 to 3 generate
            data_o(i)(j)<=data_i((i+j) mod 4)(j);
        end generate;
    end generate;
        
    END ARCHITECTURE;