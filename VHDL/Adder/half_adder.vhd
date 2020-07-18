----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:11:31 04/08/2019 
-- Design Name: 
-- Module Name:    half_adder - Behavioral 
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

entity half_adder is -- creating entity for a half adder module 

port (

in1 : in std_logic ;   -- first input to the half adder
in2: in std_logic;       -- second input to the half adder 
sum1: out std_logic  ;   -- sum of the 2 bits 
c1: out std_logic );     -- carry of the two bits 
end half_adder ;   




architecture half_adder_model of half_adder is   -- creating architecture of the half adder 

begin 
sum1<=in1 xor in2 ;   --getting the sum using xor operation
c1<=in1 and in2 ;   -- getting the carry usinig the and operation 


end half_adder_model ;


