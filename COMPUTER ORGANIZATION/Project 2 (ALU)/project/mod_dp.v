module mod_dp(
	input CLK,
	input s,
	input we,
	input [31:0] a,
	input [31:0] b,
	output x,
	output [31:0] result_final
);

//38 7

reg [31:0] temp;
wire [31:0] mux_out1;
wire [31:0] sum;

wire [1:0] trash;

wire [31:0] comp;



assign mux_out1 = s ? temp : a;  //38, 31, 24


adder substract(sum, trash[0], mux_out1, b, 3'b110, 1);  

always @(posedge CLK)
	begin
	if(we) begin
		if(temp < sum) temp <= temp;
		else temp <= sum;  
	end
	else 
		temp <= temp;
	end

adder comparison(comp, trash[1], mux_out1, b, 3'b100, 1);  


assign result_final = temp;

assign x = comp[0];

endmodule