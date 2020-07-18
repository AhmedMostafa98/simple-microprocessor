----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:12:39 04/08/2019 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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

entity full_adder is --creating entity for a full adder 

port (
in_1 : in std_logic ;  -- first input to the full adder 
in_2 : in std_logic ; -- second input to the full adder 
cin : in std_logic ;   -- caary in to the full adder 
sum: out std_logic  ;  -- sum of the 3 bits using full adder 
cout: out std_logic );  -- the output carry bit
end full_adder ;

architecture full_adder_structural of full_adder is   --creating architecture of a full adder 

component half_adder is  -- using the half adder component

port (

in1 : in std_logic ;   -- first input to the half adder
in2: in std_logic;       -- second input to the half adder 
sum1: out std_logic  ;   -- sum of the 2 bits 
c1: out std_logic );     -- carry of the two bits 
end component ;

signal s1: std_logic ;  --signal that has the sum of internal half adder
signal c1 : std_logic ;  -- signal that has the carry of internal 1st half adder
signal c2 : std_logic ;   --singal that has the carry of internal 2nd half adder

begin 

half1:half_adder  port map(in_1,in_2,s1,c1) ; --portmapping the inputs of the first half adder

half2:half_adder  port map(cin,s1,sum,c2) ;  --portmaping the inputs of the 2nd half adder  
cout<=c1 or c2 ;  -- getting final carry 

end full_adder_structural ;


