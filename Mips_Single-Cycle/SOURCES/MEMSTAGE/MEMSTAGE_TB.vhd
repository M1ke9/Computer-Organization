--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:10:17 04/07/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle1/MEMSTAGE_TB.vhd
-- Project Name:  SingleCycle1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
 
  ARCHITECTURE behavior OF MEMSTAGE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         clk : IN  std_logic;
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          clk => clk,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     

      -- insert stimulus here 
		
--sw in position 1024	
    ByteOp <='0';
    Mem_WrEn <= '1';
   ALU_MEM_Addr <="00000000000000000000000000000000";
   MEM_DataIn <= "11100000000000000000000000000010";	
   wait for 50 ns;
	
	
--lw from 1024	
	ByteOp <='0';
    Mem_WrEn <= '0';
   ALU_MEM_Addr <="00000000000000000000000000000000";	
   wait for 50 ns;
	
	
--sw in position 1024+8=1026	
	ByteOp <='0';
    Mem_WrEn <= '1';
   ALU_MEM_Addr <="00000000000000000000000000001000";	
	MEM_DataIn <= "00000011111000000000011000011111";	
   wait for 50 ns;
	
	
	
--sb in position 1024+32=1032
	 ByteOp <='1';
    Mem_WrEn <= '1';
   ALU_MEM_Addr <="00000000000000000000000000100000";	
   MEM_DataIn <= "00000000000111100000000000101000";	
   wait for 50 ns;
	
	
--lb from 1032

    ByteOp <='1';
    Mem_WrEn <= '0';
   ALU_MEM_Addr <="00000000000000000000000000100000";	
   wait for 50 ns;
	
--lb from 1026
	 ByteOp <='1';
    Mem_WrEn <= '0';
   ALU_MEM_Addr <="00000000000000000000000000001000";	
   wait for 50 ns;

	
	
	
	
	
	
	
	
		

      wait;
   end process;

END;
