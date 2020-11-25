LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
LIBRARY LIB_AES;
USE LIB_AES.crypt_pack.ALL;

library LIB_RTL;

entity AESround is
  port (
    text_i : IN bit128;
    clock_i : IN std_logic;
    resetb_i: IN std_logic;
    enableRoundComputing_i: IN std_logic;
    enable_MC_i: IN std_logic;
    currentKey_i: IN type_state;
    cipher_o: OUT bit128
  ) ;
end AESround ;

architecture AESround_arch of AESround is

    --Déclarations des composants
    component SubByte
        port(
            data_i: in type_state;
            data_o: out type_state
        );
        end component;

        component ShiftRows
        port(
            data_i: in type_state;
            data_o: out type_state
        );
        end component;

    component MixColumns
        port(
            data_in : IN type_state ;
            enable_i : IN std_logic; 
            data_out : OUT type_state 
        );
    end component;

    component AddRoundKey
        port(
            data_i : IN type_state;
    	    data_o : OUT type_state;
    	    key_i : IN type_state
        );
    end component;


    --Signaux intermediaires    
    signal text_s : type_state;
    signal state_s: type_state;
    signal SBOut_s :type_state;
    signal SROut_s :type_state;
    signal MCOut_s :type_state;
    signal ARK_in_s : type_state;
    signal ARK_out_s :type_state;
    signal cipher_s : bit128;

begin
    --Conversion du texte d'entrée en type_state et state_s en bit_128
    L1: for I in 0 to 3 generate
        L2: for J in 0 to 3 generate
            text_s(J)(I)<=text_i(127-32*J-8*I downto 120-32*J -8*I);
            cipher_s(127-32*J-8*I downto 120-32*J-8*I )<=state_s(J)(I);
        end generate;
    end generate;
    
    --Multiplexeur pré ARK
    ARK_in_s <= MCOut_s when enableRoundComputing_i='1' else text_s;

    -- Entités des composants avec signaux
    SB : SubByte
            port map(state_s, SBOut_s);
    SR : ShiftRows
            port map(SBOut_s, SROut_s);
    MC : MixColumns
          port map (SROut_s, enable_MC_i, MCOut_s);
    ARK : AddRoundKey
            port map(ARK_in_s, ARK_out_s, currentKey_i);

    --Bascule DFF pour mémoriser l'état        
    Memseq : process ( clock_i , resetb_i ) is
        begin
        if resetb_i = '0' then
        state_s <= (others => (others => (others => '0')));
        elsif clock_i ' event and clock_i = '1' then 
        state_s <= ARK_out_s ;
        else
        state_s <= state_s ;
        end if;
        end process Memseq ;

        cipher_o<=cipher_s;
   
end architecture ;

configuration AESround_conf of AESround is
    for AESround_arch  
        for SB : SubByte
            use entity LIB_RTL.SubByte(SubByte_arch);
        end for;
        for SR : ShiftRows
            use entity LIB_RTL.ShiftRows(ShiftRows_arch);
        end for;
        for MC : MixColumns
            use entity LIB_RTL. MixColumns( MixColumns_arch);
        end for;
        for ARK : AddRoundKey
            use entity LIB_RTL.AddRoundKey(AddRoundKey_arch);
        end for;
    end for;
end configuration AESround_conf;