----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:50:21 03/02/2019 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-----------------------------------------------entity-------------------------------------------------------------------------
entity reg_file is port ( 
			Read_register1,Read_register2,Write_register : in std_logic_vector (2 downto 0);    --8 Registers--
			Data_in : in std_logic_vector (15 downto 0) ;
			Write_enable,clk,reset : in std_logic;
			Read_Data1,Read_data2 : out  std_logic_vector (15 downto 0)
);
end reg_file ;
----------------------------------------------------------------------------------------------------------------------------------
	
----------------------------------------------Architecture------------------------------------------------------------------

Architecture  behavioral of reg_file is
                          -----------------8 signals each signal is 16 bits-----------------------
type regfile is array (0 to 2**3-1) of std_logic_vector (15 downto 0);    
 signal reg : regfile := ( others=> x"0000" ) ;
					
begin
process(reset,clk)
begin

	 if(reset='1')then            
   			----------------reset all the registers-------------                  
			reg(0)<=x"0000";
			reg(1)<=x"0000";
			reg(2)<=x"0000";
			reg(3)<=x"0000";
			reg(4)<=x"0000";
			reg(5)<=x"0000";
			reg(6)<=x"0000";
			reg(7)<=x"0000";


	elsif(clk'event and clk='1')then
				if(Write_enable='1')then
			-----------------writing data------------------------
						reg(conv_integer(unsigned(Write_register)))<=Data_in;
				else 
				end if;	
				else 
	end if;
end process;
                          ----------------Reading Data--------------
Read_data1<=reg(conv_integer(unsigned(read_register1)));                     
Read_Data2<=reg(conv_integer(unsigned(read_register2)));

end behavioral;
-------------------------------------------------------------------------------------------------------------------------------------------
