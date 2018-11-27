`timescale 1ns / 100ps

module counter_10 (
	clock,
	enable,
	count, 
	reset
);

	parameter BIT_SZ = 10;
	input clock;
	input enable;
	input reset;
	output [BIT_SZ-1:0] count;
	
	reg [BIT_SZ-1:0] count;
	
	initial count = 0;
	
	always @ (posedge clock)
		if (reset == 1'b1)
			count <=0;
		
		else if (enable == 1'b1)
			count <= count + 1'b1;
		

endmodule 