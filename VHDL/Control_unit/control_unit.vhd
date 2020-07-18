----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:37 03/02/2019 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all ;
use IEEE.std_logic_unsigned.all ;

entity control_unit is
port( 
	OPcode: in std_logic_vector ( 3 downto 0 ) ; --4 integer inputs 2^4--
	MicroReset : in std_logic; --Button Input to Reset the MircoProcessor
	--Control word
	-- WRF	WRAM	BRCE	BRCNE	SPC2	SPC1	SRFD1	SRFD2	SRFD3	SRFW1	SRFW2	SALU	LOP	SALU1	SALU0	LPC
	CtrlWord: out std_logic_vector(15 downto 0); --16 bit control--
	RPC , RRF: out std_logic); --output signals to reset both PC and RF
end entity;

architecture behave of control_unit is
  type rom_array is array (0 to 15) of STD_logic_vector (15 downto 0);
constant MyRom: rom_array :=(
	--Control word
	-- WRF	WRAM	BRCE	BRCNE	SPC2	SPC1	SRFD1	SRFD2	SRFD3	SRFW1	SRFW2	SALU	LOP	SALU1	SALU0	LPC
				0 => "1000100000100000",	--ALU8
				1 => "1000101000100000",	--IN
				2 => "0000100000001000",	--OUT
				3 => "0000010000000000",	--JR
				4 => "1000100000010010",	--ADDI
				5 => "1000100000010100",	--ANDI
				6 => "1000100000010110",	--ORI
				7 => "1000100010010010",	--LW
				8 => "0100100000010010",	--SW
				9 => "0010100000000000",	--BEQ
				10=> "0001100000000000",	--BNE
				11=> "0000000000000000",	--J
				12=> "1000000101000000",	--JAL 
				13=> "0000100000000000",	--NOP
				14=> "0000100000000000",	--Undefiend op-code treated as NOP
				15=> "0000100000000001",	--HLT
				others=>(others=>'0'));
begin 
CtrlWord <= MyRom(conv_integer(unsigned(OPcode))) ; 
RPC <= MicroReset;
RRF <= MicroReset;
end architecture;