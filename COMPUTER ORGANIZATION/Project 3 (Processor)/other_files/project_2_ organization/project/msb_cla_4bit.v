module msb_cla_4bit(
	output [3:0] r,
	output c4,
    output set,
	input [3:0] a,
	input [3:0] b,
	input [3:0] less,
    input [2:0] ALUop,
	input c0
);

wire [3:0] p;
wire [3:0] g;
wire [3:0] trash;
wire c1, c2, c3;

// ------------- xor b ------------------
wire wires[2:0];
// if ab'c' + ab => xor b
not not11(not_aluop1, ALUop[1]); // b'
not not22(not_aluop0, ALUop[0]); // c'

and and22(wires[0], ALUop[2], not_aluop1); // ab'
and and33(wires[1], wires[0], not_aluop0); // ab'c'

and and44(wires[2], ALUop[2], ALUop[1]); // ab

or or22(b_complement_cond, wires[1], wires[2]); // ab'c' + ab

xor xor22(b0_xor, b[0], b_complement_cond);
xor xor33(b1_xor, b[1], b_complement_cond);
xor xor44(b2_xor, b[2], b_complement_cond);
xor xor55(b3_xor, b[3], b_complement_cond);
// ------------------------------------------------------

// ----------------------------------------------------------
//								CLA LOGIC

// g0 = a[0]b[0]
// p0 = a[0] + b[0]
// c1 = g0 + p0c0
and and1(g[0], a[0], b0_xor);
or or1(p[0], a[0], b0_xor);
and and2(p0c0, p[0], c0);
or or2(c1, g[0], p0c0);


// g1 = a[1]b[1]
// p1 = a[1] + b[1]
// c2 = g1 + p1c1
and and3(g[1], a[1], b1_xor);
or or3(p[1], a[1], b1_xor);
and and4(p1c1, p[1], c1);
or or4(c2, g[1], p1c1);

// g2 = a[2]b[2]
// p2 = a[2] + b[2]
// c3 = g2 + p2c2
and and5(g[2], a[2], b2_xor);
or or5(p[2], a[2], b2_xor);
and and6(p2c2, p[2], c2);
or or6(c3, g[2], p2c2);


// g3 = a[3]b[3]
// p3 = a[3] + b[3]
// c4 = g3 + p3c3
and and7(g[3], a[3], b3_xor);
or or7(p[3], a[3], b3_xor);
and and8(p3c3, p[3], c3);
or or8(c4, g[3], p3c3);

// ----------------------------------------------------------

alu_1_bit alu1(
	.result(r[0]),
	.cout(trash[0]),
	.a(a[0]),
	.b(b[0]),
	.less(less[0]),
	.cin(c0),
	.alu_op(ALUop));


alu_1_bit alu2(
	.result(r[1]),
	.cout(trash[1]),
	.a(a[1]),
	.b(b[1]),
	.less(less[1]),
	.cin(c1),
	.alu_op(ALUop));


alu_1_bit alu3(
	.result(r[2]),
	.cout(trash[2]),
	.a(a[2]),
	.b(b[2]),
	.less(less[2]),
	.cin(c2),
	.alu_op(ALUop));

msb_alu_1_bit alu4(
	.result(r[3]),
	.cout(trash[3]),
    .set(set),
	.a(a[3]),
	.b(b[3]),
	.less(less[3]),
	.cin(c3),
	.alu_op(ALUop));



endmodule
