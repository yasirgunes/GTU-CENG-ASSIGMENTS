module alu (output [3:0] result, input [3:0] a, input [3:0] b, input sel, input c_in);
	wire [3:0] and_result;
	wire [3:0] add_result;
	
	and_4bit and1 (and_result, a, b);
	full_adder_4bit fa1 (add_result, c_out, a, b, c_in);

	
	
	
	
	mux2x1 mux2x1 (result, and_result, add_result, sel);

	// sel = 0 --> and          sel = 1 --> add
	// if sel == 0 result = result1      else  result = result2
	
endmodule 