module mux_2x1_32bit(output [31:0] result, input [31:0] input0, input [31:0] input1, input sel);

wire not_sel;
wire [31:0] not_sel_extended;
wire [31:0] sel_extended;
wire [31:0] input0_and_not_sel;
wire [31:0] input1_and_sel;


not not_gate(not_sel, sel);


extend_to_32 extend0(sel_extended, sel);
extend_to_32 extend1(not_sel_extended, not_sel);

and_32bit and0(input0_and_not_sel, input0, not_sel_extended);
and_32bit and1(input1_and_sel, input1, sel_extended);

or_32bit or0(result, input0_and_not_sel, input1_and_sel);

endmodule
