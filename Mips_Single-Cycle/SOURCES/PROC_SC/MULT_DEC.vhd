----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:52:12 04/06/2021 
-- Design Name: 
-- Module Name:    MULT_DEC - Behavioral 
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

entity MULT_DEC is
    Port ( MuxIn1 : in  STD_LOGIC_VECTOR (4 downto 0);
           MuxIn2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           MuxOut : out  STD_LOGIC_VECTOR (4 downto 0));
end MULT_DEC;

architecture Behavioral of MULT_DEC is




begin
process(sel,MuxIn1,MuxIn2)
begin

if(sel='0') then
MuxOut<=MuxIn1;

elsif(Sel='1') then
MuxOut<=MuxIn2;

else
null;

end if;

end process;




end Behavioral;

