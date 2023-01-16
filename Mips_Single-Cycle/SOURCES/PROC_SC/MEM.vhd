----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:53:53 04/06/2021 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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

entity MEM is
    Port ( ByteOp1 : in  STD_LOGIC;
           Mem_WrEn1 : in  STD_LOGIC;
           ALU_MEM_addr1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn1 : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut1 : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_Addr1 : out  STD_LOGIC_VECTOR (31 downto 0);
			  MM_WrEn1 : out STD_LOGIC;
           MM_WrData1 : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData1 : in  STD_LOGIC_VECTOR (31 downto 0)
			  );
end MEM;

architecture Behavioral of MEM is

 signal Lbyte: std_logic_vector(7 downto 0);
 signal Sbyte: std_logic_vector(7 downto 0);


begin

process(MM_RdData1, MEM_DataIn1)

begin

 Lbyte <= std_logic_vector(MM_RdData1(7 downto 0));
 Sbyte <= std_logic_vector(MEM_DataIn1(7 downto 0));
 
end process;

process(ByteOp1,Mem_WrEn1,ALU_MEM_addr1,Sbyte,Lbyte)

begin

MM_Addr1<=ALU_MEM_addr1;

--lw
if ((ByteOp1='0') and (Mem_WrEn1='0')) then

  MM_WrEn1<='0';
  MEM_DataOut1<=MM_RdData1 after 10 ns;

--sw
elsif((ByteOp1='0') and (Mem_WrEn1='1')) then

  MM_WrEn1<='1';
  MM_WrData1<=MEM_DataIn1;
  
--lb
elsif((ByteOp1='1') and (Mem_WrEn1='0')) then

  MM_WrEn1<='0';
  MEM_DataOut1 <= std_logic_vector(resize(unsigned(Lbyte), 32)) after 10 ns;

--sb
elsif((ByteOp1='1') and (Mem_WrEn1='1')) then

  MM_WrEn1 <= '1';
  MM_WrData1<=std_logic_vector(resize(unsigned(Sbyte),32));
  
  else
  null;
  
  end if;
  end process;
 

end Behavioral;

