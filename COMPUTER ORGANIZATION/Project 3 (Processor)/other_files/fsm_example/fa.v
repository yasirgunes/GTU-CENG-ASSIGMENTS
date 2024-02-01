
module fa(
	input a,
	input b,
	input cin,
	output cout,
	output res
);

xor g0(res, a, b, cin);
wire w1, w2, w3;
and g1(w1, a, b);
and g2(w2, a, cin);
and g3(w3, b, cin);
or g4(cout, w1, w2, w3);


endmodule
