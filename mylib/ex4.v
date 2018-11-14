module b10_to_BCD(in, out0, out1, out2, out3);

	input 	[9:0] in;
	
	output	[3:0]	out0;
	output	[3:0]	out1;
	output	[3:0]	out2;
	output	[3:0]	out3;


	reg 	[3:0]	out0;
	reg	[3:0]	out1;
	reg	[3:0]	out2;
	reg	[3:0]	out3;
	
	reg	[9:0] gg;
	
	reg [15:0] count;

	reg	[3:0]	i;

	always @ (*) begin
		
		i = 4'b0000;
		gg = in;
		count = 16'b0000000000000000;
		
		while (i < 4'b1010) begin
			
			if((count & 16'b0000000000001111) > 16'b0000000000000100)
				count = count+3;
			
			if((count & 16'b00000000011110000) > 16'b0000000001000000)
				count = count+48;
			
			if((count & 16'b00000111100000000) > 16'b0000010000000000)
				count = count+768;
			
			if((count & 16'b1111000000000) > 16'b0100000000000000)
				count = count+12288;
			
			
			count = count << 1;
			count = count | ((gg & 10'b1000000000) >> 9);
			gg = gg << 1;
			
			i = i + 4'b0001;
			
		end

		
		
		out0 = count[3:0];
		out1 = count[7:4];
		out2 = count[11:8];
		out3 = count[15:12];
		end
		
		
	endmodule 