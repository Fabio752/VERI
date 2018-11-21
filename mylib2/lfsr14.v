module lfsr14(enable, data_out, clk);
	
	input clk;
	input enable;
	
	output [14:1] data_out;

	
	reg[14:1] sreg;
	
	initial sreg = 14'b1;
	
	always @ (posedge clk)
		if(enable == 1'b1)
			sreg <= {sreg[13:1], sreg [1] ^ sreg[6] ^ sreg[10] ^ sreg[14]};
	
	assign data_out = sreg;
	
endmodule 