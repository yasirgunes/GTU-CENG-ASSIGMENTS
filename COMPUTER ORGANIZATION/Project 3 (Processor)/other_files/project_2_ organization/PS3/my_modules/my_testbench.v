module my_testbench();
reg [3:0] a;
reg [3:0] b;
reg select;
wire [3:0] result;

mux2x1 mux1(result, a, b, select);
initial begin
	#0 a=4'b1010; b=4'b0101; select=1'b1;
	#5 a=4'b1010; b=4'b0101; select=1'b0;
	#5;
end


endmodule
