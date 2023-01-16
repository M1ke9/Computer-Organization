----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:46:31 04/04/2021 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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


use work.MyPackage.all;

entity RF is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);
           WrEn : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end RF;

architecture Behavioral of RF is

component myRegister
Port(  RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           WE : in  STD_LOGIC;
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0);
           Datain : in  STD_LOGIC_VECTOR (31 downto 0));
			  
end component;



component Decoder
Port ( DecIn : in  STD_LOGIC_VECTOR (4 downto 0);
       DecOut : out  STD_LOGIC_VECTOR (31 downto 0));
		 
end component;



component Mux
port(
       MuxIn: in MadeType;
		 ard  : in std_logic_vector(4 downto 0);
	    MuxOut : out std_logic_vector(31 downto 0));
		 
end component;

signal decout: std_logic_vector(31 downto 0);
signal RegOUT: MadeType;
signal AndOut0: std_logic_vector(31 downto 0);
signal AndOut1:std_logic_vector(31 downto 0);






begin
--Decoder port map
  DEC: Decoder port map(
     DecIn=>Awr,
	  DecOut=>decout
	  );
	  
--AND gates
   x2: for i in 0 to 31 generate
       AndOut0(i)<=decout(i) and WrEn;
	    end generate;
	
  AndOut1<=AndOut0 after 2 ns;
  
--Register 0 port map
   REG0: myRegister port map(
	      Datain => (others=> '0'),
			CLK => Clk,
			WE => '0',
			RST => Rst,
			Dataout => RegOUT(0) );
			
--Registers 1-31

REG1_31: for i in 1 to 31 generate
        REG: myRegister port map(
		  Datain => Din,
		  CLK => Clk,
		  WE =>AndOut1(i),
        RST => Rst,
        Dataout => RegOUT(i) );
		  
		  end generate;
		  
--Mux 1

   mux1: MUX port map(
	
        MuxIn=> RegOUT,
        ard=> Ard1,
		  MuxOut=> Dout1
		  );

--Mux 2
     
	mux2: MUX port map(
	    
		   MuxIn => RegOUT,
			ard => Ard2,
			MuxOut => Dout2
			);
			
end Behavioral;

