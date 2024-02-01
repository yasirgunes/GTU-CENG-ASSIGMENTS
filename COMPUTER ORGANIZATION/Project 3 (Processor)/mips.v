module mips(input clock);

reg [31:0] pc;
wire [31:0] instruction;
wire byteOperations;

initial begin
    pc = 32'b0;
end

initial begin
    $display("pc: %b", pc);
end

instruction_block instruction_block(
    .instruction(instruction),
    .pc(pc)
);

// now we should decode the intruction
wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [5:0] funct;
wire [15:0] immediate;
wire [25:0] address;

assign opcode = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign funct = instruction[5:0];
assign immediate = instruction[15:0];
assign address = instruction[25:0];


// signextend the immediate
wire [31:0] signextended_immediate;
sign_extend sign_extend0(
    .sign_ext_imm(signextended_immediate),
    .imm(immediate)
);

wire regDst;
wire branch;
wire memRead;
wire memWrite;
wire [2:0] ALUop;
wire ALUsrc;
wire regWrite;
wire jump;
// wire byteOperations;
wire move;



control_unit control_unit0(
    .regDst(regDst),
    .branch(branch),
    .memRead(memRead),
    .memWrite(memWrite),
    .ALUop(ALUop),
    .ALUsrc(ALUsrc),
    .regWrite(regWrite),
    .jump(jump),
    .byteOperations(byteOperations),
    .move(move),
    .opcode(opcode)
);

// if function code is 001000 then it is jr
wire is_jr;
and and1(is_jr, funct == 6'b001000, opcode == 6'b000000);
// temp regWrite
wire regWrite_temp;
assign regWrite_temp = !is_jr & regWrite;


// now we should read the registers

// outputs
wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] read_data2_temp;

// inputs which will determined after the alu.
wire [31:0] write_data;
wire [31:0] write_data1;
wire [31:0] write_data2;

// determine writeReg with muxes
wire [4:0] write_reg;
wire [4:0] write_reg_temp;

mux_2x1_5bit mux1(write_reg_temp, rt, rd, regDst);
// for jal case
// if jump and if opcode 111001 then it is jal
wire jal;
and and30(jal, jump, opcode == 6'b111001);

mux_2x1_5bit mux2(write_reg, write_reg_temp, 5'd31, jal);

// determined the write_reg
register_block register_block0(
    .read_data1(read_data1),
    .read_data2(read_data2_temp),
    .byteOperations(byteOperations),
    .write_data(write_data),
    .read_reg1(instruction[25:21]), // rs
    .read_reg2(instruction[20:16]), // rt
    .write_reg(write_reg),
    .regWrite(regWrite_temp)
);




// before the ALU we should mux the read_data2 with signextended immediate

mux_2x1_32bit mux3(read_data2, read_data2_temp, signextended_immediate, ALUsrc);

// again before the ALU we should get the outputs of the ALU control.
wire [2:0] alu_ctr;
alu_control alu_control0(
    .alu_ctr(alu_ctr),
    .function_code(funct),
    .ALUop(ALUop)
);

// now we can call the ALU
wire [31:0] alu_result;
wire zero_bit;

alu alu0(
    .alu_result(alu_result),
    .zero_bit(zero_bit),
    .alu_src1(read_data1),
    .alu_src2(read_data2),
    .alu_ctr(alu_ctr)
);

// now we're heading to the data memory

// first we should minimize the address from 32 to 18 bits.
wire [17:0] minimized_address;
assign minimized_address = alu_result[17:0];

// output of the memory_block
wire [31:0] data_read_from_memory;

memory_block memory_block0(
    .read_data(data_read_from_memory),
    .byteOperations(byteOperations),
    .address(minimized_address),
    .write_data(read_data2_temp),
    .memRead(memRead),
    .memWrite(memWrite)
);

// now we should mux the data_read_from_memory with alu_result
mux_2x1_32bit mux4(write_data1, alu_result, data_read_from_memory, memRead);

// now let's implement beq and bne

// we should get PC + 1 + signextended_immediate
wire [4:0] trash;

wire [31:0] PC_plus_1;
alu alu1(
    .alu_result(PC_plus_1),
    .zero_bit(trash[0]),
    .alu_src1(pc),
    .alu_src2(32'b1),
    .alu_ctr(3'b101)
);

wire [31:0] PC_plus_1_plus_signextended_immediate;
alu alu2(
    .alu_result(PC_plus_1_plus_signextended_immediate),
    .zero_bit(trash[1]),
    .alu_src1(PC_plus_1),
    .alu_src2(signextended_immediate),
    .alu_ctr(3'b101)
);

// now we should mux the PC_plus_1_plus_signextended_immediate with PC_plus_1
wire [31:0] mux_out;
wire [31:0] mux_out1;
wire [31:0] mux_out2;




mux_2x1_32bit mux5(mux_out, PC_plus_1, PC_plus_1_plus_signextended_immediate, (branch & zero_bit) | ((opcode == 6'b100111) && ~zero_bit));

// we should mux it again for jr
mux_2x1_32bit mux6(mux_out1, mux_out, read_data1, is_jr); // if the function code is for jr

wire [31:0] address_for_jump;
assign address_for_jump = {pc[31:26], address};

// now we should mux it again for jump or jal
mux_2x1_32bit mux7(mux_out2, mux_out1, address_for_jump, jump | jal);



// we can continue for write_data

// now we should mux the write_data with mux_out for jal
mux_2x1_32bit mux8(write_data2, write_data1, mux_out, jal);

// now we should mux the write_data with read_data_1 for move instruction
mux_2x1_32bit mux9(write_data, write_data2, read_data1, move);



// now write_data is final! yeyy

// everything is done I guess. Now let's update the pc.


always @(posedge clock) begin
    pc = mux_out2;
    $display("signextended_immediate: %b", signextended_immediate);
    $display("read_data1: %b", read_data1);
    $display("read_data2: %b", read_data2);
    $display("alu_ctr: %b", alu_ctr);
    $display("alu_result: %b", alu_result);
    $display("pc: %b", pc);
    $display("mux_out: %b", mux_out);
	 $display("write_data: %b", write_data);
    $display("write_data2: %b", write_data2);
    $display("write_data1: %b", write_data1);

end

endmodule
