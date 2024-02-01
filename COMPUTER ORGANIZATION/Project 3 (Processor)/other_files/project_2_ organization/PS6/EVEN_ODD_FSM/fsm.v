module fsm (input wire clk, input wire reset, output reg isEven, input [3:0] a);

	parameter EVEN = 0;
	parameter ODD  = 1;
	
	reg state;
	reg next_state;
	
	always @(posedge clk) begin 
		if (reset)
			state <= 0;
		else
			state <= next_state;
	end
	
	
	always @(posedge clk) begin
		if (reset) 
			next_state <= 0;
		else begin
			case (a[0])
				0: next_state <= 0;
				1: next_state <= 1;
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			isEven <= 1;
		else if (state == EVEN)
			isEven <= 1;
		else
			isEven <= 0;
	end
endmodule 