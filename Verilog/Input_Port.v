`timescale 1ns / 1ps

module Input_Port(
						input Clock ,
						input [15:0] In ,
						output reg [15:0] Out
						);

always @(posedge Clock)
	Out <= In;

endmodule
