----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:25:41 03/13/2019 
-- Design Name: 
-- Module Name:    mux_4_1 - Behavioral 
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
entity mux4to1 is

port( A : in std_logic_vector ( 2 downto 0 ) ; 
      S1,S2,s3: in std_logic ;
      O: out std_logic_vector ( 2 downto 0 ) 
  );

end mux4to1;

 Architecture behavioral of mux4to1 is

begin

O <=   A   when (S1='0' and S2='0' and S3='0') else
     "000" when (S1='0' and S2='1' and S3='0') else
     "010" when (S1='1' and S2='0' and S3='0') else
     "011" when (S1='1' and S2='1' and S3='0') else
	  "001" ;
 
 end behavioral ;