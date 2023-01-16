----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:25:37 04/05/2021 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is

    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  RST : STD_LOGIC);
			  
end DECSTAGE;

architecture Behavioral of DECSTAGE is

signal RtInput: std_logic_vector(4 downto 0);
signal Dinn: std_logic_vector(31 downto 0);

COMPONENT RF
	PORT(
		Ard1 : IN std_logic_vector(4 downto 0);
		Ard2 : IN std_logic_vector(4 downto 0);
		Awr : IN std_logic_vector(4 downto 0);
		Din : IN std_logic_vector(31 downto 0);
		WrEn : IN std_logic;
		Clk : IN std_logic;
		Rst : IN std_logic;          
		Dout1 : OUT std_logic_vector(31 downto 0);
		Dout2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MULT_DEC
	PORT(
		MuxIn1 : IN std_logic_vector(4 downto 0);
		MuxIn2 : IN std_logic_vector(4 downto 0);
		sel : IN std_logic;          
		MuxOut : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
	
	
	
	COMPONENT MUX32
	PORT(
		MuxInput1 : IN std_logic_vector(31 downto 0);
		MuxInput2 : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		MuxOutput : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	
	COMPONENT Cloud
	PORT(
		CloudIn : IN std_logic_vector(15 downto 0);
		CloudOp : IN std_logic_vector(1 downto 0);          
		CloudOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	

	

begin


Inst_RF: RF PORT MAP(
		Ard1 => Instr(25 downto 21) ,
		Ard2 => RtInput  ,
		Awr =>Instr(20 downto 16),
		Dout1 => RF_A,
		Dout2 => RF_B,
		Din =>Dinn ,
		WrEn => RF_WrEn ,
		Clk => Clk ,
		Rst =>RST 
	);
	
	MUX_4: MULT_DEC PORT MAP(
		MuxIn1 => Instr(15 downto 11) ,
		MuxIn2 => Instr(20 downto 16) ,
		sel => RF_B_SEL,
		MuxOut => RtInput
	);
	
	

	
	MUX_32: MUX32 PORT MAP(
		MuxInput1 => ALU_out,
		MuxInput2 =>MEM_out ,
		sel => RF_WrData_sel,
		MuxOutput => Dinn 
	);
	
	
	Inst_Cloud: Cloud PORT MAP(
		CloudIn => Instr(15 downto 0) ,
		CloudOut =>Immed,
		CloudOp => ImmExt
	);

	
	

end Behavioral;

