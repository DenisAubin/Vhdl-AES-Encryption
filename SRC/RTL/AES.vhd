library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

library LIB_RTL;

entity AES is
    port (
        clock_i: IN std_logic;
        resetb_i: IN std_logic;
        start_i: IN std_logic;
        text_i: IN bit128;
        cipher_o: OUT bit128;
        cas_on_o: OUT std_logic
    );
end entity AES;

architecture AES_arch of AES is

    --Déclarations des composants
    component AESround
        port(
            text_i : IN bit128;
            clock_i : IN std_logic;
            resetb_i: IN std_logic;
            enableRoundComputing_i: IN std_logic;
            enable_MC_i: IN std_logic;
            currentKey_i: IN type_state;
            cipher_o: OUT bit128 
        );
        end component;

    component KeyExpansion_I_O_table 
            port (key_i           : in  bit128;
                  clock_i         : in  std_logic;
                  reset_i         : in  std_logic;
                  start_i         : in  std_logic;
                  round_i         : in  bit4;
                  end_o           : out std_logic;
                  expansion_key_o : out bit128
                );
          end component;
    
    component FSM_Moore_AES
          port(
			 clk_i: IN std_logic;
             resetb_i: IN std_logic;
             start_i: IN std_logic;
             end_key_expander_i: IN std_logic;
             round_o: OUT bit4 ;
             enable_output_o: OUT std_logic;  
             reset_key_expander_o: OUT std_logic;
             start_key_expander_o: OUT std_logic;
             aes_on_o: OUT std_logic;
             enableRoundComputing_o: OUT std_logic;
             enable_MC_o: OUT std_logic
          );
		  end component;

	--Signaux intermédiaires
	signal current_key_s: bit128;
	signal enableRoundComputing_s : std_logic;
	signal enable_MC_s : std_logic;
	signal cipher_s : bit128;
	signal round_s : bit4;
	signal end_key_expander_s : std_logic;
	signal enable_output_s : std_logic;
	signal aes_on_s : std_logic;
	signal reset_key_expander_s : std_logic;
	signal start_key_expander_s : std_logic;
    signal key_typestate_s : type_state;
    signal stock_sortie_s : bit128:=X"00000000000000000000000000000000";


begin

	L1: for I in 0 to 3 generate
        L2: for J in 0 to 3 generate
            key_typestate_s(J)(I)<=current_key_s(127-32*J-8*I downto 120-32*J -8*I);
        end generate;
    end generate;

    RD : AESround
            port map(text_i,clock_i,resetb_i,enableRoundComputing_s,enable_MC_s,key_typestate_s,cipher_s);
    KE : KeyExpansion_I_O_table
            port map(current_key_s,clock_i,reset_key_expander_s,start_key_expander_s,round_s,end_key_expander_s,current_key_s);
    FSM : FSM_Moore_AES
		  port map (clock_i,resetb_i,start_i,end_key_expander_s,round_s,enable_output_s,reset_key_expander_s,start_key_expander_s,aes_on_s,enableRoundComputing_s,enable_MC_s);
    
    stock_sortie_s <= cipher_s when (enable_output_s='1' AND clock_i'event AND clock_i='0' AND stock_sortie_s=X"00000000000000000000000000000000") else stock_sortie_s;		
    cipher_o <= stock_sortie_s;
    cas_on_o <= aes_on_s;

end AES_arch ; 

configuration AES_conf of AES is
    for AES_arch  
        for RD : AESround
            use entity LIB_RTL.AESround(AESround_arch);
        end for;
        for KE : KeyExpansion_I_O_table
            use entity LIB_RTL.KeyExpansion_I_O_table(KeyExpansion_I_O_table_arch);
        end for;
        for FSM : FSM_Moore_AES
            use entity LIB_RTL. FSM_Moore_AES( FSM_Moore_AES_arch);
        end for;
    end for;
end configuration AES_conf;
