----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:17 05/12/2021 
-- Design Name: 
-- Module Name:    PROCESSOR_MC - Behavioral 
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

entity PROCESSOR_MC is

PORT( CLK:in std_logic;
      RST:in std_logic;
		OverFlow:out std_logic;
		Cout:out std_logic
		);
end PROCESSOR_MC;

architecture Behavioral of PROCESSOR_MC is


signal PROC_PC_Sel:std_logic;
signal PROC_PC_LdEn:std_logic;
signal PROC_Instruction:std_logic_vector(31 downto 0);
signal PROC_RF_WrEn:std_logic;
signal PROC_RF_WrDataSel:std_logic;
signal PROC_RF_BSel:std_logic;
signal PROC_ImmExt:std_logic_vector(1 downto 0);
signal PROC_ALU_SrcA:std_logic;
signal PROC_ALU_SrcB:std_logic_vector(1 downto 0);
signal PROC_ALU_Func:std_logic_vector(3 downto 0);
signal PROC_BBflag:std_logic;
signal PROC_ByteOp:std_logic;
signal PROC_MemWrEn:std_logic;
signal PROC_InstrWr:std_logic;
signal PROC_Awr:std_logic;
signal PROC_Bwr:std_logic;
signal PROC_AluWr:std_logic;
signal PROC_MemWr:std_logic;



COMPONENT DatapathMC
	PORT(
		Reset : IN std_logic;
		Clk : IN std_logic;
		PC_Sel : IN std_logic;
		PC_LdEn : IN std_logic;
		RF_WrEN : IN std_logic;
		RF_WrData_sel : IN std_logic;
		RF_B_sel1 : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		ALU_SrcA : IN std_logic;
		ALU_SrcB : IN std_logic_vector(1 downto 0);
		ALU_func : IN std_logic_vector(3 downto 0);
		ByteOP : IN std_logic;
		Mem_WrEN : IN std_logic;
		InstructWr : IN std_logic;
		AWr : IN std_logic;
		BWr : IN std_logic;
		MEMWr : IN std_logic;
		ALUWr : IN std_logic;          
		OverFlow : OUT std_logic;
		Cout : OUT std_logic;
		Instruction : OUT std_logic_vector(31 downto 0);
		BBFLAG : OUT std_logic
		);
	END COMPONENT;
	
	
	COMPONENT ControlMC
	PORT(
		CLK : IN std_logic;
		Instruction : IN std_logic_vector(31 downto 0);
		RST : IN std_logic;
		BBFLAG : IN std_logic;          
		PC_sel : OUT std_logic;
		PC_LdEn : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrDatasel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		ImmExt : OUT std_logic_vector(1 downto 0);
		ALUSrcA : OUT std_logic;
		ALUSrcB : OUT std_logic_vector(1 downto 0);
		ALU_func : OUT std_logic_vector(3 downto 0);
		Mem_WrEn : OUT std_logic;
		Byte_Op : OUT std_logic;
		InstructWr : OUT std_logic;
		AWr : OUT std_logic;
		BWr : OUT std_logic;
		MEMWr : OUT std_logic;
		ALUWr : OUT std_logic
		);
	END COMPONENT;

begin

Inst_DatapathMC: DatapathMC PORT MAP(
		Reset =>RST ,
		Clk =>CLK ,
		PC_Sel =>PROC_PC_Sel ,
		PC_LdEn =>PROC_PC_LdEn ,
		RF_WrEN =>PROC_RF_WrEn ,
		RF_WrData_sel => PROC_RF_WrDataSel ,
		RF_B_sel1 =>PROC_RF_BSel ,
		ImmExt => PROC_ImmExt ,
		ALU_SrcA => PROC_Alu_SrcA ,
		ALU_SrcB =>PROC_Alu_SrcB ,
		ALU_func =>PROC_ALU_Func ,
		OverFlow => OverFlow,
		Cout =>Cout ,
		ByteOP =>PROC_ByteOp ,
		Mem_WrEN =>PROC_MemWrEn ,
		Instruction =>PROC_Instruction ,
		BBFLAG =>PROC_BBflag ,
		InstructWr => PROC_InstrWr,
		AWr =>PROC_Awr ,
		BWr => PROC_Bwr ,
		MEMWr => PROC_MemWr,
		ALUWr => PROC_AluWr
	);
	
	
	Inst_ControlMC: ControlMC PORT MAP(
		CLK =>CLK ,
		Instruction =>PROC_Instruction,
		RST =>RST ,
		BBFLAG =>PROC_BBflag ,
		PC_sel =>PROC_PC_Sel ,
		PC_LdEn =>PROC_PC_LdEn ,
		RF_WrEn =>PROC_RF_WrEn ,
		RF_WrDatasel => PROC_RF_WrDataSel ,
		RF_B_sel =>PROC_RF_BSel ,
		ImmExt =>PROC_ImmExt ,
		ALUSrcA =>PROC_Alu_SrcA ,
		ALUSrcB => PROC_Alu_SrcB ,
		ALU_func =>PROC_ALU_Func ,
		Mem_WrEn =>PROC_MemWrEn ,
		Byte_Op => PROC_ByteOp ,
		InstructWr => PROC_InstrWr,
		AWr => PROC_Awr,
		BWr =>PROC_Bwr ,
		MEMWr => PROC_MemWr ,
		ALUWr => PROC_AluWr
	);
	
	
end Behavioral;

