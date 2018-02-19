// vim: set ft=verilog:

`ifndef UTIL_DELAY_ARR_I
`define UTIL_DELAY_ARR_I

`include "Data/Control.v"
`include "Util/Delay/gen.v"

module Delay_Delay_arr #
	( parameter WIDTH = 32
	, parameter DELAY = 0
	, parameter RESET = WIDTH'(0)
	)
	( `Data_Control_T(input) ctrl
	, input  [WIDTH-1:0] in
	, output [WIDTH-1:0] out
	);

genvar i;
generate
	for(i = 0; i < WIDTH; i = i + 1) begin : dgen
		Delay_Delay_gen #
			( .DELAY(DELAY)
			, .RESET(RESET[i])
			) dg
			( .ctrl (ctrl)
			, .in   (in[i])
			, .out  (out[i])
			);
	end
endgenerate

endmodule

`endif
