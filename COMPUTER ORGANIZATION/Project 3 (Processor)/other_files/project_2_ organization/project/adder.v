module adder(
    output [31:0] r,
    output c32,
    input [31:0] a,
    input [31:0] b,
    input [2:0] ALUop, // can be 100 or 101 or 110 | less than add or substract
    input c0
);

// ------------- xor b ------------------
wire [2:0] wires;
wire [31:0] b_xor;
wire [31:0] b_complement_cond_extended;

// if ab'c' + ab => xor b
not not11(not_aluop1, ALUop[1]); // b'
not not22(not_aluop0, ALUop[0]); // c'

and and22(wires[0], ALUop[2], not_aluop1); // ab'
and and33(wires[1], wires[0], not_aluop0); // ab'c'

and and44(wires[2], ALUop[2], ALUop[1]); // ab

or or22(b_complement_cond, wires[1], wires[2]); // ab'c' + ab

extend_to_32 ext1(b_complement_cond_extended, b_complement_cond);
xor_32bit xor32_1(b_xor, b, b_complement_cond_extended);

// ------------------------------------------------------


wire c4, c8, c12, c16, c20, c24, c28;
// ---------------------------------------------------------------------
//                       CLA LOGIC
wire [3:0] g_3_0;
wire [3:0] p_3_0;
generate_propagate_4bit gp1(g_3_0, p_3_0, a[3:0], b_xor[3:0]);

wire [3:0] g_7_4;
wire [3:0] p_7_4;
generate_propagate_4bit gp2(g_7_4, p_7_4, a[7:4], b_xor[7:4]);

wire [3:0] g_11_8;
wire [3:0] p_11_8;
generate_propagate_4bit gp3(g_11_8, p_11_8, a[11:8], b_xor[11:8]);

wire [3:0] g_15_12;
wire [3:0] p_15_12;
generate_propagate_4bit gp4(g_15_12, p_15_12, a[15:12], b_xor[15:12]);

wire [3:0] g_19_16;
wire [3:0] p_19_16;
generate_propagate_4bit gp5(g_19_16, p_19_16, a[19:16], b_xor[19:16]);

wire [3:0] g_23_20;
wire [3:0] p_23_20;
generate_propagate_4bit gp6(g_23_20, p_23_20, a[23:20], b_xor[23:20]);

wire [3:0] g_27_24;
wire [3:0] p_27_24;
generate_propagate_4bit gp7(g_27_24, p_27_24, a[27:24], b_xor[27:24]);

wire [3:0] g_31_28;
wire [3:0] p_31_28;
generate_propagate_4bit gp8(g_31_28, p_31_28, a[31:28], b_xor[31:28]);

// c4 = g_3_0 + p_3_0*c0
and and1(p_3_0c0, p_3_0, c0); // p_3_0*c0
or or1(c4, g_3_0, p_3_0c0);

// c8 = g_7_4 + p_7_4*c4
and and2(p_7_4c4, p_7_4, c4); // p_7_4*c4
or or2(c8, g_7_4, p_7_4c4);

// c12 = g_11_8 + p_11_8*c8
and and3(p_11_8c8, p_11_8, c8); // p_11_8*c8
or or3(c12, g_11_8, p_11_8c8);

// c16 = g_15_12 + p_15_12*c12
and and4(p_15_12c12, p_15_12, c12); // p_15_12*c12
or or4(c16, g_15_12, p_15_12c12);

// c20 = g_19_16 + p_19_16*c16
and and5(p_19_16c16, p_19_16, c16); // p_19_16*c16
or or5(c20, g_19_16, p_19_16c16);

// c24 = g_23_20 + p_23_20*c20
and and6(p_23_20c20, p_23_20, c20); // p_23_20*c20
or or6(c24, g_23_20, p_23_20c20);

// c28 = g_27_24 + p_27_24*c24
and and7(p_27_24c24, p_27_24, c24); // p_27_24*c24
or or7(c28, g_27_24, p_27_24c24);

// c32 = g_31_28 + p_31_28*c28
and and8(p_31_28c28, p_31_28, c28); // p_31_28*c28
or or8(c32, g_31_28, p_31_28c28);

// ---------------------------------------------------------------------
wire [7:0] trash; // to eliminate ripple carry adder and use carry lookahead adder.

// cla_4bit cla0(
//     .r(),
//     .c4(),
//     .a(),
//     .b(),
//     .less(),
//     .ALUop(),
//     .c0()
// );
// msb_cla_4bit msbcla0(
//     .r(),
//     .c4(),
//     .set(),
//     .a(),
//     .b(),
//     .less(),
//     .ALUop(),
//     .c0()
// );

wire [31:0] less;
wire set;
and_31bit andforless(less[31:1], 31'b0, 31'b0);

cla_4bit cla1(r[3:0], trash[0], a[3:0], b[3:0], less[3:0], ALUop, c0);
cla_4bit cla2(r[7:4], trash[1], a[7:4], b[7:4], less[7:4], ALUop, c4);
cla_4bit cla3(r[11:8], trash[2], a[11:8], b[11:8], less[11:8], ALUop, c8);
cla_4bit cla4(r[15:12], trash[3], a[15:12], b[15:12], less[15:12], ALUop, c12);
cla_4bit cla5(r[19:16], trash[4], a[19:16], b[19:16], less[19:16], ALUop, c16);
cla_4bit cla6(r[23:20], trash[5], a[23:20], b[23:20], less[23:20], ALUop, c20);
cla_4bit cla7(r[27:24], trash[6], a[27:24], b[27:24], less[27:24], ALUop, c24);
msb_cla_4bit cla8(r[31:28], trash[7], set, a[31:28], b[31:28], less[31:28], ALUop, c28);

and and9(less[0], set, 1);

endmodule
