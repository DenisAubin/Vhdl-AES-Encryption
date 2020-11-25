LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;

library LIB_RTL;

entity MixColumns is
  port (
    data_in : IN type_state ;
    enable_i : IN std_logic; 
    data_out : OUT type_state 
  ) ;
end MixColumns ;

architecture MixColumns_arch of MixColumns is
    component MixColumn
        port(
            data_in : IN row_state ;
            data_out : OUT row_state
        );
    end component;

    signal data_s : type_state;

begin
    --generate MixColumn
      GenMixColumn : for I in 0 to 3 generate
        MixCol : MixColumn
          port map (
            data_in  => data_in(i),
            data_out => data_s(i));
      end generate GenMixColumn;

    data_out <= data_s when enable_i='1' else data_in;
         
end architecture ; 

configuration MixColumns_conf of MixColumns is
  for MixColumns_arch 
    for GenMixColumn 
      for MixCol : MixColumn
        use entity LIB_RTL.MixColumn(MixColumn_arch);
      end for;
    end for;
  end for;
end configuration MixColumns_conf;