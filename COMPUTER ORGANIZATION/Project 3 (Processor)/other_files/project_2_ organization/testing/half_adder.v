module half_adder(input a, b, output s, carry_out);

xor xor1(s, a, b);
and and1(carry_out, a, b);

endmodule
