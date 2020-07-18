`timescale 1ns / 1ps

module MUX(IN1 , IN2 , SEL , OUT);
parameter N = 1;
input [N-1 : 0] IN1 , IN2 ;
input SEL;
output reg [N-1 : 0] OUT;


always @(IN1 or IN2 or SEL)
begin
	case (SEL)
		1'b0 : OUT = IN1;
		1'b1 : OUT = IN2;
	endcase
end

endmodule
