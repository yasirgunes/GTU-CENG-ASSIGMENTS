module mux_8x1_1bit(
    output result,
	input [2:0] sel,
	input wire [7:0] in
);

// 000 => in[0]
// 001 => in[1]
// ...
// 111 => in[7]

not not1(not_sel0, sel[0]);
not not2(not_sel1, sel[1]);
not not3(not_sel2, sel[2]);

// 000 => in[0]
and and1(in0, not_sel0, not_sel1);
and and2(in0_result, in0, not_sel2);
and and3(result_in0, in0_result, in[0]);
// 001 => in[1]
and and4(in1, sel[0], not_sel1);
and and5(in1_result, in1, not_sel2);
and and6(result_in1, in1_result, in[1]);
// 010 => in[2]
and and7(in2, not_sel0, sel[1]);
and and8(in2_result, in2, not_sel2);
and and9(result_in2, in2_result, in[2]);
// 011 => in[3]
and and10(in3, sel[0], sel[1]);
and and11(in3_result, in3, not_sel2);
and and12(result_in3, in3_result, in[3]);
// 100 => in[4]
and and13(in4, not_sel0, not_sel1);
and and14(in4_result, in4, sel[2]);
and and15(result_in4, in4_result, in[4]);
// 101 => in[5]
and and16(in5, sel[0], not_sel1);
and and17(in5_result, in5, sel[2]);
and and18(result_in5, in5_result, in[5]);
// 110 => in[6]
and and19(in6, not_sel0, sel[1]);
and and20(in6_result, in6, sel[2]);
and and21(result_in6, in6_result, in[6]);
// 111 => in[7]
and and22(in7, sel[0], sel[1]);
and and23(in7_result, in7, sel[2]);
and and24(result_in7, in7_result, in[7]);

or or1(result_or1, result_in0, result_in1);
or or2(result_or2, result_in2, result_in3);
or or3(result_or3, result_in4, result_in5);
or or4(result_or4, result_in6, result_in7);

or or5(result_or5, result_or1, result_or2);
or or6(result_or6, result_or3, result_or4);

or or7(result, result_or5, result_or6);
endmodule
