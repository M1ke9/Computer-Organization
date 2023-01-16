----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    05:39:40 04/06/2021 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_ovf: out STD_LOGIC;
			  ALU_cout: out STD_LOGIC
			  );
end EXSTAGE;

architecture Behavioral of EXSTAGE is

signal AluInputB: std_logic_vector(31 downto 0);


COMPONENT MUX32
	PORT(
		MuxInput1 : IN std_logic_vector(31 downto 0);
		MuxInput2 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		MuxOutput : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	
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

	
begin


Inst_MUX32: MUX32 PORT MAP(
		MuxInput1 =>RF_B ,
		MuxInput2 =>Immed ,
		sel =>ALU_Bin_sel ,
		MuxOutput =>AluInputB 
	);
	
	
	
	Inst_ALU: ALU PORT MAP(
		A => RF_A,
		B => AluInputB ,
		Op => ALU_func ,
		ALUOut => ALU_out ,
		Zero => ALU_zero ,
		Cout => ALU_cout ,
		Ovf => ALU_ovf 
	);






end Behavioral;

