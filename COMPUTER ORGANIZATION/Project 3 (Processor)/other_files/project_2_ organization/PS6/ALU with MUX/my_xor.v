// my_xor
module my_xor (output result, input a, b);
	my_and a1 (and1, a, b);
	my_and a2 (and2, !and1, a);
	my_and a3 (and3, !and1, b);
	my_and a4 (and4, !and2, !and3);
	not (result, and4);
endmodule
	