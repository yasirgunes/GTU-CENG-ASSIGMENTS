
module an_fsm_dp(
	input CLK,
	input s,
	input we,
	input [31:0] a,
	input [31:0] b,
	output x
);


reg [31:0] temp;
wire [31:0] mux_out1;
wire [31:0] mux_out2;
wire [31:0] sum;

always @(posedge CLK)
	begin
	if(we)
		temp <= sum;
	end

assign mux_out1 = s ? temp : a;
assign mux_out2 = s ? -32'd500 : b;

add32 i2(.a(mux_out1), .b(mux_out2), .res(sum));

buf i3(x, sum[31]);

endmodule
