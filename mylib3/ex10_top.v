module ex10_top (
	SW,
	CLOCK_50,
	DAC_CS,
	DAC_SDI,
	DAC_LD,
	DAC_SCK
);

	input [9:0] SW;
	input CLOCK_50;
	
	wire load;
	
	output DAC_CS;
	output DAC_SDI;
	output DAC_LD;
	output DAC_SCK;
	
	parameter max = 16'd4999;
	
	
	clk_tick   TK(CLOCK_50, 1'b1, max, load);
	spi2dac 	  INTER(CLOCK_50, SW[9:0], load, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	
endmodule 