----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:34:12 04/06/2021 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0)
			  );
           
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

signal Data_Addr:std_logic_vector(31 downto 0);
signal Data_Addr1:std_logic_vector(10 downto 0);
signal Data_Addr2:std_logic_vector(10 downto 0);
signal En:std_logic;
signal WrData:std_logic_vector(31 downto 0);
signal RdData:std_logic_vector(31 downto 0);

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


begin

process(Data_Addr)
begin

Data_Addr1<=Data_Addr(12 downto 2);

end process;

process(Data_Addr1)
begin
Data_Addr2<=std_logic_vector(unsigned(Data_Addr1) +1024);

end process;



Inst_RAM: RAM PORT MAP(
		clk => clk ,
		inst_addr => (others=>'0') ,
		inst_dout =>open ,
		data_we => En ,
		data_addr =>Data_Addr2 ,
		data_din =>WrData ,
		data_dout =>RdData
		);
	
	
	
	
	Inst_MEM: MEM PORT MAP(
		ByteOp1 =>ByteOp ,
		Mem_WrEn1 =>Mem_WrEn ,
		ALU_MEM_addr1 =>ALU_MEM_Addr ,
		MEM_DataIn1 =>MEM_DataIn ,
		MEM_DataOut1 =>MEM_DataOut,
		MM_Addr1 => Data_Addr,
		MM_WrEn1 =>En ,
		MM_WrData1 =>WrData ,
		MM_RdData1 =>RdData 
	);
	
	

end Behavioral;

