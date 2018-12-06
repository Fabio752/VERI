`timescale 1ns / 100ps

module addr_reg (
	clock,
	offset,
	base, 
	reset
);

	parameter BIT_SZ = 10;
	input clock;
	input [BIT_SZ-1:0] offset;
	input reset;
	output [BIT_SZ-1:0] base;
	
	reg [BIT_SZ-1:0] base;
	
	initial base = 0;
	
	always @ (posedge clock)
		if (reset == 1'b1)
			base <=0;
		
		else 
			base <= base + offset;
		

endmodule 