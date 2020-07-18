----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:02:15 04/08/2019 
-- Design Name: 
-- Module Name:    output_port - Behavioral 
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

entity output_latch is

generic	(	N	:	integer	:=	16	);	--size of output latch	

 port (
       latch_output_port	:	inout	std_logic_vector	(	N-1	downto	0	)	;	--	output latch
		 
       clk	:	in std_logic	)	;		--for output port	latch
		 
end	output_latch	;




architecture Behavioral of output_latch is

signal	Lop	:	bit	;	--	when equals 1 output port receives data from R1

signal	data_out	:	std_logic_vector	(	N-1	downto	0	)	;	--	receives	data	from	output	port

signal	R1	:	std_logic_vector	(	N-1	downto	0	)	;	--	gives	data	to	output	port

begin


       process (	Lop	,	latch_output_port	)	
		 
        begin
		       if	Lop	=	'1'	then
				  
             if	rising_edge	(clk)	then
				 
                  latch_output_port	<=	R1	;		 
				
				
             end	if	;
				 end	if	;
				 
				 
		data_out	<=	latch_output_port	;-- always give output to data_out regardless the values of others	
	
      end	process	;
		
end	Behavioral	;


