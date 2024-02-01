module my_testbench ();
	reg [3:0] a;
	reg [3:0] b;
	reg sel;
	reg c_in;
	wire [3:0] result;
	
	alu alu1 (result, a, b, sel, c_in);
	
	initial begin
		#0 a = 4'b1111; b = 4'b0001; sel = 0; c_in = 0;
		#5 $display ("a: %b, b: %b, sel: %b, c_in: %b, result: %b", a, b, sel, c_in, result);
		#0 a = 4'b1001; b = 4'b0001; sel = 1; c_in = 0;
		#5 $display ("a: %b, b: %b, sel: %b, c_in: %b, result: %b", a, b, sel, c_in, result);
		#0 a = 4'b0001; b = 4'b0001; sel = 1; c_in = 1;
		#5 $display ("a: %b, b: %b, sel: %b, c_in: %b, result: %b", a, b, sel, c_in, result);
		#0 a = 4'b0111; b = 4'b0011; sel = 0; c_in = 0;
		#5 $display ("a: %b, b: %b, sel: %b, c_in: %b, result: %b", a, b, sel, c_in, result);
	end 
endmodule 