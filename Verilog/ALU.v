`timescale 1ns / 1ps

module ALU (input [15:0] Alu_inputA,
			   input [15:0] Alu_inputB,
			   input [2:0] Alu_control,
			   output reg [15:0] Alu_result,
			   output Zero
				);
				
	parameter Add = 3'b000,
			    Sub = 3'b001,
			    And = 3'b010,
			    OR  = 3'b011,
			    Nor = 3'b100,
			    Xor = 3'b101,
			    SL  = 3'b110,
			    SR  = 3'b111;

	 reg OV;
	 
	 always @(*)
	 begin
		case (Alu_control)
			Add : {OV , Alu_result} = Alu_inputA + Alu_inputB;
			Sub : {OV , Alu_result} = Alu_inputA - Alu_inputB;
			And : {OV , Alu_result} = Alu_inputA & Alu_inputB;
			OR  : {OV , Alu_result} = Alu_inputA | Alu_inputB;
			Nor : {OV , Alu_result} = ~(Alu_inputA | Alu_inputB);
			Xor : {OV , Alu_result} = Alu_inputA ^ Alu_inputB;
			SL  : {OV , Alu_result} = Alu_inputA << Alu_inputB;
			SR  : {OV , Alu_result} = Alu_inputA >> Alu_inputB;
		endcase
	end

assign Zero = (Alu_result == 0);

endmodule
