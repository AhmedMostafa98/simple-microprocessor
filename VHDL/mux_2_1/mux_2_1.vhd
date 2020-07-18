----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:04:57 03/02/2019 
-- Design Name: 
-- Module Name:    mux_2_1 - Behavioral 
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

entity MUX is
		port(
				w0,w1 : in std_logic_vector (15 downto 0);
				sel  :in std_logic;
				f   : out std_logic_vector(15 downto 0)) ;
end MUX ;


architecture MUX_dataflow of MUX is 
		
		begin

		f <= w0 when (sel='0') else w1;

end MUx_dataflow;

