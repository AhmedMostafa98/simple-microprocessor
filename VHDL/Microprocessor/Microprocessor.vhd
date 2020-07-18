----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:21:13 04/10/2019 
-- Design Name: 
-- Module Name:    Microprocessor - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all; 

entity Microprocessor is  

	port(  
			clock : in std_logic ; 
			data_out : out std_logic_vector ( (16-1) downto 0 ) ;
			data_in : in std_logic_vector ( 3 downto 0 ) ;
         reset : in std_logic			
			);
end Microprocessor; 
 
architecture Behavioral of Microprocessor is 
 
------------------------------------ signals ------------------------------------
---------------------------------------------------------------------------------

signal Instruction : std_logic_vector (15 downto 0); --khareg mn el inst mem
signal Rmux2_to_Rmux1 : std_logic_vector (2 downto 0); --el selk elly bin el 2 muxes dol
signal Rmux1_to_WREG : std_logic_vector (2 downto 0); --WREG
signal ALU_Result : std_logic_vector (15 downto 0); --khareg mn el alu
signal D_to_DATA_in_RF : std_logic_vector (15 downto 0); --khareg mn el data memory
signal Rmux3_to_Rmux4 : std_logic_vector (15 downto 0); --el selk elly bin el 2 muxes dol
signal Program_Counter_Inc : std_logic_vector (15 downto 0); --el pc b3d ma zwdnah b wa7d
signal Rmux4_to_Rmux5 : std_logic_vector (15 downto 0); --el selk elly bin el 2 muxes dol
signal SE_Result : std_logic_vector (15 downto 0); --elly tale3 mn el sign extend
signal R2 : std_logic_vector (15 downto 0); --R2 el out bta3 el RF
signal ALU_B : std_logic_vector (15 downto 0); --el in el tani bta3 el alu
signal R1 : std_logic_vector (15 downto 0); --R1 el out bta3 el RF
signal PCmux2_to_PCmux1 : std_logic_vector (15 downto 0); --el selk elly bin el 2 muxes dol
signal Program_Counter_Input : std_logic_vector (15 downto 0); --dh el input elly dakhel 3la el pc
signal PCmux3_to_PCmux2 : std_logic_vector (15 downto 0); --el selk elly bin el 2 muxes dol
signal ADDER2_to_PCmux3 : std_logic_vector (15 downto 0); --el selk elly tale3 mn el adder el tani
signal Program_Counter_Output : std_logic_vector (15 downto 0); --elly khareg mn el pc
signal ZF : std_logic; --el zero flag elli tale3 mn el alu w dakhel 3la el circuit bta3et el branch
signal AND1_to_OR : std_logic; --el selk elli bin awl AND gate w el OR gate
signal AND2_to_OR : std_logic; --el selk elli bin tani AND gate w el OR gate
signal SPC3 : std_logic; 
signal inport_to_DATA_in_RF : std_logic_vector ( 15 downto 0 ) ;
signal Rmux5_to_DATA_in_RF : std_logic_vector ( 15 downto 0 ) ;
signal ALU_MUX4to1 : std_logic_vector ( 2 downto 0 ) ;

signal S_ALU_mux_3 : std_logic ;

----------------------------------- control unit -----------------------------------------------------

signal WRF : std_logic ;
signal WRAM : std_logic ;
signal BRCE : std_logic ;
signal BRCNE : std_logic ;
signal SPC2 : std_logic ;
signal SPC1 : std_logic ;
signal SRFD1 : std_logic ;
signal SRFD2 : std_logic ;
signal SRFD3 : std_logic ;
signal SRFW1 : std_logic ;
signal SRFW2 : std_logic ;
signal SALU : std_logic ;
signal LOP : std_logic ;
signal SALU1 : std_logic ;
signal SALU0 : std_logic ;
signal LPC : std_logic ;
signal Reset_Of_PC : std_logic ; 
signal Reset_Of_RF: std_logic ;

------------------------------- top level signals --------------------------------

-- signal skew_clock : std_logic ;
signal global_reset : std_logic ;
signal out_signal_top_level : std_logic_vector (15 downto 0 ) ;
signal in_signal_top_level : std_logic_vector (3 downto 0 ) ;
 
------------------------------------ components ---------------------------------
---------------------------------------------------------------------------------


component Mux is -- mux 2*1 
	port (
			w0,w1 : in std_logic_vector (15 downto 0);
			sel :in std_logic;
			f  : out std_logic_vector(15 downto 0)) ;
end component ;


component signextend is
port (   data_in : in std_logic_vector(5 downto 0);
         data_out : out std_logic_vector(15 downto 0)); 
end component;

Component  ALU is port (
			Alu_inputA,Alu_inputB : in std_logic_vector (15 downto 0);
			Alu_result : out std_logic_vector (15 downto 0);
			Alu_control: in std_logic_vector (2 downto 0);
			Zero : out std_logic
);
end component ;

component mux4to1 is

port( A : in std_logic_vector ( 2 downto 0 ) ; 
      S1,S2,s3: in std_logic ;
      O: out std_logic_vector ( 2 downto 0 ) 
  );
end component;

component Control_Unit 
port (    OPcode: in std_logic_vector (3 downto 0) ; --4 integer inputs 2^4--
	MicroReset : in std_logic; --Button Input to Reset the MircoProcessor
	--Control word--
	-- WRF	WRAM	BRCE	BRCNE	SPC2	SPC1	SRFD1	SRFD2	SRFD3	SRFW1	SRFW2	SALU	LOP	SALU1	SALU0	LPC--
	CtrlWord: out std_logic_vector(15 downto 0); --16 bit control--
	RPC , RRF: out std_logic);
end component ;


component reg_file is port ( 
			Read_register1,Read_register2,Write_register : in std_logic_vector (2 downto 0);    --8 Registers--
			Data_in : in std_logic_vector (15 downto 0) ;
			Write_enable,clk,reset : in std_logic;
			Read_Data1,Read_data2 : out  std_logic_vector (15 downto 0)
);
end component ; 

component programcounter is
port( 
       clock,reset,ld:in std_logic;
       load_pc:in std_logic_vector(15 downto 0);
       pc_out:out std_logic_vector(15 downto 0));
end component; 

component mux_21_3 is
		port(
				w0,w1 : in std_logic_vector ( 2 downto 0);
				sel  :in std_logic;
				f   : out std_logic_vector( 2 downto 0)) ;
end component ;

component input_latch is

generic	(	M	:	integer	:=	4	);	--size of input latch

 port (
		 
		 latch_input_port_i	:	in	std_logic_vector	(	M-1	downto	0	) ;	--	input	latch
		 latch_input_port_o	:	out	std_logic_vector	(	15	downto	0	)	--	input	latch
		 
		 )	;
end component;


component output_latch is

generic	(	N	:	integer	:=	16	);	--size of output latch	

 port (
       latch_output_Data	:	out	std_logic_vector	(	N-1	downto	0	)	;	--	output latch
		 latch_input_Data	:	in	std_logic_vector	(	N-1	downto	0	)	;	--	output latch
		 load : in std_logic ;
       clk	:	in std_logic	)	;		--for output port	latch
		 
end component;


component a_16_bit_adder is
 
generic (n:integer:=16);  --  helps if we want to change the adder size we only change the value of n
 
port ( 

ADDRESS : in std_logic_vector (n-1 downto 0) ;  --first input to the 16 bit adder
OFSSET: in std_logic_vector ( n-1 downto 0) ;  -- second input to the 16 bit adder 
CIN : in std_logic  ;  -- carry in (NOT USED ) 
COUT : out std_logic ; -- final carry out  
SUM: out std_logic_vector (n-1 downto 0)); --sum of the two inputs    
end component ;

component RAM is
	port (
			clock : in std_logic ;
			W_enable : in std_logic ;
			Address : in std_logic_vector ( 5 downto 0 ) ;
			Data_in : in std_logic_vector ( 15 downto 0 ) ;
			Data_out : out std_logic_vector ( 15 downto 0 ) );
end component;

component ROM is
	port (
			Address : in std_logic_vector ( 9 downto 0 ) ;
			Data_out : out std_logic_vector ( 15 downto 0 ) );
end component;

---------------------------------------------------------------------------------

begin

------------------------------------ Port mapping -------------------------------
---------------------------------------------------------------------------------

sign_extend: signextend port map (
					data_in => Instruction (5 downto 0 ) ,
					data_out => SE_Result
					);

--------------------------------------- muxes -----------------------------------

M1 : Mux
port map ( w0=>PCmux2_to_PCmux1,
      w1=>R1,
      sel=> spc1,
      f=>program_counter_input  );
M2 : Mux
port map ( w0=> program_counter_output(15 downto 12) & instruction (11 downto 0 ) ,
           w1=> PCmux3_to_PCmux2 ,
           sel => spc2,
           f=>PCmux2_to_PCmux1);
M3 : Mux
port map ( w0=> program_counter_inc,
           w1=> ADDER2_to_pcmux3 , 
           sel => spc3,
           f =>PCmux3_to_PCmux2 );
M4 : mux_21_3
port map ( w0=>Rmux2_to_Rmux1,
           w1=> "111",
           sel =>SRFW1,
           f => Rmux1_to_WREG);
M5 : mux_21_3
port map ( w0=>instruction( 8 downto 6 ),
           w1=> instruction( 5 downto 3),
           sel =>SRFW2,
           f => Rmux2_to_Rmux1);
M6 : Mux
port map ( w0=>ALU_RESULT,
           W1 => D_to_DATA_in_RF,
           sel =>SRFD3,
            f=> Rmux3_to_Rmux4);
M7 : Mux
port map ( w0=> Rmux3_to_Rmux4,
           w1 =>program_counter_inc,
           sel=> SRFD2,
            f=> Rmux4_to_Rmux5);
M8 : Mux
port map ( w0=> Rmux4_to_Rmux5,
           w1 => inport_to_DATA_in_RF,
           sel => SRFD1 ,
           f => Rmux5_to_DATA_in_RF );
M9 : Mux
port map (w0=> R2 ,
          w1=> SE_RESULT,
          sel=> SALU,
          f=> Alu_B);
			 
---------------------------------------------------------------------------	
 -- PORT MAPPING FOR ALU --
		
X2 : ALU      port map ( 
                           Alu_inputA => R1 , 
                           Alu_inputB => ALU_B , 					  
                           ALU_Result => ALU_Result ,
                           Alu_control => ALU_MUX4to1 ,
                           Zero => ZF ) ; 	

	 -- PORT MAPPING FOR Registers_File --
X1 : reg_file port map (
                     Read_register1 => Instruction (11 downto 9) ,  
    					   Read_register2 => Instruction (8 downto 6)  , 
						   Write_register => Rmux1_to_WREG , 
                     Data_in => Rmux5_to_DATA_in_RF ,   
						   Write_enable =>  WRF ,  
						   clk => clock , 
						   reset => Reset_Of_RF ,
						   Read_Data1 => R1 , 
						   Read_Data2 => R2 ) ; 		
-- PORT MAPPING FOR MUX4TO1 which control ALU Operation  -- 
X4 : mux4to1  port map (	
                     A => instruction ( 2 downto 0 ) , 
						   S1 => SALU1 ,
						   S2 => SALU0 ,
							S3 => S_ALU_mux_3 ,
						   O => ALU_MUX4to1 ) ; 

---------------------------- control unit -----------------------							
CU1: Control_Unit port map ( 
				CtrlWord(15) => WRF,
				CtrlWord(14) => WRAM,
				CtrlWord(13) => BRCE,
				CtrlWord(12) => BRCNE,
            CtrlWord(11) => SPC2,
				CtrlWord(10) => SPC1,
				CtrlWord(9) => SRFD1,
				CtrlWord(8) => SRFD2,
				CtrlWord(7) => SRFD3,
				CtrlWord(6) => SRFW1,
				CtrlWord(5) => SRFW2,
				CtrlWord(4) => SALU,
				CtrlWord(3) => LOP,
				CtrlWord(2) => SALU1,
				CtrlWord(1) => SALU0,
				CtrlWord(0) => LPC,
				RPC => Reset_Of_PC,
				RRF => Reset_Of_RF,
				OPcode=>  instruction ( 15 downto 12 ) ,
				MicroReset => global_reset );
				
U1: programcounter 
port map ( load_pc => Program_Counter_Input,
           pc_out => Program_Counter_Output,
           clock => clock ,
           reset => Reset_Of_PC ,
           ld =>LPC );
			  
---------------------------------------- interfacing ports -------------------------------

In_latch: input_latch port map (
			  latch_input_port_o => Inport_to_DATA_in_RF ,
			  latch_input_port_i => in_signal_top_level );
			  
Output_port: output_latch port map (

		clk => clock ,
		Load => LOP ,
		latch_output_Data => out_signal_top_level ,
		latch_input_Data => R1    );

------------------------------------------ ADDERS ----------------------------------------

ADDER2: a_16_bit_adder port map (

	     ADDRESS => Program_Counter_Inc ,
	     OFSSET => SE_Result ,
        CIN => '0' ,
	    -- COUT => '0' ,
	     SUM => ADDER2_to_PCmux3 
			
); 

ADDER1: a_16_bit_adder port map (

	     ADDRESS => Program_Counter_Output ,
	     OFSSET => "0000000000000001" ,
        CIN => '0' ,
	    -- COUT => '0' ,
	     SUM => Program_Counter_Inc 
			
);

------------------------------------------ memories ---------------------------------------
Data_mem: RAM port map ( 

		clock => clock ,
		W_enable => WRAM ,
		Address => ALU_Result ( 5 downto 0)  ,
		Data_in => R2 ,
		Data_out => D_to_DATA_in_RF 

);

instruction_mem: Rom port map (
		
		Address => Program_Counter_Output ( 9 downto 0) ,
		Data_out => Instruction 

);
			  
			   
---------------------------------- top level connections -------------------------------

		AND1_to_OR <= (BRCE) AND (ZF) ;
		AND2_to_OR <= (BRCNE) AND (Not(ZF)) ;
		SPC3 <= (AND2_to_OR) OR (AND1_to_OR) ;
		S_ALU_mux_3 <= ( BRCE ) OR (BRCNE ) ;
		--skew_clock <= clock ; 
		global_reset <= not(reset) ;	 
		in_signal_top_level <= data_in ;
		data_out <= out_signal_top_level ;
		
end Behavioral;