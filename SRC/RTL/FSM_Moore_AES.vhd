library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

entity FSM_Moore_AES is
  port (
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
  ) ;
end FSM_Moore_AES ;

architecture FSM_Moore_AES_arch of FSM_Moore_AES is

    -- definition du type state
    type state is ( attente, start_cpt, round0, round1_9, round10, finconv);
    -- definition des signaux
    signal etat_present , etat_futur : state ;
    -- définition des signaux du compteur
    signal init_cpt_s, enable_cpt_s : std_logic;
    signal round_s : bit4;

begin

  -- Affectation signaux à sorties
  round_o<=round_s;

  --Processus de mise à jour synchrone d'états de la FSM
  MaJetat : process (clk_i , resetb_i )
    begin 
    if resetb_i = '0' then
      etat_present <= attente ;
    elsif clk_i ' event and clk_i = '1' then
      etat_present <= etat_futur ;
    end if;
  end process MaJetat ;

  --Processus d'état futur de la FSM
  EtatFut : process ( etat_present , start_i, round_s )
    begin
    case etat_present is
    when attente =>
      if start_i = '1' then
        etat_futur <= start_cpt;
      else
        etat_futur <= attente;
      end if;
    when start_cpt =>
        etat_futur <= round0;
    when round0 =>
      etat_futur <= round1_9;
    when round1_9 =>
    if (round_s = "1001") then
      etat_futur <= round10;
    else
      etat_futur <= round1_9;
    end if;
    when round10 =>
        etat_futur <= finconv;
    when finconv =>
        etat_futur <= finconv;
    end case ;
  end process EtatFut ;

  -- Processus de calculs des sorties et signaux de la FSM
  calc_out : process (etat_present)
    begin
    case etat_present is
    when attente =>
      enable_output_o <='0';
      reset_key_expander_o <= '1';
      start_key_expander_o <= '0';
      aes_on_o <= '0';
      enableRoundComputing_o <= '0';
      enable_MC_o <= '0';
      init_cpt_s <= '1';  
      enable_cpt_s <= '0';
    when start_cpt =>
      enable_output_o <= '0';
      reset_key_expander_o <= '1';
      start_key_expander_o <='1';
      aes_on_o <= '1';
      enableRoundComputing_o <= '0';
      enable_MC_o <= '0';
      init_cpt_s <= '1';  
      enable_cpt_s <='1';
    when round0 =>
      enable_output_o <= '0';
      reset_key_expander_o <= '0';
      start_key_expander_o <= '1';
      aes_on_o <= '1';
      enableRoundComputing_o <= '0';
      enable_MC_o <= '0';
      init_cpt_s <= '0';  
      enable_cpt_s <= '1';
    when round1_9 =>
      enable_output_o <= '0';
      reset_key_expander_o <= '0';
      start_key_expander_o <= '1';
      aes_on_o <= '1';
      enableRoundComputing_o <= '1';
      enable_MC_o <= '1';
      init_cpt_s <= '0';  
      enable_cpt_s <= '1';
    when round10 =>
      enable_output_o <= '0';
      reset_key_expander_o <= '0';
      start_key_expander_o <= '1';
      aes_on_o <= '1';
      enableRoundComputing_o <= '1';
      enable_MC_o <= '0';
      init_cpt_s <= '0';  
      enable_cpt_s <= '1';
    when finconv =>
      enable_output_o <= '1';
      reset_key_expander_o <= '0';
      start_key_expander_o <= '0';
      aes_on_o <= '0';
      enableRoundComputing_o <= '0';
      enable_MC_o <= '0';
      init_cpt_s <= '0';  
      enable_cpt_s <= '0';
    end case ;
  end process calc_out ;

  -- Compteur de rondes
  counter : process (clk_i, resetb_i, init_cpt_s, enable_cpt_s ) is
    begin 
      if resetb_i = '0' then 
        round_s <= X"0";
      elsif clk_i'event and clk_i = '1' then 
        if (enable_cpt_s = '1') then
          if (init_cpt_s = '1') then
            round_s <= X"0";
          else
            if (round_s = X"0") then
              round_s <= X"1";
            elsif (round_s = X"1") then
              round_s <= X"2";
            elsif (round_s = X"2") then
              round_s <= X"3";
            elsif (round_s = X"3") then
              round_s <= X"4";
            elsif (round_s = X"4") then
              round_s <= X"5";
            elsif (round_s = X"5") then
              round_s <= X"6";
            elsif (round_s = X"6") then
              round_s <= X"7";
            elsif (round_s = X"7") then
              round_s <= X"8";
            elsif (round_s = X"8") then
              round_s <= X"9";
            else
              round_s <= X"a";
            end if;
          end if;
        end if;
      else
        round_s <= round_s;
      end if;
  end process counter;


    
end architecture ;