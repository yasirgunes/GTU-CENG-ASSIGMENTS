module mod_cu(
	input reset,
	input CLK,
	input x,
	output reg we,
	output reg s,
	output reg result
);

reg [1:0] curr_state, next_state;

localparam 	    ADD 	= 2'b00,  // s1
				COMP	= 2'b01,  // s2
				SMALL   = 2'b10,  // s3
				LARGE	= 2'b11;
				
				
//State Registers			
always @(posedge CLK)
	begin
	if(reset)
		curr_state <= ADD;
	else
		curr_state <= next_state;
	end
	

//Next State Logic
always @(*)
	begin
	case(curr_state)
	ADD: 	begin
			next_state = COMP;
			end
	
	COMP: begin
			if(x)  
				next_state = SMALL;
			else
				next_state = COMP;
			end
	
	SMALL: begin
			 next_state = SMALL;
			 end
	
	
	endcase
	end
	
//Output Logic
always @(*)
	begin
	s = 1'b0;
	we = 1'b0;

	case(curr_state)
	ADD: 	begin
			s = 1'b0;
			we = 1'b1;
			result = 1'b0;
			end
	
	COMP: begin
			s = 1'b1;
			we = 1'b1;
			end
	
	SMALL: begin
			we = 1'b0;
			s = 1'b0;
			
			 result = 1'b1;  
			 end
	
	endcase
	end
	

	



endmodule