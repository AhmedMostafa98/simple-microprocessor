----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:12 03/15/2019 
-- Design Name: 
-- Module Name:    mux_21_3 - Behavioral 
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

entity mux_21_3 is
		port(
				w0,w1 : in std_logic_vector ( 2 downto 0);
				sel  :in std_logic;
				f   : out std_logic_vector( 2 downto 0)) ;
end  mux_21_3 ;


architecture MUX_dataflow of  mux_21_3 is 
		
		begin

		f <= w0 when (sel='0') else w1;

end MUx_dataflow;
