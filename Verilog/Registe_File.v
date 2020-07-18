`timescale 1ns / 1ps

module Registe_File(input Clock,
						  input	Write_enable,
						  input  Reset,
						  input [2:0] Rreg1,
						  input [2:0] Rreg2,
						  input [2:0] Wreg,
						  input [15:0] Data_in,
						  output [15:0] R1,
						  output [15:0] R2
						  );

reg [15:0] regfile [7:0];

integer i;

assign R1 = regfile [Rreg1];
assign R2 = regfile [Rreg2];

always @(posedge Clock or posedge Reset)
begin
	if(Reset)
	begin
		for (i=0;i<8;i=i+1)
		begin
			regfile[i] <= 0;
		end
	end
	else 
	begin
		if (Write_enable)
			regfile [Wreg] <= Data_in;
		end
end

endmodule
