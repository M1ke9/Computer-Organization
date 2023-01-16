----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:06 05/09/2021 
-- Design Name: 
-- Module Name:    ExstageMC - Behavioral 
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

entity ExstageMC is
       
	Port(	 RF_A:in STD_LOGIC_VECTOR(31 downto 0);
	       RF_B:in STD_LOGIC_VECTOR(31 downto 0);
			 Immed: in STD_LOGIC_VECTOR(31 downto 0);
			 ALU_Bin_SelB:in STD_LOGIC_VECTOR(1 downto 0);
			 ALU_Func:in STD_LOGIC_VECTOR(3 downto 0);
			 ALU_Out:out STD_LOGIC_VECTOR(31 downto 0);
			 ALU_zero : out  STD_LOGIC;
			 ALU_ovf: out STD_LOGIC;
			 ALU_cout: out STD_LOGIC
		
	);


end ExstageMC;

architecture Behavioral of ExstageMC is
signal MuxOUT: STD_LOGIC_VECTOR(31 downto 0);

COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		Op : IN std_logic_vector(3 downto 0);          
		ALUOut : OUT std_logic_vector(31 downto 0);
		Zero : OUT std_logic;
		Cout : OUT std_logic;
		Ovf : OUT std_logic
		);
	END COMPONENT;

	COMPONENT MuxExMc
	PORT(
		MuxIn0 : IN std_logic_vector(31 downto 0);
		MuxIn1 : IN std_logic_vector(31 downto 0);
		Sel : IN std_logic_vector(1 downto 0);          
		MuxOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	


begin


	Inst_ALU: ALU PORT MAP(
		A =>RF_A ,
		B =>MuxOUT ,
		Op =>ALU_Func ,
		ALUOut =>ALU_Out ,
		Zero =>ALU_zero ,
		Cout =>ALU_cout ,
		Ovf => ALU_ovf 
	);
	
	
	Inst_MuxExMc: MuxExMc PORT MAP(
		MuxIn0 =>RF_B ,
		MuxIn1 => Immed ,
		Sel =>ALU_Bin_SelB ,
		MuxOut =>MuxOUT
	);
	
	
	

end Behavioral;

