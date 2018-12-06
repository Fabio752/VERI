module ex15_top(
	CLOCK_50,
	DAC_CS,
	DAC_SDI,
	DAC_LD,
	DAC_SCK,
	PWM_OUT,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	
	ADC_SDO,
	ADC_CS,
	ADC_SCK,
	ADC_SDI
	
);


	input CLOCK_50;

	wire load;
	wire [9:0] A;
	wire [9:0] D;
	wire [23:0] result;
	wire[3:0] BCD0;
	wire[3:0] BCD1;
	wire[3:0] BCD2;
	wire[3:0] BCD3;
	wire[3:0] BCD4;
	
	output DAC_CS;
	output DAC_SDI;
	output DAC_LD;
	output DAC_SCK;
	output PWM_OUT;
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;
	output[6:0] HEX4;
	
	input ADC_SDO;
	output ADC_CS;
	output ADC_SCK;
	output ADC_SDI;
	
	wire[9:0] data_in;
	wire data_valid;
	
	

	parameter max = 16'd4999;
	parameter k = 14'h2710;
	
	
	spi2adc SPI_ADC (												// perform a A-to-D conversion
		.sysclk (CLOCK_50), 										// order of parameters do not matter
		.channel (1'b0), 											// use only CH1
		.start (load),
		.data_from_adc (data_in),
		.data_valid (data_valid),
		.sdata_to_adc (ADC_SDI),
		.adc_cs (ADC_CS),
		.adc_sck (ADC_SCK),
		.sdata_from_adc (ADC_SDO));	
	
	
	
	clktick_16  GEN_10K (CLOCK_50, 1'b1, 16'd4999, load);

	addr_reg C10(load, data_in[9:0], A[9:0], 1'b0);
	ROM 			R(A[9:0], load, D[9:0]);		  
	spi2dac 	  INTER(CLOCK_50, D[9:0], load, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	pwm 		  PWM(CLOCK_50, D[9:0], load, PWM_OUT);

	mult		MUL(result[23:0], k, data_in[9:0]);
	bin2bcd_16  B2BCD({2'b00, result[23:10]}, BCD0, BCD1, BCD2, BCD3, BCD4);
	hex_to_7seg SEG0(HEX0, BCD0);
	hex_to_7seg SEG1(HEX1, BCD1);
	hex_to_7seg SEG2(HEX2, BCD2);
	hex_to_7seg SEG3(HEX3, BCD3);
	hex_to_7seg SEG4(HEX4, BCD4);
	
endmodule 