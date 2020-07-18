`timescale 1ns / 1ps

module MP(
			input Clock , Reset ,
			input [15:0] IN ,
			output [15:0] OUT
			);

parameter RMUX1_111 = 3'b111;
parameter Alumux2_in2 = 3'b000;
parameter Alumux2_in3 = 3'b010;
parameter Alumux2_in4 = 3'b011;
parameter Alumux3_in2 = 3'b001;

//wires
wire [15:0] Instruction; //Imem output
wire [15:0] Alu_Result; //Alu op
wire [15:0] AluB; // alu input
wire [15:0] R1 , R2; //// alu ip
wire [15:0] Program_Counter_Output; //Imem ip , pc op
wire [15:0] D_to_DATA_in_RF;  //Ram op
wire [15:0] Rmux3_to_Rmux4; 
wire [15:0] Rmux4_to_Rmux5; 
wire [15:0] Program_Counter_Inc; //Adder 1 op
wire [15:0] InPort_to_DATA_in_RF; //ip port op
wire [15:0] Rmux5_to_DATA_in_RF; //RF DATA in
wire [15:0] SE_Result; //sign ex op
wire [15:0] PCmux2_to_PCmux1;
wire [15:0] Program_Counter_Input; //pc ip
wire [15:0] PCmux3_to_PCmux2; 
wire [15:0] ADDER2_to_PCmux3; //Adder 2 op
wire [2:0] Rmux2_to_Rmux1;
wire [2:0] Rmux1_to_WREG; //write reg of RF ip
wire [2:0] Alumux2_to_Alumux3;
wire [2:0] Alu_control; //ALUMUX3 op , ip to alu control
wire ZF; // zero flag from alu op
wire AND1_to_OR;
wire AND2_to_OR;
wire SIG_SPC3;
wire SALU3;

wire [17 : 0] ControlUnit;

assign SALU3 = (ControlUnit[15]) | (ControlUnit[14]);
/////////////////////ALU////////////////////////////////////////////////////////////////////////////////////////
ALU alu (.Zero(ZF) , .Alu_result(Alu_Result) , .Alu_control(Alu_control) , .Alu_inputB(AluB) , .Alu_inputA(R1));
/////////////////////REGISTER_FILE//////////////////////////////////////////////////////////////////////////////
Registe_File RF (.Reset(Reset) , .Write_enable(ControlUnit[17]) , .Clock(Clock) , .R2(R2) , .R1(R1) ,
 .Data_in(Rmux5_to_DATA_in_RF) , .Wreg(Rmux1_to_WREG) , .Rreg2(Instruction[8:6]) , .Rreg1(Instruction[11:9]));
/////////////////////CONTROL_UNIT///////////////////////////////////////////////////////////////////////////////
Control_Unit CU (.Op_Code(Instruction[15:12]) , .OUT(ControlUnit));
/////////////////////DATA_MEMORY////////////////////////////////////////////////////////////////////////////////
RAM data_mem (.Clock(Clock) , .Write_enable(ControlUnit[16]) , .Addr(Alu_Result) , .Data_out(D_to_DATA_in_RF) , .Data_in(R2));
/////////////////////PROGRAM_COUNTER////////////////////////////////////////////////////////////////////////////
Program_Counter PC (.Clock(Clock) , .Reset(Reset) , .LD_PC(Program_Counter_Input) , .PC_out(Program_Counter_Output) ,
 .Load(ControlUnit[0]));
/////////////////////INSTRUCTION_MEMORY/////////////////////////////////////////////////////////////////////////
Imem inst_mem (.Addr(Program_Counter_Output) , .Instruction(Instruction));
/////////////////////SIGN_EXTENSION/////////////////////////////////////////////////////////////////////////////
Sign_Ex SE (.Data_in(Instruction[5:0]) , .Data_out(SE_Result));
/////////////////////OUTPUT_PORT///////////////////////////////////////////////////////////////////////////////
Output_Port OP (.Clock(Clock) , .LOP(ControlUnit[5]) , .Out(OUT) , .In(R1));
/////////////////////INPUT_PORT///////////////////////////////////////////////////////////////////////////////
Input_Port IP (.Clock(Clock) , .Out(InPort_to_DATA_in_RF) , .In(IN));
/////////////////////ADDER1//////////////////////////////////////////////////////////////////////////////////
Adder PC_inc (.Out(Program_Counter_Inc) , .In(Program_Counter_Output));
/////////////////////ADDER2/////////////////////////////////////////////////////////////////////////////////
Adder2 Branch (.IN1(Program_Counter_Inc) , .IN2(SE_Result) , .OUT(ADDER2_to_PCmux3));
/////////////////////AND_OR_CIRCUIT////////////////////////////////////////////////////////////////////////
AND_OR Sel_to_pcmux3 (.Zero(ZF) , .BRCE(ControlUnit[15]) , .BRCNE(ControlUnit[14]) , .SPC3(SIG_SPC3));
/////////////////////RMUX1//////////////////////////////////////////////////////////////////////////////////
MUX #(3) RMUX1 (.IN1(Rmux2_to_Rmux1) , .IN2(RMUX1_111) , .OUT(Rmux1_to_WREG) , .SEL(ControlUnit[8]));
/////////////////////RMUX2/////////////////////////////////////////////////////////////////////////////////
MUX #(3) RMUX2 (.IN1(Instruction[8:6]) , .IN2(Instruction[5:3]) , .OUT(Rmux2_to_Rmux1) , .SEL(ControlUnit[7]));
/////////////////////RMUX3//////////////////////////////////////////////////////////////////////////////////
MUX #(16) RMUX3 (.IN1(Alu_Result) , .IN2(D_to_DATA_in_RF) , .OUT(Rmux3_to_Rmux4) , .SEL(ControlUnit[9]));
/////////////////////RMUX4//////////////////////////////////////////////////////////////////////////////////
MUX #(16) RMUX4 (.IN1(Rmux3_to_Rmux4) , .IN2(Program_Counter_Inc) , .OUT(Rmux4_to_Rmux5) , .SEL(ControlUnit[10]));
/////////////////////RMUX5//////////////////////////////////////////////////////////////////////////////////
MUX #(16) RMUX5 (.IN1(Rmux4_to_Rmux5) , .IN2(InPort_to_DATA_in_RF) , .OUT(Rmux5_to_DATA_in_RF) , .SEL(ControlUnit[11]));
/////////////////////PMUX1//////////////////////////////////////////////////////////////////////////////////
MUX #(16) PCMUX1 (.IN1(PCmux2_to_PCmux1) , .IN2(R1) , .OUT(Program_Counter_Input) , .SEL(ControlUnit[12]));
/////////////////////RPUX2//////////////////////////////////////////////////////////////////////////////////
MUX #(16) PCMUX2 (.IN1({Program_Counter_Output[15:12] , Instruction[11:0]}) , .IN2(PCmux3_to_PCmux2) , .OUT(PCmux2_to_PCmux1) ,
 .SEL(ControlUnit[13]));
/////////////////////PMUX3//////////////////////////////////////////////////////////////////////////////////
MUX #(16) PCMUX3 (.IN1(Program_Counter_Inc) , .IN2(ADDER2_to_PCmux3) , .OUT(PCmux3_to_PCmux2) , .SEL(SIG_SPC3));
/////////////////////ALUMUX1//////////////////////////////////////////////////////////////////////////////////
MUX #(16) ALUMUX1 (.IN1(R2) , .IN2(SE_Result) , .OUT(AluB) , .SEL(ControlUnit[6]));
/////////////////////ALUMUX2//////////////////////////////////////////////////////////////////////////////////
MUX4 #(3) ALUMUX2 (.IN1(Instruction[2:0]) , .IN2(Alumux2_in2) , .IN3(Alumux2_in3) , .IN4(Alumux2_in4) , .OUT(Alumux2_to_Alumux3) ,
 .SEL(ControlUnit[2:1]));
/////////////////////ALUMUX3//////////////////////////////////////////////////////////////////////////////////
MUX #(3) ALUMUX3 (.IN1(Alumux2_to_Alumux3) , .IN2(Alumux3_in2) , .OUT(Alu_control) , .SEL(SALU3));
 

endmodule
