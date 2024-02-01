module b_xor_4bit();

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


endmodule
