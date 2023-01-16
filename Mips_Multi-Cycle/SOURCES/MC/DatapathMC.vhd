----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:14:08 05/08/2021 
-- Design Name: 
-- Module Name:    DatapathMC - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DatapathMC is
Port (   
	        Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  
	         --PC
	        PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
			  
           
			    --DECSTAGE
			  RF_WrEN:in STD_LOGIC;
			  RF_WrData_sel:in STD_LOGIC;
			  RF_B_sel1: in STD_LOGIC;
			  ImmExt:in STD_LOGIC_VECTOR(1 downto 0);
			  
			  --EXSTAGE
			  ALU_SrcA:in STD_LOGIC;
			  ALU_SrcB:in STD_LOGIC_VECTOR(1 downto 0);
			  ALU_func : in STD_LOGIC_VECTOR(3 downto 0);
			  OverFlow:out STD_LOGIC;
			  Cout:out STD_LOGIC;
	
			  
			  --MEM
			  ByteOP:in STD_LOGIC;
			  Mem_WrEN:in STD_LOGIC;
			  
			  
			    --CONTROL
			  Instruction:out STD_LOGIC_VECTOR(31 downto 0);
			  BBFLAG:out std_logic;
			  
			   --REGISTERS Write Enable
			  InstructWr : in STD_LOGIC;
			  AWr : in STD_LOGIC;
			  BWr : in STD_LOGIC;
			  MEMWr : in STD_LOGIC;
			  ALUWr : in STD_LOGIC
			 
			  );
end DatapathMC;

architecture Behavioral of DatapathMC is


signal PC_MuxOut:std_logic_vector(31 downto 0);
signal ALU_regOut:std_logic_vector(31 downto 0);
signal A_MUX_OUT:std_logic_vector(31 downto 0);
signal PC_OUT : std_logic_vector (31 downto 0);
signal A_regIn : std_logic_vector(31 downto 0);
signal B_regIn : std_logic_vector(31 downto 0);
signal A_regOut: std_logic_vector(31 downto 0);
signal B_regOut:std_logic_vector(31 downto 0);
signal ImmeD:std_logic_vector(31 downto 0);
signal ALU_OUT: std_logic_vector(31 downto 0);
signal InstructIN:std_logic_vector(31 downto 0);
signal InstructOut:std_logic_vector(31 downto 0);
signal MEM_RegOut : std_logic_vector(31 downto 0);
signal MEM_RegIn:std_logic_vector(31 downto 0);
signal MM_adr : std_logic_vector(31 downto 0);
signal MM_Adr1:std_logic_vector(10 downto 0);
signal MM_Adr11:std_logic_vector(10 downto 0);
signal MM_WrEn:std_logic;
signal MEM_WRdata:std_logic_vector(31 downto 0);
signal MEM_RDdata:std_logic_vector(31 downto 0);

	

COMPONENT DECSTAGE
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		Clk : IN std_logic;
		RST : IN std_logic;          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;



	COMPONENT ExstageMC
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_SelB : IN std_logic_vector(1 downto 0);
		ALU_Func : IN std_logic_vector(3 downto 0);          
		ALU_Out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		ALU_ovf : OUT std_logic;
		ALU_cout : OUT std_logic
		);
	END COMPONENT;


	
COMPONENT MEM
	PORT(
		ByteOp1 : IN std_logic;
		Mem_WrEn1 : IN std_logic;
		ALU_MEM_addr1 : IN std_logic_vector(31 downto 0);
		MEM_DataIn1 : IN std_logic_vector(31 downto 0);
		MM_RdData1 : IN std_logic_vector(31 downto 0);          
		MEM_DataOut1 : OUT std_logic_vector(31 downto 0);
		MM_Addr1 : OUT std_logic_vector(31 downto 0);
		MM_WrEn1 : OUT std_logic;
		MM_WrData1 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT RAM
	PORT(
		clk : IN std_logic;
		inst_addr : IN std_logic_vector(10 downto 0);
		data_we : IN std_logic;
		data_addr : IN std_logic_vector(10 downto 0);
		data_din : IN std_logic_vector(31 downto 0);          
		inst_dout : OUT std_logic_vector(31 downto 0);
		data_dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


COMPONENT MUX2x1
	PORT(
		MuxIn1 : IN std_logic_vector(31 downto 0);
		MuxIn2 : IN std_logic_vector(31 downto 0);
		Sel : IN std_logic;          
		MuxOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
COMPONENT myRegister
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	
begin


	--PC REGISTER
	 PC_REG: myRegister PORT MAP(
	 RST =>Reset ,
	 CLK =>Clk ,
	 WE =>PC_LdEn ,
	 Dataout =>PC_OUT ,
	 Datain =>ALU_OUT
	   );
		
		--PC MUX
		PC_MUX: MUX2x1 PORT MAP(
		MuxIn1 =>PC_OUT ,
		MuxIn2 =>ALU_regOut ,
		MuxOut =>PC_MuxOut ,
		Sel =>PC_Sel
	);
	
	
	
	Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr =>InstructOut ,
		RF_WrEn => RF_WrEN ,
		ALU_out => ALU_regOut   ,
		MEM_out =>MEM_RegOut ,
		RF_WrData_sel => RF_WrData_sel,
		RF_B_sel => RF_B_sel1,
		ImmExt => ImmExt ,
		Clk =>Clk ,
		Immed =>ImmeD ,
		RF_A =>A_regIn ,
		RF_B =>B_regIn ,
		RST =>Reset 
	);
	
	
	
	Inst_ExstageMC: ExstageMC PORT MAP(
		RF_A =>A_MUX_OUT  ,
		RF_B =>B_regOut ,
		Immed =>ImmeD ,
		ALU_Bin_SelB =>ALU_SrcB ,
		ALU_Func =>ALU_func ,
		ALU_Out =>ALU_OUT ,
		ALU_zero =>BBFLAG ,
		ALU_ovf =>OverFlow ,
		ALU_cout =>Cout
	);
	
	
	
	MUX_EX: MUX2x1 PORT MAP(
		MuxIn1 =>PC_OUT ,
		MuxIn2 =>A_regOut ,
		MuxOut =>A_MUX_OUT ,
		Sel => ALU_SrcA
	);
	

	
	
	Inst_MEM: MEM PORT MAP(
		ByteOp1 =>ByteOP ,
		Mem_WrEn1 =>Mem_WrEN ,
		ALU_MEM_addr1 =>ALU_regOut ,
		MEM_DataIn1 =>B_regOut ,
		MEM_DataOut1 =>MEM_RegIn ,
		MM_Addr1 =>MM_adr ,
		MM_WrEn1 =>MM_WrEn ,
		MM_WrData1 =>MEM_WRdata ,
		MM_RdData1 =>MEM_RDdata 
	);
	
	
	
	Inst_RAM: RAM PORT MAP(
		clk =>Clk ,
		inst_addr =>PC_MuxOut (12 downto 2) ,
		inst_dout =>InstructIN  ,
		data_we =>MM_WrEn ,
		data_addr =>MM_Adr11 ,
		data_din =>MEM_WRdata ,
		data_dout =>MEM_RDdata 
	);
	
	
	--Register-->Instruction 
	 Instruct_REG: myRegister PORT MAP(
	 RST =>Reset ,
	 CLK =>Clk ,
	 WE =>InstructWr ,
	 Dataout =>InstructOut ,
	 Datain =>InstructIN 
	   );
    
        --REGISTER -->A
   R_A: myRegister PORT MAP(
	 RST =>Reset,
	 CLK =>Clk ,
	 WE => AWr ,
	 Dataout =>A_regOUt ,
	 Datain =>A_regIn 
	   );
		
		--REGISTER-->B
	R_B: myRegister PORT MAP(
	 RST =>Reset,
	 CLK =>Clk ,
	 WE =>BWr,
	 Dataout =>B_regOut ,
	 Datain => B_regIn
	   );
		
		
		--REGISTER-->ALU
		R_ALU: myRegister PORT MAP(
	 RST =>Reset,
	 CLK =>Clk ,
	 WE =>ALUWr,
	 Dataout =>ALU_regOut ,
	 Datain => ALU_OUT
	   );
		
		
		--REGISTER-->MEM
		
		R_MEM: myRegister PORT MAP(
	 RST =>Reset,
	 CLK =>Clk ,
	 WE =>MEMWr,
	 Dataout =>Mem_RegOut,
	 Datain =>MEM_RegIn
	   );
		
		
MM_Adr1 <= std_logic_vector(MM_adr(12 downto 2));
MM_Adr11 <= std_logic_vector( unsigned(MM_Adr1) + 1024);   

Instruction<=InstructOut;
	
    	
end Behavioral;

