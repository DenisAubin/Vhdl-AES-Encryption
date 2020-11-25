library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library LIB_AES;
use LIB_AES.crypt_pack.all;

entity KeyExpansion_I_O_table is
  port (key_i           : in  bit128;
        clock_i         : in  std_logic;
        reset_i         : in  std_logic;
        start_i         : in  std_logic;
        round_i         : in  bit4;
        end_o           : out std_logic;
        expansion_key_o : out bit128);
end KeyExpansion_I_O_table;

architecture KeyExpansion_I_O_table_arch of KeyExpansion_I_O_table is
  type key_memory is array(0 to 10) of bit128;
  type State is (INIT, STOP);
  signal CurrentState, NextState : State;
  constant KeyMemory_s : key_memory := (
    X"2b7e151628aed2a6abf7158809cf4f3c",
    X"75ec78565d42aaf0f6b5bf78ff7af044",
    X"cafbfe2b97b954db610ceba39e761be7",
    X"c1bf4ef456061a2f370af18ca97cea6b",
    X"c8044b439e02516ca908a0e000744a8b",
    X"125885118c5ad47d2552749d25263e16",
    X"11897ad39dd3aeaeb881da339da7e425",
    X"d827b8a645f41608fd75cc3b60d2281e",
    X"27c95136623d473e9f488b05ff9aa31b",
    X"0bb8154b69855275f6cdd97009577a6b",
    X"e705100b8e80427e784d9b0e711ae165");
begin
  expansion_key_o <= KeyMemory_s(to_integer(unsigned(round_i)));

  P0 : process(reset_i, clock_i)
  begin
    if (reset_i = '0') then
      CurrentState <= INIT;
    elsif (clock_i'event and clock_i = '1') then
      CurrentState <= NextState;
    end if;
  end process P0;

  P1 : process(CurrentState, start_i)
  begin
    case CurrentState is
      when INIT =>
        if (start_i = '1') then
          NextState <= STOP;
        else
          NextState <= INIT;
        end if;
      when STOP =>
        if start_i = '1' then
          NextState <= STOP;
        else
          NextState <= INIT;
        end if;

      when others =>
    end case;
  end process P1;

  P2 : process(CurrentState)
  begin
    case CurrentState is
      when INIT =>
        end_o <= '0';
      when STOP =>
        end_o <= '1';
      when others =>
    end case;
  end process P2;

end architecture KeyExpansion_I_O_table_arch;

