`timescale 1ns/1ns
module tb;

reg [31:0] a;
reg [31:0] b;
reg CLK;
reg reset;
wire result;

an_fsm i0(
	.a(a),
	.b(b),
	.reset(reset),
	.CLK(CLK),
	.result(result)
);


initial	
	begin
	CLK = 1'b0;
	reset = 1'b1;
	a = 32'd250;
	b = 32'd251;
	
	#5
	reset = 1'b0;
	
	#10
	reset = 1'b1;
	b = 32'd200;
	
	#5
	reset = 1'b0;
	
	end
	
	
always 
	begin
	#1
	CLK = ~CLK;
	end

endmodule
