----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:53:16 05/09/2021 
-- Design Name: 
-- Module Name:    MuxExMc - Behavioral 
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

entity MuxExMc is
    Port ( MuxIn0 : in  STD_LOGIC_VECTOR (31 downto 0);
           MuxIn1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           MuxOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxExMc;

architecture Behavioral of MuxExMc is
signal PlusFour : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";


begin
process (Sel ,MuxIn0 , MuxIn1) begin
case (Sel) is

when "00" => MuxOut <= MuxIn0;
when "01" => MuxOut <= PlusFour;
when "10" => MuxOut <= MuxIn1;
when others => MuxOut <= (others =>'0');

end case;
end process;
end Behavioral;




