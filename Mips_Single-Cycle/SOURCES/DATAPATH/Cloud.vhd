----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:22:16 04/06/2021 
-- Design Name: 
-- Module Name:    Cloud - Behavioral 
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

entity Cloud is
    Port ( CloudIn : in  STD_LOGIC_VECTOR (15 downto 0);
           CloudOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  CloudOp : in  STD_LOGIC_VECTOR(1 downto 0)
			  );
end Cloud;

architecture Behavioral of Cloud is

begin
process(CloudIn,CloudOp)
begin
--signedExtend
if(CloudOp="00") then
CloudOut <= std_logic_vector(resize(signed(CloudIn), 32));

--zerofilling
elsif(CloudOp="01") then
CloudOut <= std_logic_vector(resize(unsigned(CloudIn),32));

elsif(CloudOp="10") then
CloudOut <= std_logic_vector(unsigned(std_logic_vector(resize(unsigned(CloudIn),32))) sll 16);

elsif(CloudOp="11") then
CloudOut <= std_logic_vector(unsigned(std_logic_vector(resize(signed(CloudIn),32))) sll 2);
 
else
null;


end if;

end process;

end Behavioral;

