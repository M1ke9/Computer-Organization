----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:28:50 04/11/2021 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROC_SC is

Port(  
      PC_LDEN: in STD_LOGIC;
		CLK: in STD_LOGIC;
		RST:in STD_LOGIC;
		ZERO: out STD_LOGIC;
		OVF: out STD_LOGIC;
		COUT: out STD_LOGIC
		);
		
end PROC_SC;

architecture Behavioral of PROC_SC is

signal PC_SEL: std_logic;
signal RF_WREN:std_logic;
signal RF_WRDATA_SEL:std_logic;
signal RF_B_SEL1:std_logic;
signal ImmEXT:std_logic_vector(1 downto 0);
signal ALU_BIN_SEL1:std_logic;
signal ALU_FUNC:std_logic_vector(3 downto 0);
signal BYTEOP:std_logic;
signal MEM_WREN:std_logic;
signal InstructioNN:std_logic_vector(31 downto 0);
signal FLAG:std_logic;

		
COMPONENT DATAPATH
	PORT(
		PC_Sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		Clk : IN std_logic;
		RF_WrEN : IN std_logic;
		RF_WrData_sel : IN std_logic;
		RF_B_sel1 : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		ALU_Bin_sel1 : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		ByteOP : IN std_logic;
		Mem_WrEN : IN std_logic;          
		OverFlow : OUT std_logic;
		Cout : OUT std_logic;
		Zero : OUT std_logic;
		Instruction : OUT std_logic_vector(31 downto 0);
		BBFLAG : OUT std_logic
		);
	END COMPONENT;
	
	
COMPONENT CONTROL
	PORT(
		Instruction : IN std_logic_vector(31 downto 0);
		BBFlag : IN std_logic;          
		PC_Sel : OUT std_logic;
		RF_WrEN : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel1 : OUT std_logic;
		ImmExt : OUT std_logic_vector(1 downto 0);
		ALU_Bin_sel1 : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0);
		Mem_WrEN : OUT std_logic;
		ByteOP : OUT std_logic
		);
	END COMPONENT;

	


begin


Inst_DATAPATH: DATAPATH PORT MAP(
		PC_Sel => PC_SEL ,
		PC_LdEn =>PC_LDEN ,
		Reset => RST,
		Clk =>CLK ,
		RF_WrEN =>RF_WREN ,
		RF_WrData_sel =>RF_WRDATA_SEL ,
		RF_B_sel1 =>RF_B_SEL1 ,
		ImmExt =>ImmEXT ,
		ALU_Bin_sel1 => ALU_BIN_SEL1 ,
		ALU_func => ALU_FUNC ,
		OverFlow => OVF ,
		Cout =>COUT ,
		Zero =>ZERO ,
		ByteOP =>BYTEOP ,
		Mem_WrEN => MEM_WREN,
		Instruction => InstructioNN,
		BBFLAG => FLAG
	);
	
	
	Inst_CONTROL: CONTROL PORT MAP(
		PC_Sel =>PC_SEL,
		RF_WrEN =>RF_WREN ,
		RF_WrData_sel =>RF_WRDATA_SEL ,
		RF_B_sel1 =>RF_B_SEL1 ,
		ImmExt =>ImmEXT ,
		ALU_Bin_sel1 => ALU_BIN_SEL1 ,
		ALU_func => ALU_FUNC ,
		Mem_WrEN => MEM_WREN,
		ByteOP =>BYTEOP ,
		Instruction => InstructioNN,
		BBFlag => FLAG
	);


end Behavioral;

