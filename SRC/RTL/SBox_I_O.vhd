library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library LIB_AES;
use  LIB_AES.crypt_pack.all;

entity SBox_I_O is
  port (
    data_i: in bit8; --bit8 : std_logic.vector(7 downto 0);
    data_o: out bit8
  ) ;
end SBox_I_O ;

architecture SBox_I_O_arch of SBox_I_O is

    type sbox_t is array (0 to 255) of bit8;
    constant Sbox_c : SboX_t := (
        X"52", X"09", X"6a", X"d5" ,X"30", X"36", X"a5", X"38", X"bf" ,X"40" ,X"a3" ,X"9e" ,X"81" ,X"f3" ,X"d7" ,X"fb",
        X"7c" ,X"e3" ,X"39" ,X"82" ,X"9b" ,X"2f" ,X"ff" ,X"87" ,X"34" ,X"8e" ,X"43" ,X"44" ,X"c4" ,X"de" ,X"e9" ,X"cb",
        X"54" ,X"7b" ,X"94" ,X"32" ,X"a6" ,X"c2" ,X"23" ,X"3d" ,X"ee" ,X"4c" ,X"95" ,X"0b" ,X"42" ,X"fa" ,X"c3" ,X"4e",
        X"08" ,X"2e" ,X"a1" ,X"66" ,X"28" ,X"d9" ,X"24" ,X"b2" ,X"76" ,X"5b" ,X"a2" ,X"49" ,X"6d" ,X"8b" ,X"d1" ,X"25",
        X"72" ,X"f8" ,X"f6" ,X"64" ,X"86" ,X"68" ,X"98" ,X"16" ,X"d4" ,X"a4" ,X"5c" ,X"cc" ,X"5d" ,X"65" ,X"b6" ,X"92",
        X"6c" ,X"70" ,X"48" ,X"50" ,X"fd" ,X"ed" ,X"b9" ,X"da" ,X"5e" ,X"15" ,X"46" ,X"57" ,X"a7" ,X"8d" ,X"9d" ,X"84",
        X"90" ,X"d8" ,X"ab" ,X"00" ,X"8c" ,X"bc" ,X"d3" ,X"0a" ,X"f7" ,X"e4" ,X"58" ,X"05" ,X"b8" ,X"b3" ,X"45" ,X"06",
        X"d0" ,X"2c" ,X"1e" ,X"8f" ,X"ca" ,X"3f" ,X"0f" ,X"02" ,X"c1" ,X"af" ,X"bd" ,X"03" ,X"01" ,X"13" ,X"8a" ,X"6b",
        X"3a" ,X"91" ,X"11" ,X"41" ,X"4f" ,X"67" ,X"dc" ,X"ea" ,X"97" ,X"f2" ,X"cf" ,X"ce" ,X"f0" ,X"b4" ,X"e6" ,X"73",
        X"96" ,X"ac" ,X"74" ,X"22" ,X"e7" ,X"ad" ,X"35" ,X"85" ,X"e2" ,X"f9" ,X"37" ,X"e8" ,X"1c" ,X"75" ,X"df" ,X"6e",
        X"47" ,X"f1" ,X"1a" ,X"71" ,X"1d" ,X"29" ,X"c5" ,X"89" ,X"6f" ,X"b7" ,X"62" ,X"0e" ,X"aa" ,X"18" ,X"be" ,X"1b",
        X"fc" ,X"56" ,X"3e" ,X"4b" ,X"c6" ,X"d2" ,X"79" ,X"20" ,X"9a" ,X"db" ,X"c0" ,X"fe" ,X"78" ,X"cd" ,X"5a" ,X"f4",
        X"1f" ,X"dd" ,X"a8" ,X"33" ,X"88" ,X"07" ,X"c7" ,X"31" ,X"b1" ,X"12" ,X"10" ,X"59" ,X"27" ,X"80" ,X"ec" ,X"5f",
        X"60" ,X"51" ,X"7f" ,X"a9" ,X"19" ,X"b5" ,X"4a" ,X"0d" ,X"2d" ,X"e5" ,X"7a" ,X"9f" ,X"93" ,X"c9" ,X"9c" ,X"ef",
        X"a0" ,X"e0" ,X"3b" ,X"4d" ,X"ae" ,X"2a" ,X"f5" ,X"b0" ,X"c8" ,X"eb" ,X"bb" ,X"3c" ,X"83" ,X"53" ,X"99" ,X"61",
        X"17" ,X"2b" ,X"04" ,X"7e" ,X"ba" ,X"77" ,X"d6" ,X"26" ,X"e1" ,X"69" ,X"14" ,X"63" ,X"55" ,X"21" ,X"0c" ,X"7d"
    ); 

begin
    data_o<= sbox_c(To_integer(Unsigned(data_i)));
end architecture ; 
