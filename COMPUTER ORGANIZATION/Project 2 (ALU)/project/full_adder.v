module full_adder(output s, cout, input a, b, cin);

wire [4:0] wr;

xor xor1(wr[0], a, b);
and and1(wr[1], a, b);
xor xor2(s, wr[0], cin);
and and2(wr[2], wr[0], cin);
or or1(cout, wr[2], wr[1]);


endmodule
