----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:41:58 04/08/2019 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.ALL; 
--use IEEE.numeric_std.ALL; 
entity RAM is
	port (
			clock : in std_logic ;
			W_enable : in std_logic ;
			Address : in std_logic_vector ( 5 downto 0 ) ;
			Data_in : in std_logic_vector ( 15 downto 0 ) ;
			Data_out : out std_logic_vector ( 15 downto 0 ) );
end RAM;

architecture Behavioral of RAM is

type ram is array ( integer range <> ) of std_logic_vector ( 15 downto 0 ) ;
signal in_reg : ram ( 0 to 2**6 ) := (
others => x"0000" 
);
signal Data_in_signal : std_logic_vector ( 15 downto 0 ) ;

begin 

WriteProcess: process(clock)

begin 
			if ( clock'event and clock = '1' ) then 
				if ( W_enable = '1' ) then 
			   in_reg(conv_integer(unsigned(Address))) <= Data_in_signal ;
				else
			End if ;
			else
			End if ;
			
End process ; 

				Data_out <= in_reg(conv_integer(unsigned(Address))) ;
				Data_in_signal <= Data_in ;
			
end Behavioral;

