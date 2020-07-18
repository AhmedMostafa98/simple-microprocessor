`timescale 1ns / 1ps

module Imem(
				input [15:0] Addr ,
				output [15:0] Instruction
				);

reg [15:0] Imem [65535 : 0];

assign Instruction = Imem [Addr];

initial 
	$readmemb ("Code.dat", Imem);

endmodule
