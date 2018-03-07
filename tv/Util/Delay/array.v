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

endmodule

