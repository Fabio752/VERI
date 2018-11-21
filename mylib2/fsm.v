module fsm(clk, tick , trigger, time_out, en_lfsr, start_delay, ledr, timeout, reset/*ex9*/);

input clk;
input tick;
input trigger;
input time_out;

output en_lfsr;
output start_delay;
output [9:0] ledr;
output timeout; //ex9
output reset; //ex9

reg en_lfsr;
reg start_delay;
reg [9:0]ledr;
reg [1:0] state;
reg timeout; //ex9
reg reset; //ex9

initial en_lfsr = 1'b0;
initial start_delay = 1'b0;
initial ledr = 10'b0;
initial state = 2'b0;
initial timeout = 1'b0; //ex9
initial reset = 1'b0; //ex9

parameter WAIT = 2'b00;
parameter LIGHTS = 2'b01;
parameter DELAY = 2'b10;
parameter RESET = 2'b11;


always @ (posedge clk)
	
	case(state)
		WAIT:
			if(trigger == 1'b1)
				state <= LIGHTS;
		LIGHTS:
			if(ledr == 10'b1111111110)
				state <= DELAY;
		DELAY:
			if(ledr == 10'b1111111111)
				state <= RESET;
		RESET:
			if(time_out == 1'b1)
				state <= WAIT;
			
	endcase 

	
always @ (*)
	
	case(state)
		WAIT: begin
			en_lfsr <= 1'b0;
			start_delay <= 1'b0;
			timeout <= 1'b1; //ex9
		end	
		LIGHTS: begin
			en_lfsr <= 1'b1;
			start_delay <= 1'b0;
			timeout <= 1'b0; //ex9
		end	
		DELAY: begin
			en_lfsr <= 1'b0;
			start_delay <= 1'b0;
			reset <= 1; //ex9

		end	
		RESET: begin
			en_lfsr <= 1'b0;
			start_delay <= 1'b1;
			reset <= 0; //ex9
		end	
		
	endcase 
	
always @(posedge tick)

	case(state)
		WAIT: 
			ledr <= 10'b0000000000;
			
		LIGHTS: 
			case(ledr)
				10'b0000000000: ledr <= 10'b1000000000;
				10'b1000000000: ledr <= 10'b1100000000;
				10'b1100000000: ledr <= 10'b1110000000;
				10'b1110000000: ledr <= 10'b1111000000;
				10'b1111000000: ledr <= 10'b1111100000;
				10'b1111100000: ledr <= 10'b1111110000;
				10'b1111110000: ledr <= 10'b1111111000;
				10'b1111111000: ledr <= 10'b1111111100;
				10'b1111111100: ledr <= 10'b1111111110;
				default: 		 ledr <= 10'b0000000000;
			endcase
		
		DELAY: ledr <= 10'b1111111111;
		RESET: ledr <= 10'b1111111111;
	
	endcase 

endmodule 