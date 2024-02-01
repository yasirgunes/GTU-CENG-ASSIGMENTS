// half_adder

module half_adder(output sum, c_out, input a, b);
	my_xor xor1 (sum, a, b);
	my_and and1 (c_out, a, b);
endmodule 