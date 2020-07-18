----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:56:59 03/02/2019 
-- Design Name: 
-- Module Name:    pc_register - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity programcounter is
		port (
				clock : in std_logic ;
				reset,LD: in std_logic ;
				load_pc: in std_logic_vector (15 downto 0);
				pc_out: out std_logic_vector (15 downto 0) 
				); 
end programcounter;


architecture behavioral of programcounter is
		
		signal pc: std_logic_vector (15 downto 0):= x"0000" ;

		begin
				process(clock,reset ) 
				begin
					if reset ='1'then
					pc<=(others=>'0');
					elsif (clock'event and clock='1')then
						if (LD='0')then
						pc<= load_pc;
						else 
						pc <= pc ;
						end if;
						else
					end if ;
		end process;

		pc_out<=pc;

end architecture;


