----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:09:37 04/05/2021 
-- Design Name: 
-- Module Name:    Adder4 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder4 is
    Port ( AdderIn4 : in  STD_LOGIC_VECTOR (31 downto 0);
           AdderOut4 : out  STD_LOGIC_VECTOR (31 downto 0));
end Adder4;

architecture Behavioral of Adder4 is

begin


AdderOut4 <= std_logic_vector( unsigned(AdderIn4) + 4);



end Behavioral;

