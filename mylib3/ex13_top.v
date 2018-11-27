module ex13_top(
	CLOCK_50,
	DAC_CS,
	DAC_SDI,
	DAC_LD,
	DAC_SCK,
	PWM_OUT

);


	input CLOCK_50;
	
	wire load;
	wire [9:0] A;
	wire [9:0] D;
	
	output DAC_CS;
	output DAC_SDI;
	output DAC_LD;
	output DAC_SCK;
	output PWM_OUT;
	
	parameter max = 16'd4999;
	
	
	clk_tick   TK(CLOCK_50, 1'b1, max, load);

	counter_10 C10(CLOCK_50, 1'b1, A[9:0], 1'b0);
	ROM 			R(A[9:0], CLOCK_50, D[9:0]);		  

	spi2dac 	  INTER(CLOCK_50, D[9:0], load, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	
	pwm 		  PWM(CLOCK_50, D[9:0], load, PWM_OUT);

endmodule 