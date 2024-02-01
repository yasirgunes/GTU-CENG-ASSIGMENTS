// 4 bit full adder

module full_adder_4bit (output [3:0] sum, output c_out, input [3:0] a, input [3:0] b, input c_in);
// a:		a3 a2 a1 a0
// b:		b3 b2 b1 b0
// sum:	s3 s2 s1 s0
	full_adder fa1 (sum[0], c_out_0, a[0], b[0], c_in);
	full_adder fa2 (sum[1], c_out_1, a[1], b[1], c_out_0);
	full_adder fa3 (sum[2], c_out_2, a[2], b[2], c_out_1);
	full_adder fa4 (sum[3], c_out, a[3], b[3], c_out_2);
endmodule 