----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:45:15 04/05/2021 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

signal PC_OUT: std_logic_vector(31 downto 0);
signal MemoryIn:std_logic_vector(10 downto 0);

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
	
	
	COMPONENT IF_MODULE
	PORT(
		pc_Immed : IN std_logic_vector(31 downto 0);
		pc_sel : IN std_logic;
		pc_LdEn : IN std_logic;
		reset : IN std_logic;
		clk : IN std_logic;          
		PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	



begin

Inst_RAM: RAM PORT MAP(
		clk => Clk ,
		inst_addr => MemoryIn,
		inst_dout =>Instr ,
		data_we => '0' ,
		data_addr => (OTHERS => '0') ,
		data_din => (OTHERS => '0') ,
		data_dout => open
	);
	
	
	Inst_IF_MODULE: IF_MODULE PORT MAP(
		pc_Immed => PC_Immed ,
		pc_sel => PC_sel ,
		pc_LdEn => PC_LdEn ,
		reset => Reset ,
		clk => Clk,
		PC =>PC_OUT
	);
	
	process(PC_OUT)
	begin
	
	MemoryIn<=PC_OUT(12 downto 2);
	
	end process;



end Behavioral;

