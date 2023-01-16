--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:31:39 04/11/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle1/CONTROL_TB.vhd
-- Project Name:  SingleCycle1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_TB IS
END CONTROL_TB;
 
ARCHITECTURE behavior OF CONTROL_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         PC_Sel : OUT  std_logic;
         RF_WrEN : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel1 : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         ALU_Bin_sel1 : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_WrEN : OUT  std_logic;
         ByteOP : OUT  std_logic;
         Instruction : IN  std_logic_vector(31 downto 0);
         BBFlag : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal BBFlag : std_logic := '0';

 	--Outputs
   signal PC_Sel : std_logic;
   signal RF_WrEN : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel1 : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal ALU_Bin_sel1 : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_WrEN : std_logic;
   signal ByteOP : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          PC_Sel => PC_Sel,
          RF_WrEN => RF_WrEN,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel1 => RF_B_sel1,
          ImmExt => ImmExt,
          ALU_Bin_sel1 => ALU_Bin_sel1,
          ALU_func => ALU_func,
          Mem_WrEN => Mem_WrEN,
          ByteOP => ByteOP,
          Instruction => Instruction,
          BBFlag => BBFlag
        );

   -- Clock process definitions
 
   
 

   -- Stimulus process
   stim_proc: process
   begin	
	
	wait for 100 ns;
--R type
    Instruction <="10000011001000100000000000000000";
	 BBFlag<='X';
    
	 wait for 100 ns;
	 
	 --add i
	  Instruction <="11000000000100000000000000000000";
	  BBFlag<='X';
	  
	  wait for 100ns;
	  
	  --bne
	  Instruction <="00000111001000100000000000000000";
	   BBFlag<='0';
	  
	 
	 
    

    

      wait;
   end process;

END;
