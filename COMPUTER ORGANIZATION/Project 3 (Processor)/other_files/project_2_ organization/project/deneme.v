module deneme(
output [1:0] out,
input in
);

wire dumen;
and and2(out[0], dumen, 1);
and and3(out[1], in, 1);

and and4(dumen, 1,in);



endmodule
