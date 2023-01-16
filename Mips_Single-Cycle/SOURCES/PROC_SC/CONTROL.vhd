----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:27:31 04/10/2021 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
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

entity CONTROL is
Port (     PC_Sel : out  STD_LOGIC; 
			  RF_WrEN:out STD_LOGIC;
			  RF_WrData_sel:out STD_LOGIC;
			  RF_B_sel1: out STD_LOGIC;
			  ImmExt:out STD_LOGIC_VECTOR(1 downto 0);
			  ALU_Bin_sel1:out STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR(3 downto 0);
			  Mem_WrEN:out STD_LOGIC;
			  ByteOP:out STD_LOGIC;
			  Instruction:in STD_LOGIC_VECTOR(31 downto 0);
			  BBFlag:in STD_LOGIC
			  );
end CONTROL;

architecture Behavioral of CONTROL is

signal OPCODE: STD_LOGIC_VECTOR(5 downto 0);
signal Func: STD_LOGIC_VECTOR(3 downto 0);

begin
process(Instruction)
begin
OPCODE <= Instruction(31 downto 26);
Func <= Instruction(3 downto 0);

end process;


process(OPCODE,Func)
begin

--RTYPE
if(OPCODE="100000") then
    PC_Sel<='0';
    RF_WrEN<='1';
    RF_B_sel1<='0';
    RF_WrData_sel<='0';
    ALU_Bin_sel1<='0';
    ALU_func<=Func;
    Mem_WrEN<='0';
    ByteOP<='X';
	 ImmExt<="XX";

--li
elsif(OPCODE="111000") then
     PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; --ADD
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="00"; --signExtend
	  
--lui	  
elsif (OPCODE="111001") then

     PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; --ADD
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="10"; --<<16(zero-fill)

--ADDi
elsif (OPCODE="110000") then

     PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="00"; --SignExtend
	  
--nandi
elsif(OPCODE="110010") then

     PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0101"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="01"; --ZeroFill

--ORi
elsif(OPCODE="110011") then
    
	  PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0011"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="01"; --ZeroFill	

--b
elsif(OPCODE="111111") then 
     PC_Sel<='1';
     RF_WrEN<='0';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="11"; --<<2 signExtend
	  

 --beq   
elsif(OPCODE="000000") then  

 if(BBFlag='1') then
	  PC_Sel<='1';
  else
	  PC_Sel<='0';
  end if;
  
	  RF_WrEN<='0';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="11"; --<<2 signExtend
	  
 
	  
    	  
			
--bne
elsif (OPCODE="000001") then
  if (BBFlag = '1')  then
	  PC_Sel<='0';
	  
   
  end if;

     RF_WrEN<='0';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='X';
	  ImmExt<="11"; --<<2 signExtend



--lb

elsif(OPCODE="000011") then 

     PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='1';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='1';
	  ImmExt<="00"; --signExtend
	  
--sb
elsif(OPCODE="000111") then
     
	  PC_Sel<='0';
     RF_WrEN<='0';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='1';
     ByteOP<='1';
	  ImmExt<="00"; --signExtend
	  
--lw 
elsif(OPCODE="001111") then
    PC_Sel<='0';
     RF_WrEN<='1';
     RF_B_sel1<='1';
     RF_WrData_sel<='1';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='0';
	  ImmExt<="00";  --signExtend

	  
--sw      
elsif(OPCODE="011111") then
        
	  PC_Sel<='0';
     RF_WrEN<='0';
     RF_B_sel1<='1';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='1';
     ALU_func<="0000"; 
     Mem_WrEN<='1';
     ByteOP<='0';
	  ImmExt<="00"; --signExtend

else

     PC_Sel<='0';
     RF_WrEN<='0';
     RF_B_sel1<='0';
     RF_WrData_sel<='0';
     ALU_Bin_sel1<='0';
     ALU_func<="0000"; 
     Mem_WrEN<='0';
     ByteOP<='0';
	  ImmExt<="00";
	  

     

end if;
end process;

	  

	  
	  
    

end Behavioral;

