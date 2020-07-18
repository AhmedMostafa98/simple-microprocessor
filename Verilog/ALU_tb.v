`timescale 1ns / 1ps

module ALU_tb;

//input declarations
reg [15:0] Alu_inputA , Alu_inputB;
reg [2:0] Alu_control;

//output declarations
wire [15:0] Alu_result;
wire Zero;


//instantiating module to be tested
ALU dut (.Alu_inputA(Alu_inputA) , .Alu_inputB(Alu_inputB) , .Alu_control(Alu_control) , .Alu_result(Alu_result) , .Zero(Zero));

//simulation variables
reg error_occur;
event terminate_sim;
event compare;
event compare_done;
integer i;
reg [ 15 : 0 ] Expected [ 0 : 7 ] ;

initial 
		$readmemb ( "expected.txt" , Expected ) ;

//initializing inputs
initial 
begin
	Alu_inputA = 0;
	Alu_inputB = 0;
	Alu_control = 7;
	error_occur = 0;
	i = 0;
	$display ("###################################################");
end

//dumping
initial
begin
	$dumpfile("ALU.vcd");
	$dumpvars;
end

//terminating
initial
begin
	@(terminate_sim)
	if (error_occur)
	begin
		$display ("Simulation Result : FAILED");
	end
	else
	begin
		$display ("Simulation Result : PASSED");
	end
	 $display ("###################################################");
	#5 $finish;
end

//test vector
initial
begin
	#5
	Alu_inputA = 16'hAB_03;
	Alu_inputB = 16'h32_FF;
	
	for (i = 0 ; i < 6 ; i = i + 1)
	begin
		Alu_control = Alu_control + 3'b001;
		-> compare;
		@(compare_done);
	end
	
	Alu_inputB = 4;
	
	for (i = 6 ; i < 8 ; i = i + 1)
	begin
		Alu_control = Alu_control + 3'b001;
		-> compare;
		@(compare_done);
	end
-> terminate_sim;
end

//comparing with the expected vector
always @(compare)
begin #2
	if (Expected[i] != Alu_result)
	begin
		error_occur = 1;
		$display ("DUT ERROR AT TIME%d",$time);
		$display ("Expected value %d, Got Value %d", Expected[i], Alu_result);
		#5 -> terminate_sim;
	end
	else
	begin
		$display ("Test Case#%d PASSED" , (i+1));
	end
	->compare_done;
end
	

endmodule
	
	
	

