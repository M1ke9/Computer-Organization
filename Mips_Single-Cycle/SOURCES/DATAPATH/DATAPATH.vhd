
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

entity DATAPATH is
    Port ( PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
			  RF_WrEN:in STD_LOGIC;
			  RF_WrData_sel:in STD_LOGIC;
			  RF_B_sel1: in STD_LOGIC;
			  ImmExt:in STD_LOGIC_VECTOR(1 downto 0);
			  ALU_Bin_sel1:in STD_LOGIC;
			  ALU_func : in STD_LOGIC_VECTOR(3 downto 0);
			  OverFlow:out STD_LOGIC;
			  Cout:out STD_LOGIC;
			  Zero:out STD_LOGIC;
			  ByteOP:in STD_LOGIC;
			  Mem_WrEN:in STD_LOGIC;
			  Instruction:out STD_LOGIC_VECTOR(31 downto 0);
			  BBFLAG:out std_logic
			  );
end DATAPATH;

architecture Behavioral of DATAPATH is

signal Instruct:std_logic_vector(31 downto 0);
signal ImmeD:std_logic_vector(31 downto 0);
signal Rf_A:std_logic_vector(31 downto 0);
signal Rf_B:std_logic_vector(31 downto 0);
signal ALU_OUT: std_logic_vector(31 downto 0);
signal MEM_Dout:std_logic_vector(31 downto 0);
signal RF_AA:std_logic_vector(31 downto 0);
signal RF_BB: std_logic_vector(31 downto 0);


COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_Sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		Clk : IN std_logic;          
		Instr : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
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
	
	
	COMPONENT EXSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		ALU_ovf : OUT std_logic;
		ALU_cout : OUT std_logic
		);
	END COMPONENT;
	
	
	COMPONENT MEMSTAGE
	PORT(
		clk : IN std_logic;
		ByteOp : IN std_logic;
		Mem_WrEn : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);          
		MEM_DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	

	

begin


 Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed =>ImmeD ,
		PC_Sel =>PC_Sel ,
		PC_LdEn =>PC_LdEn ,
		Reset =>Reset ,
		Clk =>Clk ,
		Instr =>Instruct
	);
	
	
	
	Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr =>Instruct ,
		RF_WrEn =>RF_WrEN ,
		ALU_out =>ALU_OUT ,
		MEM_out =>MEM_Dout ,
		RF_WrData_sel =>RF_WrData_sel ,
		RF_B_sel => RF_B_sel1 ,
		ImmExt => ImmExt ,
		Clk =>Clk ,
		Immed =>ImmeD ,
		RF_A =>Rf_A ,
		RF_B =>Rf_B ,
		RST =>Reset 
	);
	
	
	Inst_EXSTAGE: EXSTAGE PORT MAP(
		RF_A => Rf_A,
		RF_B => Rf_B,
		Immed =>ImmeD ,
		ALU_Bin_sel => ALU_Bin_sel1 ,
		ALU_func => ALU_func ,
		ALU_out => ALU_OUT,
		ALU_zero =>Zero ,
		ALU_ovf =>OverFlow ,
		ALU_cout =>Cout
	);


	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		clk =>Clk ,
		ByteOp => ByteOP ,
		Mem_WrEn =>Mem_WrEN ,
		ALU_MEM_Addr =>ALU_OUT ,
		MEM_DataIn =>Rf_B ,
		MEM_DataOut =>MEM_Dout
	);
	
	
	Instruction<=instruct;
	
	process(RF_AA,RF_BB)
	begin
	if(RF_AA = Rf_BB) then
       BBFLAG <='1';
	else
	BBFLAG <='0';
	end if;
end process;

RF_AA<=Rf_A;
   RF_BB<=Rf_B;


	

end Behavioral;