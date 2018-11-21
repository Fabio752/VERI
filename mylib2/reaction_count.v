module reaction_count(enable, clk, press_key, reset, reaction_time);

	input enable;
	input clk;
	input press_key;
	input reset;

	output [15:0] reaction_time;
	
	reg lights_off;
	reg [15:0] reaction_time;
	
	always @(posedge clk) begin
			
		if(enable)
			if(!press_key) 
				reaction_time <= reaction_time + 1'b1;
		
		else if(reset)
			reaction_time <= 0;	
	end
		
endmodule 
	