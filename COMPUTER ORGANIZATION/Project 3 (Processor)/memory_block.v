module memory_block(
	output reg [31:0] read_data,
	input byteOperations, // optional
	input [17:0] address,
	input [31:0] write_data,
	input memRead,
	input memWrite
);


//create memory block
//reg [31:0] memory [65535:0]; // too slow!
reg [31:0] memory [255:0];

initial begin
// read the memory block
$readmemb("memory.mem", memory);
end

always @(*) begin
	if(byteOperations) begin
		if(memWrite) begin
			memory[address][7:0] = write_data[7:0];
			$writememb("memory.mem", memory);
			read_data = memory[address];
		end
		else if(memRead) begin
			read_data[7:0] = memory[address][7:0];
			read_data[31:8] = 24'b0;
		end
		else begin
			read_data = write_data;
		end
	end
	else begin
		if(memWrite) begin
			memory[address] = write_data;
			$writememb("memory.mem", memory);
			read_data = memory[address];
		end
		
		// if memWrite is not 1 then check if memRead is 1
		else if(memRead) begin
			read_data = memory[address];
		end

		else begin
			read_data = write_data;
		end
	end
end



endmodule
