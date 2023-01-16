--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:42:26 04/08/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle1/DATAPATH_TB.vhd
-- Project Name:  SingleCycle1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_Sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         RF_WrEN : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel1 : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         ALU_Bin_sel1 : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         OverFlow : OUT  std_logic;
         Cout : OUT  std_logic;
         Zero : OUT  std_logic;
         ByteOP : IN  std_logic;
         Mem_WrEN : IN  std_logic;
			Instruction:OUT STD_LOGIC_VECTOR(31 downto 0);
			BBFLAG:OUT STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
   signal RF_WrEN : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel1 : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal ALU_Bin_sel1 : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ByteOP : std_logic := '0';
   signal Mem_WrEN : std_logic := '0';

 	--Outputs
   signal OverFlow : std_logic;
   signal Cout : std_logic;
   signal Zero : std_logic;
	signal Instruction:std_logic_vector(31 downto 0);
	signal BBFLAG:std_logic;

   -- Clock period definitions
   constant Clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_Sel => PC_Sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          RF_WrEN => RF_WrEN,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel1 => RF_B_sel1,
          ImmExt => ImmExt,
          ALU_Bin_sel1 => ALU_Bin_sel1,
          ALU_func => ALU_func,
          OverFlow => OverFlow,
          Cout => Cout,
          Zero => Zero,
          ByteOP => ByteOP,
          Mem_WrEN => Mem_WrEN,
			 Instruction => Instruction,
			 BBFLAG => BBFLAG
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		 Reset <='1';
		 
      wait for  Clk_period;	

      -- insert stimulus here 
		
		--addi
		 PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '1';
       RF_WrData_sel <= '0';
       RF_B_sel1 <= '1';
       ImmExt <= "00";
       ALU_Bin_sel1 <= '1';
       ALU_func <="0000";
       ByteOP <= 'X';
       Mem_WrEN <= '0';
		 
		
	
	wait for  Clk_period;
	--ori
	
	    PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '1';
       RF_WrData_sel <= '0';
       RF_B_sel1 <= '1';
       ImmExt <= "01";
       ALU_Bin_sel1 <= '1';
       ALU_func <="0011";
       ByteOP <= 'X';
       Mem_WrEN <= '0';
		 
	
	wait for Clk_period;
	
	--sw
	    PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '0';
       RF_WrData_sel <= 'X';
       RF_B_sel1 <= '1';
       ImmExt <= "00";
       ALU_Bin_sel1 <= '1';
       ALU_func <="0000";
       ByteOP <= '0';
       Mem_WrEN <= '1';
		 
	
	wait for Clk_period;
	
	--lw
	
	    PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '1';
       RF_WrData_sel <= '1';
       RF_B_sel1 <= '1';
       ImmExt <= "00";
       ALU_Bin_sel1 <= '1';
       ALU_func <="0000";
       ByteOP <= '0';
       Mem_WrEN <= '0';
		 
	
	wait for Clk_period;
	
	--lb
	
	    PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '1';
       RF_WrData_sel <= '1';
       RF_B_sel1 <= '1';
       ImmExt <= "00";
       ALU_Bin_sel1 <= '1';
       ALU_func <="0000";
       ByteOP <= '1';
       Mem_WrEN <= '0';
		 
	
	wait for Clk_period;
	
	
	--nand
	
	    PC_Sel <='0';
       PC_LdEn <= '1';
       Reset <='0';
       RF_WrEN <= '1';
       RF_WrData_sel <= '0';
       RF_B_sel1 <= '0';
       ImmExt <= "XX";
       ALU_Bin_sel1 <= '0';
       ALU_func <="0101";
       Mem_WrEN <= '0';
		 
	
	wait for Clk_period;
	
	
	
	
	
	
	

	

	 
	

	

      wait;
   end process;

END;
