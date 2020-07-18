`timescale 1ns / 1ps

module Output_Port(
							input Clock , LOP ,
							input [15:0] In ,
							output reg [15:0] Out
							);

always @(posedge Clock)
begin
	if (LOP)
		Out <= In;
end

endmodule
