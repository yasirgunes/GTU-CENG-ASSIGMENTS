module mux_8x1_32bit(
    output [31:0] result,
    input [2:0] sel,
    input [31:0] in_0,
    input [31:0] in_1,
    input [31:0] in_2,
    input [31:0] in_3,
    input [31:0] in_4,
    input [31:0] in_5,
    input [31:0] in_6,
    input [31:0] in_7
);
wire [31:0] in0_result_ext, in1_result_ext, in2_result_ext, in3_result_ext;
wire [31:0] in4_result_ext, in5_result_ext, in6_result_ext, in7_result_ext;

wire [31:0] result_in0, result_in1, result_in2, result_in3, result_in4, result_in5;
wire [31:0] result_in6, result_in7;

wire [31:0] result_or1, result_or2, result_or3, result_or4, result_or5, result_or6;

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
extend_to_32 ext1(in0_result_ext, in0_result);
and_32bit and3(result_in0, in0_result_ext, in_0);
// 001 => in[1]
and and4(in1, sel[0], not_sel1);
and and5(in1_result, in1, not_sel2);
extend_to_32 ext2(in1_result_ext, in1_result);
and_32bit and6(result_in1, in1_result_ext, in_1);
// 010 => in[2]
and and7(in2, not_sel0, sel[1]);
and and8(in2_result, in2, not_sel2);
extend_to_32 ext3(in2_result_ext, in2_result);
and_32bit and9(result_in2, in2_result_ext, in_2);
// 011 => in[3]
and and10(in3, sel[0], sel[1]);
and and11(in3_result, in3, not_sel2);
extend_to_32 ext4(in3_result_ext, in3_result);
and_32bit and12(result_in3, in3_result_ext, in_3);
// 100 => in[4]
and and13(in4, not_sel0, not_sel1);
and and14(in4_result, in4, sel[2]);
extend_to_32 ext5(in4_result_ext, in4_result);
and_32bit and15(result_in4, in4_result_ext, in_4);
// 101 => in[5]
and and16(in5, sel[0], not_sel1);
and and17(in5_result, in5, sel[2]);
extend_to_32 ext6(in5_result_ext, in5_result);
and_32bit and18(result_in5, in5_result_ext, in_5);
// 110 => in[6]
and and19(in6, not_sel0, sel[1]);
and and20(in6_result, in6, sel[2]);
extend_to_32 ext7(in6_result_ext, in6_result);
and_32bit and21(result_in6, in6_result_ext, in_6);
// 111 => in[7]
and and22(in7, sel[0], sel[1]);
and and23(in7_result, in7, sel[2]);
extend_to_32 ext8(in7_result_ext, in7_result);
and_32bit and24(result_in7, in7_result_ext, in_7);

or_32bit or1(result_or1, result_in0, result_in1);
or_32bit or2(result_or2, result_in2, result_in3);
or_32bit or3(result_or3, result_in4, result_in5);
or_32bit or4(result_or4, result_in6, result_in7);

or_32bit or5(result_or5, result_or1, result_or2);
or_32bit or6(result_or6, result_or3, result_or4);

or_32bit or7(result, result_or5, result_or6);

endmodule