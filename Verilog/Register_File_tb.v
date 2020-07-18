`timescale 1ns / 1ps

module Register_File_tb;

// Inputs
reg Clock;
reg Write_enable;
reg Reset;
reg [2:0] Rreg1;
reg [2:0] Rreg2;
reg [2:0] Wreg;
reg [15:0] Data_in;

// Outputs
wire [15:0] R1;
wire [15:0] R2;

// Instantiate the Unit Under Test (UUT)
	Registe_File uut (
	.Clock(Clock), 
	.Write_enable(Write_enable), 
	.Reset(Reset), 
	.Rreg1(Rreg1), 
	.Rreg2(Rreg2), 
	.Wreg(Wreg), 
	.Data_in(Data_in), 
	.R1(R1), 
	.R2(R2)
);

//simulation variables
reg error_occur;
event terminate_sim;
event compare;
event compare_done;
event Reset_enable;
event Reset_done;
integer i;
//reg [ 15 : 0 ] Expected [ 0 : 7 ] ;
//initial 
//		$readmemb ( "expected.txt" , Expected ) ;

// Initialize Inputs
initial begin
	Clock = 0;
	Write_enable = 0;
	Reset = 0;
	Rreg1 = 0;
	Rreg2 = 7;
	Wreg = 0;
	Data_in = 0;
	i = 0;
	error_occur = 0;
	$display ("###################################################");
end
   
//dumping
initial
begin
	$dumpfile("Register_File.vcd");
	$dumpvars;
end
	
//terminating
initial
begin
	@(terminate_sim)
	$display ("Terminating simulation");
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

//clock
always #10 Clock = ~Clock;

//reset
always @(Reset_enable)
begin
	@(negedge Clock);
	Reset = 1;
	@(negedge Clock);
	Reset = 0;
	-> Reset_done;
end
	
//test vectors
initial
begin
	#15
	//reset
	-> Reset_enable;
	@(Reset_done);
	//Data In
	Data_in = 16'h0FA3;
	Write_enable = 1;
	for (i = 0; i < 8 ; i = i + 1)
	begin
		@(negedge Clock);
		Wreg = Wreg + 1;
		Data_in = Data_in + 1;
	end
	Write_enable = 0;
	-> compare;
	@(compare_done);
	-> terminate_sim;
end

//comparing
always @(compare)
begin
	Data_in = 16'h0FA3;
	for (i = 0; i < 8 ; i = i + 1)
	begin
		@(negedge Clock)
		if (R1 != Data_in)
		begin
			$display ("Register File ERROR AT TIME%d",$time);
			$display ("Expected value %d, Got Value %d", Data_in, R1);
			error_occur = 1;
		end
		
		else
		begin
			$display ("Expected value %d, Got Value %d", Data_in, R1);
		end
		Data_in = Data_in + 1;
		Rreg1 = Rreg1 + 1;
	end
	Data_in = Data_in - 1;

	for (i = 7; i >= 0 ; i = i - 1)
	begin
		@(negedge Clock)
		if (R2 != Data_in)
		begin
			$display ("Register File ERROR AT TIME%d",$time);
			$display ("Expected value %d, Got Value %d", Data_in, R2);
			error_occur = 1;
		end
		
		else
		begin
			$display ("Expected value %d, Got Value %d", Data_in, R2);
		end
		Data_in = Data_in - 1;
		Rreg2 = Rreg2 - 1;
	end

-> compare_done;

end

endmodule

