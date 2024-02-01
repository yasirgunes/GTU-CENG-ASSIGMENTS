module an_fsm(
	input [31:0] a,
	input [31:0] b,
	input reset,
	input CLK,
	output result
);

wire wx, wwe, ws;

an_fsm_cu control(
.reset(reset),
.CLK(CLK),
.x(wx),
.we(wwe),
.s(ws),
.result(result)
);

an_fsm_dp datapath(
.CLK(CLK),
.s(ws),
.we(wwe),
.a(a),
.b(b),
.x(wx)
);


endmodule
