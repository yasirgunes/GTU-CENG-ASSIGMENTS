module alu_1_bit(
    output result,
    output cout,
    input a,
    input b,
    input less, // a less than b if less=1
    input cin,
    input [2:0] alu_op
);

// declarations
wire [2:0] wires;
wire [7:0] input_arr;

// a  b  c
// 2  1  0

// ------------- xor b ------------------
// if ab'c' + ab => xor b
not not1(not_aluop1, alu_op[1]); // b'
not not2(not_aluop0, alu_op[0]); // c'

and and2(wires[0], alu_op[2], not_aluop1); // ab'
and and3(wires[1], wires[0], not_aluop0); // ab'c'

and and4(wires[2], alu_op[2], alu_op[1]); // ab

or or2(b_complement_cond, wires[1], wires[2]); // ab'c' + ab

xor xor2(b_xor, b, b_complement_cond);
// ------------------------------------------------------

and and1(and_a_b, a, b_xor);                                    // 000
or or1(or_a_b, a, b_xor);                                       // 001
xor xor1(xor_a_b, a, b_xor);                                    // 010
nor nor1(nor_a_b, a, b_xor);                                    // 011
// less                                                         // 100
full_adder fa1(add_a_b, cout, a, b_xor, cin);                   // 101
// substract                                                    // 110
// mod                                                          // 111

and and7(input_arr[0], and_a_b, 1);
and and8(input_arr[1], or_a_b, 1);
and and9(input_arr[2], xor_a_b, 1);
and and10(input_arr[3], nor_a_b, 1);
and and11(input_arr[4], less, 1);
and and12(input_arr[5], add_a_b, 1);
and and13(input_arr[6], add_a_b, 1);
and and14(input_arr[7], 1, 1); // mod



mux_8x1_1bit mux1(result, alu_op, input_arr);

endmodule
