module ex2_top (
	SW,
	HEX0
);
	input	[3:0] SW;
	output [6:0] HEX0;
	hex_to_7seg		SEG0 (HEX0, SW);
	
endmodule