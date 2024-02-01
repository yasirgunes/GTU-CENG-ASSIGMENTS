module memory_operations(input [31:0] content, input [4:0] address, output reg [31:0] out);

	reg [31:0] registers [31:0];
	
	always @(address) begin
		$readmemb("registers.mem", registers);
		out = registers[address];
		registers[address] = content;
		$writememb("registers.mem", registers);
	end
	
	










endmodule
