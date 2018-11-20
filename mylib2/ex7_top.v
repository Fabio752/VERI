module ex7_top (
	KEY,
	HEX0,
	HEX1
);

	input	[3:0] KEY;

	output	[6:0]HEX0;
	output	[6:0]HEX1;

	wire 	[7:1]	LFSR0;
	
	lfsr7	OUT(LFSR0, KEY[3]);

	hex_to_7seg 	SEG0 (HEX0, LFSR0[4:1]);
	hex_to_7seg 	SEG1 (HEX1, {1'b0, LFSR0[7:5]});
	
endmodule 