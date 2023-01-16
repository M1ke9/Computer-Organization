--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:32:19 04/11/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle1/PROC_SC_TB.vhd
-- Project Name:  SingleCycle1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROC_SC
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
 
ENTITY PROC_SC_TB IS
END PROC_SC_TB;
 
ARCHITECTURE behavior OF PROC_SC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_SC
    PORT(
         PC_LDEN : in  std_logic;
         CLK : in  std_logic;
         RST : in  std_logic;
         ZERO : out  std_logic;
         OVF : out std_logic;
         COUT : out  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal PC_LDEN : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal ZERO : std_logic;
   signal OVF : std_logic;
   signal COUT : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_SC PORT MAP (
          PC_LDEN => PC_LDEN,
          CLK => CLK,
          RST => RST,
          ZERO => ZERO,
          OVF => OVF,
          COUT => COUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		wait for 50 ns;
		
		RST <= '1';

		
      wait for 50 ns;	


     RST <= '0';
    PC_LDEN <= '1';
 

      -- insert stimulus here 

      wait;
   end process;

END;
