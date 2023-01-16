--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:53:55 04/04/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle/RF_TEST.vhd
-- Project Name:  SingleCycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY RF_TEST IS
END RF_TEST;
 
ARCHITECTURE behavior OF RF_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst
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
	
	 Din<="00000000011111000000111110000011";
    Rst<='1';
    Ard1<="00000";
    Ard2<="00001"; 
    Awr<="00011";
    WrEn<='1';
   
	 
	 wait for Clk_period;
	  
	 Din<="00000000011111000000111110000011";
	 Rst<='0';
    Ard1<="00000";
    Ard2<="00001"; 
    Awr<="00011";
    WrEn<='1';
    

	wait for Clk_period;
	 
	 
	 Din<="11100110011111010000111110000011";
	 Rst<='0';
    Ard1<="11000";
    Ard2<="00001"; 
    Awr<="00001";
    WrEn<='1';
    
	 
	wait for Clk_period;
	 
	 Din<="00111000011111000001101110000000";
	 Rst<='0';
    Ard1<="00011";
    Ard2<="00001"; 
    Awr<="00111";
    WrEn<='0';

	 
	wait for Clk_period;
	 
	 Din<="11110000011111000010111110000011";
	 Rst<='0';
    Ard1<="00011";
    Ard2<="00111"; 
    Awr<="01111";
    WrEn<='1';
    
	 
	 wait for 100 ns;	

	 
	 Din<="11110000011111000010111110000011";
	 Rst<='0';
    Ard1<="00011";
    Ard2<="01111"; 
    Awr<="00011";
    WrEn<='0';
    
	 wait for 100 ns;
	 wait;
	    end process;

END;
