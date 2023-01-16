----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:22 04/03/2021 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           ALUOut : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is


signal temp: std_logic_vector(32 downto 0);
signal ALUOut0: std_logic_vector(31 downto 0);
signal cout0: std_logic;
signal ovf0: std_logic;
signal zero0: std_logic;


begin

process(A,B,Op,temp)
begin

case op is

when "0000" =>
     temp <=std_logic_vector(('0' & signed(A)) + ('0' & signed(B)));
     ALUOut0<=temp(31 downto 0);
     cout0<=temp(32);

      if A(31)= '0' and B(31)='0' and temp(31) ='1' then 
				ovf0 <= '1';
		elsif A(31)= '1' and B(31)='1' and temp(31) ='0' then
				ovf0 <= '1';
		else 
				ovf0 <= '0';
		end if;


when "0001" => 
		temp <=std_logic_vector(('0' & signed(A)) - ('0' & signed(B)));
		ALUOut0 <= temp(31 downto 0);
		cout0 <= temp(32);
		

		if A(31)= '0' and B(31)='1' and temp(31) ='1' then 
				ovf0 <= '1';
		elsif A(31)= '1' and B(31)='0' and temp(31) ='0' then
				ovf0 <= '1';
		else 
				ovf0 <= '0';
		end if;
		
when "0010" => 
		ALUOut0 <= std_logic_vector(signed(A) AND signed(B));
		cout0 <= '0';
		ovf0 <= '0';
		
when "0011" => 
		ALUOut0 <= std_logic_vector(signed(A) OR signed(B));
		cout0 <= '0';
		ovf0 <= '0';
		
when "0100" =>
		ALUOut0 <= std_logic_vector(NOT(signed(A)));
		cout0 <= '0';
		ovf0 <= '0';
		
when "0101" => 
		ALUOut0 <= std_logic_vector(signed(A) NAND signed(B));
		cout0 <= '0';
		ovf0 <= '0';
		
when "0110" => 
		ALUOut0 <=std_logic_vector(signed(A) NOR signed(B));
		cout0 <= '0';
		ovf0 <= '0';
		
when "1000" =>
		ALUOut0 <= std_logic_vector(shift_right(signed(A),1));
		cout0 <= '0';
		ovf0 <= '0';
		
when "1001" =>
		ALUOut0<= std_logic_vector(shift_right(unsigned(A),1));
		cout0 <= '0';
		ovf0 <= '0';
		
when "1010" => 
		ALUOut0 <= std_logic_vector(shift_left(unsigned(A),1));
		cout0 <= '0';
		ovf0 <= '0';
		
when "1100" =>
		ALUOut0 <= std_logic_vector(rotate_left(unsigned(A),1));
		cout0 <= '0';
		ovf0 <= '0';
when "1101" => 
		ALUOut0 <= std_logic_vector(rotate_right(unsigned(A),1));
		cout0 <= '0';
		ovf0 <= '0';
when others => 
		ALUOut0 <= (others => '0');
		cout0 <= '0';
		ovf0 <= '0';
end case;

if temp = "000000000000000000000000000000000" then 
		zero0 <= '1' ;
else 
		zero0 <= '0';
end if;
end process;


ALUOut<= ALUOut0 after 10 ns;
ovf<= ovf0;
cout<=cout0;
zero<=zero0;




end Behavioral;

