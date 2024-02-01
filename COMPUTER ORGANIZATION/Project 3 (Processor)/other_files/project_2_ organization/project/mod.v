module mod (
    output [31:0] Result,
    input clk,
    input reset,
    input [31:0] a,
    input [31:0] b
);
	 wire s, x, we, result;
	 wire [31:0] result_final;
	 
mod_cu cu(
	reset,
	clk,
	x,   
	we,
	s,
	result   
);

 mod_dp dp(
	clk,
	s,
	we,
	a,
	b,
	x,
   result_final
);

	 assign Result = result ? result_final : 32'b0;

endmodule
