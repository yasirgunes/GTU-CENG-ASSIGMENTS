module mux2x1(output [3:0] result, input [3:0] a, input [3:0] b, input sel);

wire [3:0] result_1;
wire [3:0] result_2;
not not1(not_sel, sel);

// if sel = 0, result = a
and and1(result_1[0], a[0], not_sel);
and and2(result_1[1], a[1], not_sel);
and and3(result_1[2], a[2], not_sel);
and and4(result_1[3], a[3], not_sel);

// if sel = 1, result = b

and and5(result_2[0], b[0], sel);
and and6(result_2[1], b[1], sel);
and and7(result_2[2], b[2], sel);
and and8(result_2[3], b[3], sel);

or or1(result[0], result_1[0], result_2[0]);
or or2(result[1], result_1[1], result_2[1]);
or or3(result[2], result_1[2], result_2[2]);
or or4(result[3], result_1[3], result_2[3]);

endmodule
