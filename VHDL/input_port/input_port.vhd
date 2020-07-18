----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:47:45 04/07/2019 
-- Design Name: 
-- Module Name:    input_port - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity input_latch is

generic	(	M	:	integer	:=	4	);	--size of input latch

 port (
		 
		 latch_input_port_i	:	in	std_logic_vector	(	M-1	downto	0	) ;	--	input	latch
		 latch_input_port_o	:	out	std_logic_vector	(	15	downto	0	)	--	input	latch
		 
		 )	;
end	input_latch	;


architecture Behavioral of input_latch is


begin
		latch_input_port_o (M-1 downto 0 ) <= latch_input_port_i;
		latch_input_port_o (15 downto M ) <= ( others=>'0') ;
				   

end	Behavioral	;

