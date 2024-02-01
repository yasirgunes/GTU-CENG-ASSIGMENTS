module my_xor (output result, input a, b);
	my_and and1 (and1_output, a, b);
	my_and and2 (and2_output, a, !and1_output);
	my_and and3 (and3_output, b, !and1_output);
	my_and and4 (and4_output, !and2_output, !and3_output);
	assign result = !and4_output;
endmodule 