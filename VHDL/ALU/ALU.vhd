----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:53:50 03/02/2019 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
 ---------------------------------------------------entity-------------------------------------------------------------
entity ALU is port (
			Alu_inputA,Alu_inputB : in std_logic_vector (15 downto 0);
			Alu_result : out std_logic_vector (15 downto 0);
			Alu_control: in std_logic_vector (2 downto 0);
			Zero : out std_logic
);
end ALU;
------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------Architechture---------------------------------------------------------
Architecture model of ALU is

signal Result : std_logic_vector (15 downto 0);

begin

with Alu_control select 
Result     <=   Alu_inputA + Alu_inputB         when "000",      -----Addition
		Alu_inputA - Alu_inputB         when "001",	 -----Subtraction
		Alu_inputA AND Alu_inputB       when "010",      -----Bitwise AND
		Alu_inputA OR  Alu_inputB       when "011",      -----Bitwise OR
		Alu_inputA NOR Alu_inputB       when "100",      -----Bitwise NOR
		Alu_inputA XOR Alu_inputB       when "101",      -----Bitwise  XOR
		Alu_inputA (14 downto 0)&'0'    when "110",	 -----Shift left
		'0' & Alu_inputA (15  downto 1) when "111",      -----Shift right
		(others => 'Z')when others;

Alu_result<=Result;

Zero <= '1' when Result = x"0000" else
        '0';

end model;
------------------------------------------------------------------------------------------------------------------------