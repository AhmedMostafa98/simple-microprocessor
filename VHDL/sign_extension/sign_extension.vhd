----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:03:12 03/02/2019 
-- Design Name: 
-- Module Name:    sign_extension - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity signextend is
port (   data_in : in std_logic_vector(5 downto 0);
         data_out : out std_logic_vector(15 downto 0)); 
end signextend;

architecture Behavioral of signextend is
begin 
 data_out(5 downto 0) <= data_in;
 data_out(15 downto 6) <=(others => data_in(5));
end behavioral ;

