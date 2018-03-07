`include "Data/Control/Control.v"

module Util_Delay_single #
	( parameter DELAY = 0
	, parameter RESET = 1'b0
	)
	( `Data_Control_Control_T(input) ctrl
	, input  in
	, output out
	);

generate
	if(DELAY <= 0)
		assign out = in;
	else begin
		reg q[DELAY-1:0];
		integer i;
		always @(posedge `Data_Control_Control_Clock(ctrl))
			if(!`Data_Control_Control_Reset(ctrl)) begin
				q[0] <= in;
				for(i = 1; i < DELAY; i = i + 1)
					q[i] <= q[i-1];
			end else
				for(i = 0; i < DELAY; i = i + 1)
					q[i] <= RESET;
		assign out = q[DELAY-1];
	end
endgenerate

endmodule

