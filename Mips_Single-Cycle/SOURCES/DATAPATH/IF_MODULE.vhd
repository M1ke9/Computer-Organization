----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:52:31 04/05/2021 
-- Design Name: 
-- Module Name:    IF_MODULE - Behavioral 
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

entity IF_MODULE is
    Port ( pc_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_sel : in  STD_LOGIC;
           pc_LdEn : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_MODULE;

architecture Behavioral of IF_MODULE is


signal Adder4Out: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal PcOut: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal ImmedOut:STD_LOGIC_VECTOR(31 DOWNTO 0);
signal PcIn:STD_LOGIC_VECTOR(31 DOWNTO 0);

COMPONENT myRegister
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


COMPONENT Adder4
	PORT(
		AdderIn4 : IN std_logic_vector(31 downto 0);          
		AdderOut4 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


COMPONENT AdderImmed
	PORT(
		Immed : IN std_logic_vector(31 downto 0);
		PC_4 : IN std_logic_vector(31 downto 0);          
		PC_Immed_4 : OUT std_logic_vector(31 downto 0)
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

	

begin

process(PcOut) begin

	PC<=PcOut;
	
end process;

Inst_myRegister: myRegister PORT MAP(
		RST => reset ,
		CLK => clk,
		WE =>pc_LdEn ,
		Dataout => PcOut ,
		Datain => PcIn
	);
	
	

Inst_Adder4: Adder4 PORT MAP(
		AdderIn4 => PcOut,
		AdderOut4 =>Adder4Out
	);


Inst_AdderImmed: AdderImmed PORT MAP(
		Immed => pc_Immed ,
		PC_4 =>Adder4Out ,
		PC_Immed_4 =>ImmedOut
	);

Inst_MUX2x1: MUX2x1 PORT MAP(
		MuxIn1 => Adder4Out,
		MuxIn2 =>ImmedOut ,
		MuxOut =>PcIn ,
		Sel => pc_Sel
	);
end Behavioral;

