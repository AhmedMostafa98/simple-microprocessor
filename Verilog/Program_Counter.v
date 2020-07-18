`timescale 1ns / 1ps

module Program_Counter(
								input Clock , Reset , Load ,
								input [15:0] LD_PC ,
								output reg [15:0] PC_out
								);

always @(posedge Clock or posedge Reset)
begin
	if (Reset)
		PC_out <= 0;
	else
	begin
		if (~(Load))
			PC_out <= LD_PC;
		end
end

endmodule
