module xor_32bit(
    output [31:0] result,
    input [31:0] A,
    input [31:0] B
);

alu_1_bit alu1(result[0], cout1, A[0], B[0], 0, 0, 3'b010);
alu_1_bit alu2(result[1], cout1, A[1], B[1], 0, 0, 3'b010);
alu_1_bit alu3(result[2], cout1, A[2], B[2], 0, 0, 3'b010);
alu_1_bit alu4(result[3], cout1, A[3], B[3], 0, 0, 3'b010);
alu_1_bit alu5(result[4], cout1, A[4], B[4], 0, 0, 3'b010);
alu_1_bit alu6(result[5], cout1, A[5], B[5], 0, 0, 3'b010);
alu_1_bit alu7(result[6], cout1, A[6], B[6], 0, 0, 3'b010);
alu_1_bit alu8(result[7], cout1, A[7], B[7], 0, 0, 3'b010);
alu_1_bit alu9(result[8], cout1, A[8], B[8], 0, 0, 3'b010);
alu_1_bit alu10(result[9], cout1, A[9], B[9], 0, 0, 3'b010);
alu_1_bit alu11(result[10], cout1, A[10], B[10], 0, 0, 3'b010);
alu_1_bit alu12(result[11], cout1, A[11], B[11], 0, 0, 3'b010);
alu_1_bit alu13(result[12], cout1, A[12], B[12], 0, 0, 3'b010);
alu_1_bit alu14(result[13], cout1, A[13], B[13], 0, 0, 3'b010);
alu_1_bit alu15(result[14], cout1, A[14], B[14], 0, 0, 3'b010);
alu_1_bit alu16(result[15], cout1, A[15], B[15], 0, 0, 3'b010);
alu_1_bit alu17(result[16], cout1, A[16], B[16], 0, 0, 3'b010);
alu_1_bit alu18(result[17], cout1, A[17], B[17], 0, 0, 3'b010);
alu_1_bit alu19(result[18], cout1, A[18], B[18], 0, 0, 3'b010);
alu_1_bit alu20(result[19], cout1, A[19], B[19], 0, 0, 3'b010);
alu_1_bit alu21(result[20], cout1, A[20], B[20], 0, 0, 3'b010);
alu_1_bit alu22(result[21], cout1, A[21], B[21], 0, 0, 3'b010);
alu_1_bit alu23(result[22], cout1, A[22], B[22], 0, 0, 3'b010);
alu_1_bit alu24(result[23], cout1, A[23], B[23], 0, 0, 3'b010);
alu_1_bit alu25(result[24], cout1, A[24], B[24], 0, 0, 3'b010);
alu_1_bit alu26(result[25], cout1, A[25], B[25], 0, 0, 3'b010);
alu_1_bit alu27(result[26], cout1, A[26], B[26], 0, 0, 3'b010);
alu_1_bit alu28(result[27], cout1, A[27], B[27], 0, 0, 3'b010);
alu_1_bit alu29(result[28], cout1, A[28], B[28], 0, 0, 3'b010);
alu_1_bit alu30(result[29], cout1, A[29], B[29], 0, 0, 3'b010);
alu_1_bit alu31(result[30], cout1, A[30], B[30], 0, 0, 3'b010);
alu_1_bit alu32(result[31], cout1, A[31], B[31], 0, 0, 3'b010);

endmodule
