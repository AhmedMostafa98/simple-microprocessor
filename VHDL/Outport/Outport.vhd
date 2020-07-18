----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:14:52 04/08/2019 
-- Design Name: 
-- Module Name:    Outport - Behavioral 
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
       latch_output_Data	:	out	std_logic_vector	(	N-1	downto	0	)	;	--	output latch
		 latch_input_Data	:	in	std_logic_vector	(	N-1	downto	0	)	;	--	output latch
		 load : in std_logic ;
       clk	:	in std_logic	)	;		--for output port	latch
		 
end	output_latch	;




architecture Behavioral of output_latch is

signal	data_out	:	std_logic_vector	(	N-1	downto	0	)	;	--	receives	data	from	output	port
signal data :	std_logic_vector	(	N-1	downto	0	)	:= x"0000" ;
signal	data_in	:	std_logic_vector	(	N-1	downto	0	)	;	--	gives	data	to	output	port

begin


Write_pro: process (clk)	
		 
           begin
				  
             if (clk'event and clk = '1' ) then
				 if ( load  = '1') then
                  Data <= Data_in	;	
				 else 
				 data <= data ;
             end	if	;
				 else 
				 end	if	;	
	
           end	process	;
		
		Data_in <=  latch_input_Data	;
		latch_output_Data	<=  Data ;
		
end	Behavioral	;



