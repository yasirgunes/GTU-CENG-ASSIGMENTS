module alu_control(
	output [2:0] alu_ctr,
	input [5:0] function_code,
	input [2:0] ALUop);

// not ALUop
wire [2:0] not_ALUop;
not not1(not_ALUop[0], ALUop[0]);
not not2(not_ALUop[1], ALUop[1]);
not not3(not_ALUop[2], ALUop[2]);

// not function_code
wire [5:0] not_function_code;
not not4(not_function_code[0], function_code[0]);
not not5(not_function_code[1], function_code[1]);
not not6(not_function_code[2], function_code[2]);
not not7(not_function_code[3], function_code[3]);
not not8(not_function_code[4], function_code[4]);
not not9(not_function_code[5], function_code[5]);


// first lets find the is_r_type which is if ALUop = 111
wire is_r_type;
and and7(is_r_type, ALUop[2], ALUop[1], ALUop[0]);

wire not_r_type;
not not10(not_r_type, is_r_type);

// now find alu_ctr[0]

// if function_code == 000010 and if it is r_type
wire cond1;
and and8(cond1, not_function_code[5], not_function_code[4], not_function_code[3], not_function_code[2], function_code[1], not_function_code[0], is_r_type);

// if function_code == 000101 and if it is r_type
wire cond2;
and and9(cond2, not_function_code[5], not_function_code[4], not_function_code[3], function_code[2], not_function_code[1], function_code[0], is_r_type);

wire cond2_1;
and and14(cond2_1, ALUop[0], not_r_type);

or or1(alu_ctr[0], cond1, cond2, cond2_1);



// now find alu_ctr[1]

// if function_code == 000011 and if it is r_type
wire cond3;
and and10(cond3, not_function_code[5], not_function_code[4], not_function_code[3], not_function_code[2], function_code[1], function_code[0], is_r_type);

wire cond3_1;
and and15(cond3_1, ALUop[1], not_r_type);

or or2(alu_ctr[1], cond3, cond3_1);



// now find alu_ctr[2]

// if function_code == 000010 and if it is r_type
wire cond4;
and and11(cond4, not_function_code[5], not_function_code[4], not_function_code[3], not_function_code[2], function_code[1], not_function_code[0], is_r_type);

// if function_code == 000011 and if it is r_type
wire cond5;
and and12(cond5, not_function_code[5], not_function_code[4], not_function_code[3], not_function_code[2], function_code[1], function_code[0], is_r_type);

// if function_code == 000111 and if it is r_type
wire cond6;
and and13(cond6, not_function_code[5], not_function_code[4], not_function_code[3], function_code[2], function_code[1], function_code[0], is_r_type);

wire cond6_1;
and and16(cond6_1, ALUop[2], not_r_type);

or or3(alu_ctr[2], cond4, cond5, cond6, cond6_1);


endmodule

