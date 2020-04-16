----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:39:12 04/11/2020 
-- Design Name: 
-- Module Name:    Encoder_to_time - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Encoder_to_time is
port ( enc_in_A_B: in std_logic_vector(2-1 downto 0);
		 s_rst: in std_logic;
		 BTN: in std_logic;
		 time_num: out unsigned(10-1 downto 0);
		 enable_cnt: out std_logic);
end Encoder_to_time;

architecture Behavioral of Encoder_to_time is
signal timing: unsigned(10-1 downto 0); 
signal before: std_logic_vector(2-1 downto 0);

begin
convert: process(enc_in_A_B,s_rst)
begin
	if s_rst = '1' then
	   case enc_in_A_B is
		when "00"  =>
			if before = "10" then
				timing <= timing +1;
			else timing <= timing -1;
			before <= enc_in_A_B;
			end if;
		when "01" =>
		   if before <= "00" then
			timing <= timing +1;
			else timing <= timing -1;
			before <= enc_in_A_B;
			end if;
		when "11" =>
		   if before <= "01" then
			timing <= timing +1;
			else timing <= timing -1;
			before <= enc_in_A_B;
			end if;
		when "10" =>
		   if before <= "11" then
			timing <= timing +1;
			else timing <= timing -1;
			before <= enc_in_A_B;
			end if;
		when others =>
		end case;
		time_num <= timing;
		if BTN = '1' then
		enable_cnt <= '1';
		end if;
	else timing <= "0000000000";
	end if;
end process;
end Behavioral;

