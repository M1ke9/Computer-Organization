--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:30:04 04/03/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle/myRegister_TEST.vhd
-- Project Name:  SingleCycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: myRegister
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
 
ENTITY myRegister_TEST IS
END myRegister_TEST;
 
ARCHITECTURE behavior OF myRegister_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT myRegister
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         WE : IN  std_logic;
         Dataout : OUT  std_logic_vector(31 downto 0);
         Datain : IN  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: myRegister PORT MAP (
          RST => RST,
          CLK => CLK,
          WE => WE,
          Dataout => Dataout,
          Datain => Datain
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

RST<='1';
	
      -- hold reset state for 100 ns.
      wait for 100 ns;


RST<='0';
WE<='1';
Datain<="00011011111100000111110000011111";		
wait for 100 ns;


RST<='0';
WE<='0';
Datain<="01100110000000000111110000011111";		
wait for 100 ns;


RST<='1';
WE<='0';
Datain<="11111011111100000111110000000001";		
wait for 100 ns;
	

      -- insert stimulus here 

      wait;
   end process;

END;
