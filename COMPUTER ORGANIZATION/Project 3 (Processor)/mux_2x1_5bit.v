module mux_2x1_5bit(output [4:0] result, input [4:0] input0, input [4:0] input1, input sel);

// if sel is 0 then output input1
// if sel is 1 then output input2

wire not_sel;
not not_gate(not_sel, sel);

wire [4:0] input0_and_not_sel;
wire [4:0] input1_and_sel;

and and1(input0_and_not_sel[0], input0[0], not_sel);
and and2(input0_and_not_sel[1], input0[1], not_sel);
and and3(input0_and_not_sel[2], input0[2], not_sel);
and and4(input0_and_not_sel[3], input0[3], not_sel);
and and5(input0_and_not_sel[4], input0[4], not_sel);

and and6(input1_and_sel[0], input1[0], sel);
and and7(input1_and_sel[1], input1[1], sel);
and and8(input1_and_sel[2], input1[2], sel);
and and9(input1_and_sel[3], input1[3], sel);
and and10(input1_and_sel[4], input1[4], sel);

or or1(result[0], input0_and_not_sel[0], input1_and_sel[0]);
or or2(result[1], input0_and_not_sel[1], input1_and_sel[1]);
or or3(result[2], input0_and_not_sel[2], input1_and_sel[2]);
or or4(result[3], input0_and_not_sel[3], input1_and_sel[3]);
or or5(result[4], input0_and_not_sel[4], input1_and_sel[4]);


endmodule
