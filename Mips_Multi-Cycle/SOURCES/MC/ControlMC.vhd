----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:39 05/11/2021 
-- Design Name: 
-- Module Name:    ControlMC - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlMC is

PORT  (    CLK:in std_logic;
			  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in  STD_LOGIC;
			  BBFLAG : in STD_LOGIC;
           PC_sel : out  STD_LOGIC;
			  PC_LdEn : out STD_LOGIC;
			  RF_WrEn : out  STD_LOGIC;
           RF_WrDatasel : out  STD_LOGIC;
           RF_B_sel :out  STD_LOGIC;
			  ImmExt:out STD_LOGIC_VECTOR(1 downto 0);
           ALUSrcA: out  STD_LOGIC;
			  ALUSrcB: out  STD_LOGIC_VECTOR(1 downto 0);
           ALU_func : out STD_LOGIC_VECTOR(3 downto 0);
           Mem_WrEn : out  STD_LOGIC;
			  Byte_Op : out STD_LOGIC;
			  InstructWr : out STD_LOGIC;
			  AWr : out STD_LOGIC;
			  BWr : out STD_LOGIC;
			  MEMWr : out STD_LOGIC;
			  ALUWr : out STD_LOGIC
			  );
       
end ControlMC;

 architecture Behavioral of ControlMC is

		type TypeState IS (Start, Start1, Rtype, Rtype1, Rtype2,LI, LUI, ADDI, NANDI, ORI, ITYPE1, ITYPE2,
		Load, Load1, Load2, Load3, Store, Store1, Store2,B,Beq, Beq1,Beq2,Beq3, Bne, Bne1,Bne2,Bne3,BBFlagState);
							
		SIGNAL State1, State2: TypeState;
			

signal OPCODE : STD_LOGIC_VECTOR(5 downto 0);	
signal FUNC : STD_LOGIC_VECTOR(3 downto 0);	
		
begin
OPCODE <= Instruction(31 downto 26);
FUNC <= Instruction(3 downto 0);

   process(OPCODE) begin
	
if (OPCODE = "000011" or OPCODE = "000111") then
	Byte_Op <= '1';
else 
	Byte_Op <= '0';
end if;
end process;


    process(CLK, RST)		
 begin
		IF ( RST='1') THEN State1 <= Start;
		elsif (rising_edge(CLK)) then State1<=State2;
		END IF;
end process;

	 process(State1,OPCODE,FUNC)
		begin
			case State1 is
			when Start => State2<= Start1;
			
			when START1 =>
						if OPCODE="100000" then State2<=Rtype;
						elsif OPCODE="111111" then State2<=B;
						elsif OPCODE="000000" then State2<=Beq;
						elsif OPCODE="000001" then State2<=Bne;
						elsif OPCODE="111000" then State2<=LI;
						elsif OPCODE="111001" then State2<=LUI;
						elsif OPCODE="110000" then State2<=ADDI; 
						elsif OPCODE="110010" then State2<=NANDI; 
						elsif OPCODE="110011" then State2<=ORI;
						elsif OPCODE="011111" then State2<=Store;
						elsif OPCODE="000111" then State2<=Store;
						elsif OPCODE="001111" then State2<=Load;
						elsif OPCODE="000011" then State2<=Load;
						else State2<=Start;
						end if;


						
		  when Rtype => State2<=Rtype1;
		  when Rtype1 => State2<=Rtype2;
		  when Rtype2 => State2<=Start;
		  
		  
		  
		  when  LI => State2 <= ITYPE1;
		  when  LUI => State2 <= ITYPE1;
		  when  ADDI => State2 <= ITYPE1;
		  when  NANDI => State2 <= ITYPE1;
		  when  ORI => State2 <= ITYPE1;
		 
		  
		  
		  when ITYPE1 => State2 <= ITYPE2;
		  when ITYPE2 => State2 <= Start;
		  
		  
	
	     when B => State2 <=Start;
		
         
	
	     when Beq => State2 <= Beq1;
		  when Beq1 => State2 <= Beq2;
	     when Beq2 => State2 <= Beq3;
		  when Beq3 => if (BBFLAG='1') then
								STATE2<= BBFlagState;
							elsif (BBFLAG='0') then STATE2<=Start;
							else STATE2<=Start;
							end if;
							
							
       when Bne => State2 <= Bne1;	
	    when Bne1 => State2 <= Bne2;
		 when Bne2 => State2 <= Bne3;
		 when Bne3 =>  if (BBFLAG='1') then
								STATE2<=Start;
								
							elsif (BBFLAG='0') 
							then STATE2 <= BBFlagState;
							else STATE2<=Start;
							end if;
							
							
							
							
							
		  when Load => State2 <= Load1;
	     when Load1 => State2 <= Load2;
	     when Load2 => State2 <= Load3;
	     when Load3 => State2 <= Start;
	     
		  
	
	     when Store => State2 <= Store1;
	     when Store1 => State2 <= Store2;
	     when Store2 => State2 <= Start;
		  
	
	     when BBFlagState => State2 <= Start;
		  
		 
	     when others => State2 <= Start;
	
	     end case;
		  
		  end process;
		  
		  process(State1,State2,BBFLAG)
		  
		begin
		
			case State1 is
			
		  when Start=>
			  PC_sel <='0';
			  PC_LdEn <='1';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='0';
			  ALUSrcB<="01";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='1';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			 when Start1=>

			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='X';
			  ALUSrcB<="XX";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  when Rtype=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<=FUNC;
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			 
			  when Rtype1=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<=FUNC;
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  when Rtype2=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<=FUNC;
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  when LI=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  when LUI=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="10";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
		     when ADDI => 
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  when NANDI => 
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="01";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0101";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  when ORI => 
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="01";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0011";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			    
			 
			  when ITYPE1 =>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  
			  when ITYPE2 =>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			   
			  when B =>
			  PC_sel <='0';
			  PC_LdEn <='1';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='0';
			  ImmExt<="11";
           ALUSrcA<='0';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  
			  when Beq=>
			  
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="11";
           ALUSrcA<='0';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  
			  when Beq1=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			  
			   when Beq2=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			   when Beq3=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  when Bne=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="11";
           ALUSrcA<='0';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  when Bne1=>
			  
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			     when Bne2=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			   when Bne3=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='1';
			  ALUSrcB<="00";
           ALU_func<="0001";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';

			  
			 
			  
		
			  
			  when Load=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='0';
			  MEMWr <='1';
			  ALUWr <='0';
			  
			  
			  when Load1=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='1';
			  ALUWr <='1';
			  
			  when Load2=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='1';
			  ALUWr <='0';
			  
			  
			  when Load3=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='1';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="XX";
           ALUSrcA<='0';
			  ALUSrcB<="00";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='1';
			  ALUWr <='0';
			  
			  when Store=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  when Store1=>
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  
			  when Store2=>
			  
			  PC_sel <='0';
			  PC_LdEn <='0';
			  RF_WrEn <='0';
           RF_WrDatasel <='1';
           RF_B_sel<='1';
			  ImmExt<="00";
           ALUSrcA<='1';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='1';
			  InstructWr <='0';
			  AWr<='1';
			  BWr <='1';
			  MEMWr <='0';
			  ALUWr <='1';
			  
			  
			
			  when BBFlagState=>
			  PC_sel <='1';
			  PC_LdEn <='1';
			  RF_WrEn <='0';
           RF_WrDatasel <='0';
           RF_B_sel<='1';
			  ImmExt<="11";
           ALUSrcA<='0';
			  ALUSrcB<="10";
           ALU_func<="0000";
           Mem_WrEn<='0';
			  InstructWr <='0';
			  AWr<='0';
			  BWr <='0';
			  MEMWr <='0';
			  ALUWr <='0';
			  
			  
			end case;
			end process;
			
		
		
end Behavioral;

