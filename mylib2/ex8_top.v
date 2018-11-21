module ex8_top (
	
	//inputs
	KEY,
	CLOCK_50,
	//outputs
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	LEDR
);


	input	[3:3] KEY;
	input CLOCK_50;
	
	wire tick_ms;
	wire tick_hs;
	wire en_lfsr;
	wire start_delay;
	wire timeout;
	wire reset;
	wire t_out; //ex9
	wire [14:1] N; 
	wire [3:0] BCD0;
	wire [3:0] BCD1;
	wire [3:0] BCD2;
	wire [3:0] BCD3;
	wire [3:0] BCD4;
	
	parameter clk1 = 16'd49999;
	parameter clk2 = 9'd499;
	
	output	[6:0]HEX0;
	output	[6:0]HEX1;
	output	[6:0]HEX2;
	output	[6:0]HEX3;
	output	[6:0]HEX4;
	
	output	[9:0]LEDR;
	
	
	clk_tick			DIV_50K(CLOCK_50, 1'b1, clk1, tick_ms);
	clk_tick			DIV_5K(tick_ms, 1'b1, clk2, tick_hs);
	
	fsm				FSM(tick_ms, tick_hs, ~KEY[3], time_out, en_lfsr, start_delay, LEDR, t_out, reset /*ex9*/);
	lfsr14 			LFSR(en_lfsr, N, tick_ms);
	//bin2bcd_16		B2BCD({2'b00, N[14:1]}, BCD0, BCD1, BCD2, BCD3, BCD4); ex8
	
	delay 			DELAY(N, tick_ms, start_delay, time_out);
	
	
	reaction_count REACT(t_out, tick_ms, ~KEY[3], reset, react_time); //ex9
	
	bin2bcd_16 		TIME_BCD(react_time, BCD0, BCD1, BCD2, BCD3, BCD4); //ex9
	
	hex_to_7seg 	SEG0 (HEX0, BCD0);
	hex_to_7seg 	SEG1 (HEX1, BCD1);
	hex_to_7seg 	SEG2 (HEX2, BCD2);
	hex_to_7seg 	SEG3 (HEX3, BCD3);
	hex_to_7seg 	SEG4 (HEX4, BCD4);
	

	
endmodule 