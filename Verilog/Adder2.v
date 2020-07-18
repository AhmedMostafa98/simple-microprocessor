`timescale 1ns / 1ps

module Adder2(
					input [15:0] IN1 , IN2 ,
					output [15:0] OUT
					);

assign OUT = IN1 + IN2 ;

endmodule
