`timescale 1ns / 1ps

module MUX4( IN1 , IN2 , IN3 , IN4 , SEL , OUT);
parameter N = 1;
input [N-1 : 0] IN1 , IN2 , IN3 , IN4 ;
input [1 : 0] SEL;
output [N-1 : 0] OUT;

reg [N-1 : 0] OUT;

always @(IN1 or IN2 or IN3 or IN4 or SEL)
begin
	case (SEL)
		2'b00 : OUT = IN1; 
		2'b01 : OUT = IN2; 
		2'b10 : OUT = IN3; 
		2'b11 : OUT = IN4; 
	endcase
end

endmodule
