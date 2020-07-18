`timescale 1ns / 1ps

module AND_OR(
					input Zero , BRCE , BRCNE ,
					output SPC3
					);

assign SPC3 = (BRCE & Zero) | (BRCNE & (~(Zero)));

endmodule
