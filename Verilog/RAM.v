`timescale 1ns / 1ps

module RAM(
				input Clock , Write_enable,
				input [15:0] Data_in , 
				input [15:0] Addr,
				output [15:0] Data_out
				);

reg [15:0] mem [255 : 0];


always @(posedge Clock)
	if ( Write_enable )
		mem [Addr] = Data_in;

assign Data_out = mem [Addr];

endmodule
