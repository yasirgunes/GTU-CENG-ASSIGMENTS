module my_testbench();
    wire [31:0] Result;
    reg [31:0] A;
    reg [31:0] B;
    reg [2:0] ALUop;
    reg clk;
    reg reset;

    alu alu1(Result, A, B, ALUop, clk, reset);

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
    // Initial values
    reset = 1;
    A = 32'd20;
    B = 32'd3;
    ALUop = 3'b111;

    // Release reset
    #10 reset = 0;
    #100 $display("A = %0d mod B = %0d =>  Result = %0d", A, B, Result);

    A=32'b10111001001100100110011111111110; B=32'b00000000000000000110000111001010; ALUop=3'b000; reset = 1; //and
    #0 $display("A = %b and B = %b =>  Result = %b", A, B, Result);
    #20 A=32'b10111001001100100110011100101010; B=32'b11111110000000000110000000001010; ALUop=3'b001; //or
    #0 $display("A = %b or B = %b =>  Result = %b", A, B, Result);
    #20 A=32'b10111001001100100110011100101010; B=32'b00000000000000000110000000001010; ALUop=3'b010; //xor
    #0 $display("A = %b xor B = %b =>  Result = %b", A, B, Result);
    #20 A=32'b10111001001100100110011100101010; B=32'b11111111111111000110000000001010; ALUop=3'b011; //nor
    #0 $display("A = %b nor B = %b =>  Result = %b", A, B, Result);
    #20 A=32'd99; B=32'd140; ALUop=3'b100; // less than
    #0 $display("A = %0d less than B = %0d =>  Result = %0d", A, B, Result[0]);
    #20 A=32'd18; B=32'd99; ALUop=3'b101; //add
    #0 $display("A = %0d add B = %0d =>  Result = %0d", A, B, Result);
    #20 A=32'd110; B=32'd38; ALUop=3'b110; // substract
    #0 $display("A = %0d substract B = %0d =>  Result = %0d", A, B, Result);
    #20 $stop;
    end

endmodule
