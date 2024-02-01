module alu(
	output [31:0] alu_result,
	output zero_bit,
	input [31:0] alu_src1,
	input [31:0] alu_src2,
	input [2:0] alu_ctr
);

// ------------- xor b ------------------
wire [2:0] wires;
// if ab'c' + ab => xor b
not not1(not_alu_ctr1, alu_ctr[1]); // b'
not not2(not_alu_ctr0, alu_ctr[0]); // c'

and and2(wires[0], alu_ctr[2], not_alu_ctr1); // ab'
and and3(wires[1], wires[0], not_alu_ctr0); // ab'c'

and and4(wires[2], alu_ctr[2], alu_ctr[1]); // ab

or or2(b_complement_cond, wires[1], wires[2]); // ab'c' + ab
// ------------------------------------------------------

wire [2:0] trash;
wire [31:0] and_A_B, or_A_B, xor_A_B, nor_A_B, less_A_B, add_A_B, sub_A_B, mod_A_B;

and_32bit and_op (and_A_B, alu_src1, alu_src2);                                           // 000
or_32bit or_op   (or_A_B, alu_src1, alu_src2);                                            // 001
// xor_32bit xor_op (xor_A_B, alu_src1, alu_src2);                                        // 010
// nor_32bit nor_op (nor_A_B, alu_src1, alu_src2);                                        // 011
adder less_op    (less_A_B, trash[0], alu_src1, alu_src2, 3'b100, b_complement_cond);     // 100
adder add_op     (add_A_B,  trash[1], alu_src1, alu_src2, 3'b101, b_complement_cond);     // 101
adder sub_op     (sub_A_B,  trash[2], alu_src1, alu_src2, 3'b110, b_complement_cond);     // 110                                                               // 110
// mod mod_op       (mod_A_B,  clk, reset, alu_src1, alu_src2);                           // 111


mux_8x1_32bit mux1(alu_result, alu_ctr, and_A_B, or_A_B, 32'b0, 32'b0, less_A_B, add_A_B, sub_A_B, 32'b0);

nor nor1(zero_bit, alu_result[0], alu_result[1], alu_result[2], alu_result[3], alu_result[4], alu_result[5], alu_result[6], alu_result[7], alu_result[8], alu_result[9], alu_result[10], alu_result[11], alu_result[12], alu_result[13], alu_result[14], alu_result[15], alu_result[16], alu_result[17], alu_result[18], alu_result[19], alu_result[20], alu_result[21], alu_result[22], alu_result[23], alu_result[24], alu_result[25], alu_result[26], alu_result[27], alu_result[28], alu_result[29], alu_result[30], alu_result[31]);

endmodule
