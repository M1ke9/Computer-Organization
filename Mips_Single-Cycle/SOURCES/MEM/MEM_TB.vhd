--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:39:14 04/06/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle1/MEM_TB.vhd
-- Project Name:  SingleCycle1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEM_TB IS
END MEM_TB;
 
ARCHITECTURE behavior OF MEM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM
    PORT(
         ByteOp1 : IN  std_logic;
         Mem_WrEn1 : IN  std_logic;
         ALU_MEM_addr1 : IN  std_logic_vector(31 downto 0);
         MEM_DataIn1 : IN  std_logic_vector(31 downto 0);
         MEM_DataOut1 : OUT  std_logic_vector(31 downto 0);
         MM_Addr1 : OUT  std_logic_vector(31 downto 0);
         MM_WrEn1 : OUT  std_logic;
         MM_WrData1 : OUT  std_logic_vector(31 downto 0);
         MM_RdData1 : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ByteOp1 : std_logic := '0';
   signal Mem_WrEn1 : std_logic := '0';
   signal ALU_MEM_addr1 : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn1 : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData1 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut1 : std_logic_vector(31 downto 0);
   signal MM_Addr1 : std_logic_vector(31 downto 0);
   signal MM_WrEn1 : std_logic;
   signal MM_WrData1 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM PORT MAP (
          ByteOp1 => ByteOp1,
          Mem_WrEn1 => Mem_WrEn1,
          ALU_MEM_addr1 => ALU_MEM_addr1,
          MEM_DataIn1 => MEM_DataIn1,
          MEM_DataOut1 => MEM_DataOut1,
          MM_Addr1 => MM_Addr1,
          MM_WrEn1 => MM_WrEn1,
          MM_WrData1 => MM_WrData1,
          MM_RdData1 => MM_RdData1
        );

   -- Clock process definitions
 -- <clock>_process :
  process
   begin
	
	wait for 100 ns;
	
	
	 ByteOp1 <='0';
    Mem_WrEn1 <='0';
    ALU_MEM_addr1 <="00000000000000000000000001111100";
    MM_RdData1 <= "00000000001111100011000001111100" ;

   wait for 100 ns;
	
	
	
	 ByteOp1 <='0';
    Mem_WrEn1 <='1';
    ALU_MEM_addr1 <="11111000000000000000000001111100";
    MEM_DataIn1 <= "11111000001111100000000001111100";
    MM_RdData1 <= "00000000001111100011000001111100" ;

   wait for 100 ns;

      wait;
   end process;

END;
