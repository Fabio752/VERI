module delay (N, clk, trigger, time_out);

	input [14:1] N;
	input clk;
	input trigger;
	
	reg [14:1] count_down;
	
	output time_out;
	reg time_out;
	
	initial count_down = N;
	
	always @ (posedge clk) 
		if(count_down == 14'b0) begin
			count_down = N;
			time_out <= 1'b1;
		end
		else begin
			count_down <= count_down - 1'b1;
			time_out <= 0;
		end
		
endmodule 	