----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:08:41 04/04/2021 
-- Design Name: 
-- Module Name:    Mux - Behavioral 
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
use ieee.numeric_std.all;
use work.MyPackage.all;

entity Mux is
 port(
       MuxIn: in MadeType;
		 ard  : in std_logic_vector(4 downto 0);
	    MuxOut : out std_logic_vector(31 downto 0));
end Mux;

architecture Behavioral of Mux is

begin

  MuxOut <= MuxIn(to_integer(unsigned(ard))) after 10ns;


end Behavioral;

