`include "Data/Control/Control.v"
`include "Util/Delay/single.v"

module Util_Delay_array #
	( parameter WIDTH = 32
	, parameter DELAY = 0
	, parameter RESET = WIDTH'(0)
	)
	( `Data_Control_Control_T(input) ctrl
	, input  [WIDTH-1:0] in
	, output [WIDTH-1:0] out
	);

generate
	if(DELAY <= 0)
		assign out = in;
	else begin
		reg [WIDTH-1:0] q[DELAY-1:0];
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

/*
genvar i;
generate
	for(i = 0; i < WIDTH; i = i + 1) begin : GEN
		Util_Delay_single #
			( .DELAY(DELAY)
			, .RESET(RESET[i])
			) SINGLE
			( .ctrl (ctrl)
			, .in   (in[i])
			, .out  (out[i])
			);
	end
endgenerate
*/

endmodule

