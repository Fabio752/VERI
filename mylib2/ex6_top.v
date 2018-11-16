module ex6_top (
	KEY,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4
);


	input	[1:0] KEY; //LOW ACTIVE!!

	output	[6:0]HEX0;
	output	[6:0]HEX1;
	output	[6:0]HEX2;
	output	[6:0]HEX3;
	output	[6:0]HEX4;
	
	wire	[15:0] count;
	wire 	[3:0]	BCD0;
	wire	[3:0]	BCD1;
	wire	[3:0]	BCD2;
	wire	[3:0]	BCD3;
	wire	[3:0]	BCD4;
	
	counter_16 		COUNT (CLOCK_50, ~KEY[0], count, KEY[1]);
	
	bin2bcd_16		BCD (count, BCD0, BCD1, BCD2, BCD3, BCD4);
	
	hex_to_7seg 	SEG0 (HEX0, BCD0);
	hex_to_7seg 	SEG1 (HEX1, BCD1);
	hex_to_7seg 	SEG2 (HEX2, BCD2);
	hex_to_7seg 	SEG3 (HEX3, BCD3);
	hex_to_7seg 	SEG4 (HEX4, BCD4);
	
endmodule 