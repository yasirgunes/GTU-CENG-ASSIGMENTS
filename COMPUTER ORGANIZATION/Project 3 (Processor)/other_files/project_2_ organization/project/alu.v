module alu(
output [31:0] Result,
input [31:0] A,
input [31:0] B,
input [2:0] ALUop,
input clk,
input reset
);

// ------------- xor b ------------------
wire [2:0] wires;
// if ab'c' + ab => xor b
not not1(not_aluop1, ALUop[1]); // b'
not not2(not_aluop0, ALUop[0]); // c'

and and2(wires[0], ALUop[2], not_aluop1); // ab'
and and3(wires[1], wires[0], not_aluop0); // ab'c'

and and4(wires[2], ALUop[2], ALUop[1]); // ab

or or2(b_complement_cond, wires[1], wires[2]); // ab'c' + ab

// now I should xor the 32 bit B with 1 bit b_complement_cond
// if b_complement_cond == 1 => 1111111111111111...
// else => 0000000000...
wire [31:0] b_complement_cond_extended;

extend_to_32 ex1(b_complement_extended, b_complement_cond);

xor xor1(B_xor, B, b_complement_cond_extended);
// ------------------------------------------------------

wire [2:0] trash;
wire [31:0] and_A_B, or_A_B, xor_A_B, nor_A_B, less_A_B, add_A_B, sub_A_B, mod_A_B;

and_32bit and_op (and_A_B, A, B);                                           // 000
or_32bit or_op   (or_A_B, A, B);                                            // 001
xor_32bit xor_op (xor_A_B, A, B);                                           // 010
nor_32bit nor_op (nor_A_B, A, B);                                           // 011
adder less_op    (less_A_B, trash[0], A, B, 3'b100, b_complement_cond);     // 100
adder add_op     (add_A_B,  trash[1], A, B, 3'b101, b_complement_cond);     // 101
adder sub_op     (sub_A_B,  trash[2], A, B, 3'b110, b_complement_cond);     // 110                                                               // 110
mod mod_op       (mod_A_B,  clk, reset, A, B);                              // 111


mux_8x1_32bit mux1(Result, ALUop, and_A_B, or_A_B, xor_A_B, nor_A_B, less_A_B, add_A_B, sub_A_B, mod_A_B);

endmodule