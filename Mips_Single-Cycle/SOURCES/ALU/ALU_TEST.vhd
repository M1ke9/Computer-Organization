--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:02:24 04/03/2021
-- Design Name:   
-- Module Name:   C:/organwsh/SingleCycle/ALU_TEST.vhd
-- Project Name:  SingleCycle
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALU_TEST IS
END ALU_TEST;
 
ARCHITECTURE behavior OF ALU_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         ALUOut : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALUOut : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          ALUOut => ALUOut,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

  
   -- Stimulus process
   stim_proc: process
   begin	

 	--Zero  
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		op<="0000";
		wait for 50 ns;	
		
		
		--add  
		A<="00000000000000000000000001111111";
		B<="00000000000000000000000001111111";
		Op<="0000";
		wait for 50 ns;
		
		
			--add ,Ovf,Cout
		A<="10100000000001111100000000000011";
		B<="10000000000000000000000000000000";
		Op<="0000";
		wait for 50 ns;
		
	
		
			--add,Cout 
		A<="11111111111111111111111111111111";
		B<="11111111111111111111111111111111";
		Op<="0000";
		wait for 50 ns;
		
			--sub  
		A<="00000000000000000000000000000011";
		B<="00000000000000000000000000000001";
		Op<="0001";
		wait for 50 ns;
      
		
		--sub ,Ovf,Cout
		A<="01111111111111111111111111111111";
		B<="11111111111111111111111111111111";
		Op<="0001";
		wait for 50 ns;
		
		
		--sub ,Cout
		A<="00000000000000000000000000000000";
		B<="01111111111111111111111111111111";
		Op<="0001";
		wait for 50 ns;
		
		
		--AND
		A<="11111111110000001111111111111111";
		B<="11100010011011101100001110000101";
		Op<="0010";
		wait for 50 ns;
		
		--OR
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		Op<="0011";
		wait for 50 ns;
		
			--NOT A
		A<="01111000110101000000011100010011";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="0100";
		wait for 50 ns;
		
			--NAND
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		Op<="0101";
		wait for 50 ns;
		
		
		--NOR
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		Op<="0110";
		wait for 50 ns;
  
       -- Shift right arithmetic MSB 1 A
		A<="11111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1000";
		wait for 50 ns;
		
		
		-- Shift right arithmetic MSB 0 A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1000";
		wait for 50 ns;
		
		
		-- Shift right logical A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1001";
		wait for 50 ns;
		
			-- Shift left logical A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1010";
		wait for 50 ns;
		
		--Rotate left A
		A<="01111000110101000000011100010011";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1100";
		wait for 50 ns;
		
		--Rotate right A
		A<="11111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		Op<="1101";
		wait for 50 ns;
		
		
      wait;
   end process;

END;
