module control_unit(
	output regDst,
	output branch,
	output memRead,
	output memWrite,
	output [2:0] ALUop,
	output ALUsrc,
	output regWrite,
	output jump,
	output byteOperations, 
	output move,
	input [5:0] opcode
);
// not op_code
not not1(not_opcode_0, opcode[0]);
not not2(not_opcode_1, opcode[1]);
not not3(not_opcode_2, opcode[2]);
not not4(not_opcode_3, opcode[3]);
not not5(not_opcode_4, opcode[4]);
not not6(not_opcode_5, opcode[5]);



// if opcode is 000000, then R-type
wire is_r_type;
and and1(is_r_type, not_opcode_0, not_opcode_1, not_opcode_2, not_opcode_3, not_opcode_4, not_opcode_5);

// if opcode is 11100X, then jump
and and2(jump, opcode[5], opcode[4], opcode[3], not_opcode_2, not_opcode_1);

// if opcode is 000010, then it is addi
wire is_addi;
and and3(is_addi, not_opcode_5, not_opcode_4, not_opcode_3, not_opcode_2, opcode[1], not_opcode_0);

// if opcode is 000011, then it is subi
wire is_subi;
and and4(is_subi, not_opcode_5, not_opcode_4, not_opcode_3, not_opcode_2, opcode[1], opcode[0]);

// if opcode is 000100, then it is andi
wire is_andi;
and and5(is_andi, not_opcode_5, not_opcode_4, not_opcode_3, opcode[2], not_opcode_1, not_opcode_0);

// if opcode is 000101, then it is ori
wire is_ori;
and and6(is_ori, not_opcode_5, not_opcode_4, not_opcode_3, opcode[2], not_opcode_1, opcode[0]);

// if opcode is 001000, then it is lw
wire is_lw;
and and7(is_lw, not_opcode_5, not_opcode_4, opcode[3], not_opcode_2, not_opcode_1, not_opcode_0);

// if opcode is 010000, then it is sw
wire is_sw;
and and8(is_sw, not_opcode_5, opcode[4], not_opcode_3, not_opcode_2, not_opcode_1, not_opcode_0);

// if opcode is 001001, then it is lb
wire is_lb;
and and9(is_lb, not_opcode_5, not_opcode_4, opcode[3], not_opcode_2, not_opcode_1, opcode[0]);

// if opcode is 010001, then it is sb
wire is_sb;
and and10(is_sb, not_opcode_5, opcode[4], not_opcode_3, not_opcode_2, not_opcode_1, opcode[0]);

// if opcode is 000111, then it is slti
wire is_slti;
and and11(is_slti, not_opcode_5, not_opcode_4, not_opcode_3, opcode[2], opcode[1], opcode[0]);

// if opcode is 100011, then it is beq
wire is_beq;
and and12(is_beq, opcode[5], not_opcode_4, not_opcode_3, not_opcode_2, opcode[1], opcode[0]);

// if opcode is 100111, then it is bne
wire is_bne;
and and13(is_bne, opcode[5], not_opcode_4, not_opcode_3, opcode[2], opcode[1], opcode[0]);

// if opcode is 100000, then it is move
wire is_move;
and and14(is_move, opcode[5], not_opcode_4, not_opcode_3, not_opcode_2, not_opcode_1, not_opcode_0);

// if opcode is 111001, then it is jal
wire is_jal;
and and16(is_jal, opcode[5], opcode[4], opcode[3], not_opcode_2, not_opcode_1, opcode[0]);

 
// find regDst
and and15(regDst, is_r_type);

// find branch
or or2(branch, is_beq, is_bne);

// find memRead
or or3(memRead, is_lw, is_lb);

// find memWrite
or or4(memWrite, is_sw, is_sb);

// find ALUsrc
or or5(ALUsrc, is_addi, is_subi, is_andi, is_ori, is_lw, is_sw, is_lb, is_sb, is_slti);

// find regWrite
or or6(regWrite, is_r_type, is_addi, is_subi, is_andi, is_ori, is_lw, is_lb, is_slti, is_move, is_jal);

// find byteOperations
or or7(byteOperations, is_lb, is_sb);

// find move
or or8(move, is_move);

// find ALUop
or or9(ALUop[0], is_r_type, is_ori, is_addi, is_lb, is_sb, is_lw, is_sw);
or or10(ALUop[1], is_r_type, is_subi, is_beq, is_bne);
or or11(ALUop[2], is_r_type, is_subi, is_beq, is_bne, is_addi, is_lb, is_sb, is_lw, is_sw, is_slti);

endmodule
