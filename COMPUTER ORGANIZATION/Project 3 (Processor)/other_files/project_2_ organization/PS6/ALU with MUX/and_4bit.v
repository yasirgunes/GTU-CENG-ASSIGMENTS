module and_4bit (output [3:0] result, input [3:0] a, input [3:0] b);
	my_and and1 (result[0], a[0], b[0]);
	my_and and2 (result[1], a[1], b[1]);
	my_and and3 (result[2], a[2], b[2]);
	my_and and4 (result[3], a[3], b[3]);
endmodule 