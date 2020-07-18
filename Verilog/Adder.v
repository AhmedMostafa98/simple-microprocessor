`timescale 1ns / 1ps

module Adder( 
				input [15:0] In ,
				output [15:0] Out
				);

assign Out = In + 1;

endmodule
