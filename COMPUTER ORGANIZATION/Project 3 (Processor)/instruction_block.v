module instruction_block(
	output reg [31:0] instruction,
	input [31:0] pc
);	

/*
Instruction memory should hold up to 1024 instructions where each instruction is 32-bits.
Thus, the least significant 10 bits of the jump addresses will be enough.
But you should fill the rest of the address block with zeros. For instance, jump instruction’s address block (in machine 
code level) should be 26 bits even though you only use the least significant 10 bits.
*/

//reg [31:0] instructions [0:1023]; // 1024 instructions max (too slow!)

reg [31:0] instructions [0:255]; 

// read from instructions.mem



initial begin
	$readmemb("instructions.mem", instructions);
end

always @(pc) begin
	instruction = instructions[pc];
	$display("instruction: %b", instruction);
	$display("pc: %b", pc);
end


endmodule

