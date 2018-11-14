module challenge (
	SW,
	HEX0,
	HEX1,
	HEX2,
	HEX3,

);

	input	[9:0] SW;


	output	[6:0]HEX0;
	output	[6:0]HEX1;
	output	[6:0]HEX2;
	output	[6:0]HEX3;
	
	wire 	[3:0]	out0;
	wire	[3:0]	out1;
	wire	[3:0]	out2;
	wire	[3:0]	out3;
	
	b10_to_BCD 		OUT (SW, out0, out1, out2, out3);
	
	hex_to_7seg 	SEG0 (HEX0, out0);
	hex_to_7seg 	SEG1 (HEX1, out1);
	hex_to_7seg 	SEG2 (HEX2, out2);
	hex_to_7seg 	SEG3 (HEX3, out3);
	
endmodule 