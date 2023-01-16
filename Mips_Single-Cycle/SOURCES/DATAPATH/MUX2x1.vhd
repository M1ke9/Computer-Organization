----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:44:50 04/05/2021 
-- Design Name: 
-- Module Name:    MUX2x1 - Behavioral 
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

entity MUX2x1 is
    Port ( MuxIn1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MuxIn2 : in  STD_LOGIC_VECTOR (31 downto 0);
           MuxOut : out  STD_LOGIC_VECTOR (31 downto 0);
           Sel : in  STD_LOGIC);
end MUX2x1;

architecture Behavioral of MUX2x1 is

begin
process(Sel,MuxIn1,MuxIn2)
begin

if(Sel='0') then
MuxOut<=MuxIn1;

elsif(Sel='1') then
MuxOut<=MuxIn2;

else
null;

end if;

end process;



end Behavioral;

