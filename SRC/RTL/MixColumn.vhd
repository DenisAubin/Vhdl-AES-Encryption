LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;


entity MixColumn is
  port (
    data_in : IN row_state ;
    data_out : OUT row_state 
  ) ;
end MixColumn ;

architecture MixColumn_arch of MixColumn is
  --
  signal stockMul2, stockMul3 : column_state;

begin

  --Mul2
  stockMul2(0) <=(data_in(0)(6 downto 0)&'0') when data_in(0)(7)='0' else (data_in(0)(6 downto 0)&'0') XOR X"1B";
  stockMul2(1) <=(data_in(1)(6 downto 0)&'0') when data_in(1)(7)='0' else (data_in(1)(6 downto 0)&'0') XOR X"1B";
  stockMul2(2) <=(data_in(2)(6 downto 0)&'0') when data_in(2)(7)='0' else (data_in(2)(6 downto 0)&'0') XOR X"1B";
  stockMul2(3) <=(data_in(3)(6 downto 0)&'0') when data_in(3)(7)='0' else (data_in(3)(6 downto 0)&'0') XOR X"1B";
  --Mul3
  stockMul3(0)<= stockMul2(0) XOR data_in(0);
  stockMul3(1)<= stockMul2(1) XOR data_in(1);
  stockMul3(2)<= stockMul2(2) XOR data_in(2);
  stockMul3(3)<= stockMul2(3) XOR data_in(3);
  --Out
  data_out(0)<=((data_in(2) XOR data_in(3)) XOR stockMul2(0)) XOR stockMul3(1);
  data_out(1)<=((data_in(3) XOR data_in(0)) XOR stockMul2(1)) XOR stockMul3(2);
  data_out(2)<=((data_in(0) XOR data_in(1)) XOR stockMul2(2)) XOR stockMul3(3);
  data_out(3)<=((data_in(1) XOR data_in(2)) XOR stockMul2(3)) XOR stockMul3(0);

end architecture ; 