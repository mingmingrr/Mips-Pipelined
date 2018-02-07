// vim: set ft=verilog:

`ifndef DELAY_ARR_I
`define DELAY_ARR_I

`include "../Util/Control.v"
`include "../Util/Array.v"

module Delay_arr #
	( parameter WIDTH = 32
	, parameter DELAY = 0
	, parameter RESET = WIDTH'(0)
	)
	( `Util_Control_T(input) ctrl
	, input  [WIDTH-1:0] in
	, output [WIDTH-1:0] out
	);

generate
	if(DELAY <= 0)
		assign out = in;
	else begin
		reg [WIDTH-1:0] q[DELAY-1:0];
		integer i;
		always @(posedge `Util_Control_clock(ctrl))
			if(!`Util_Control_reset(ctrl)) begin
				q[0] = in;
				for(i = 1; i < DELAY; i = i + 1)
					q[i] = q[i-1];
			end else
				`Util_Array_setAll(q, DELAY, i, RESET)
		assign out = q[DELAY-1];
	end
endgenerate

endmodule

`endif
