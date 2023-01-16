----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:38:58 04/05/2021 
-- Design Name: 
-- Module Name:    AdderImmed - Behavioral 
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

entity AdderImmed is
    Port ( Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Immed_4 : out  STD_LOGIC_VECTOR (31 downto 0));
end AdderImmed;

architecture Behavioral of AdderImmed is

begin
PC_Immed_4 <= std_logic_vector(unsigned(Immed) + unsigned(PC_4));

end Behavioral;

