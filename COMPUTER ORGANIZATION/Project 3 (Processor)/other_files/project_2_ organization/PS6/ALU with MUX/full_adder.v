// full_adder

module full_adder (output sum, c_out, input a, b, c_in);
	my_xor xor1 (a_xor_b, a, b);
	my_xor xor2 (sum, a_xor_b, c_in);
	my_and and1 (a_xor_b_AND_c_in, a_xor_b, c_in);
	my_and and2 (a_and_b, a, b);
	my_or  or1  (c_out, a_xor_b_AND_c_in, a_and_b);
endmodule 