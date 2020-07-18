----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:10:13 03/02/2019 
-- Design Name: 
-- Module Name:    Adder - Behavioral 
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
entity a_16_bit_adder is
 
generic (n:integer:=16);  --  helps if we want to change the adder size we only change the value of n
 
port ( 

ADDRESS : in std_logic_vector (n-1 downto 0) ;  --first input to the 16 bit adder
OFSSET: in std_logic_vector ( n-1 downto 0) ;  -- second input to the 16 bit adder 
CIN : in std_logic  ;  -- carry in (NOT USED ) 
COUT : out std_logic ; -- final carry out  
SUM: out std_logic_vector (n-1 downto 0)); --sum of the two inputs    
end a_16_bit_adder ;


architecture a_16_bit_adder_structural of a_16_bit_adder is 


component full_adder is --creating entity for a full adder 

port (
in_1 : in std_logic ;  -- first input to the full adder 
in_2 : in std_logic ; -- second input to the full adder 
cin : in std_logic ;   -- carry in to the full adder 
sum: out std_logic  ;  -- sum of the 3 bits using full adder 
cout: out std_logic );  -- the output carry bit of a full adder
end component ;


signal carry_int : std_logic_vector (n-1 downto 0) ; -- the internal carry signals 

begin 

fa_1 : full_adder port map(ADDRESS(0),OFSSET(0),CIN,SUM(0),carry_int(0));  -- doing the first full adder independently  

 adder: for i in 1 to n-1 generate  -- the rest of full adders are implemented using for generate statment 

fa : full_adder port map(ADDRESS(i),OFSSET(i),carry_int(i-1),SUM(i),carry_int(i)); 

end generate adder ;
COUT<=carry_int(n-1) ;  --asigning the final carry to COUT 

end a_16_bit_adder_structural ;


