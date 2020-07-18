`timescale 1ns / 1ps

module Sign_Ex(
					input [5:0] Data_in ,
					output [15:0] Data_out
					);

assign Data_out = { {10{Data_in[5]}} , Data_in };

endmodule
