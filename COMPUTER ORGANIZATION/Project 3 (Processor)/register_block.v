module register_block (
	output reg [31:0] read_data1, 
	output reg [31:0] read_data2, 
	input byteOperations,
	input [31:0] write_data, 
	input [4:0] read_reg1,
	input [4:0] read_reg2,
	input [4:0] write_reg,
	input regWrite
	);

// there are 32 registers in the register file which are 32 bits wide
reg [31:0] registers [31:0];
initial begin

// read the registers
$readmemb("registers.mem", registers);

end

always @(*) begin
	// read process
	$display("read_reg1: %b", read_reg1);
    $display("read_reg2: %b", read_reg2);
	read_data1 = registers[read_reg1];
	read_data2 = registers[read_reg2];
	if(regWrite) begin
		// write process
		registers[write_reg] = write_data;
	end
	$writememb("registers.mem", registers);
end

endmodule
