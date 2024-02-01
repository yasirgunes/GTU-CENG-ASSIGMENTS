module testbench();

reg clk_tb;

mips Mips(
.clock(clk_tb)
);

integer i;
initial begin
    clk_tb = 1'b0;
    for (i = 0; i < 55*2; i = i + 1) begin
        #10 clk_tb = ~clk_tb;
    end
end

endmodule
