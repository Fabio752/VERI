
module processor (sysclk, data_in, data_out, data_valid, SW);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	input 			data_valid;
	input [9:0]		SW;
	output [9:0] 	data_out;	// 10-bit output data

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire [9:0]		x,y;
	wire [9:0]		echo;
	
	wire 				full;
	wire [12:0] 	raddr;
	wire	[8:0]    q;
	wire [12:0]    wraddr;
	
	wire pulse;
	
	
	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;
	
	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	
	
	counter_13 CTR13(data_valid, 1'b1, raddr, 1'b0);
	assign wraddr = raddr[12:0] + {SW[8:0],4'b0};
	
	// This part should include your own processing hardware 
	// ... that takes x to produce y
	
	
	
	ram_2p RAM2P(sysclk, y[9:1], raddr[12:0], pulse, wraddr[12:0], pulse , q[8:0]);
	
	pulse_gen GG(pulse, data_valid, sysclk);
	
	assign y = x - {q[8],q[8], q[8:1]};
	
	
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		data_out <=  y + DAC_OFFSET;
		
endmodule
	
