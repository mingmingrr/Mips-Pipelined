// vim: set ft=verilog:

`ifndef ARITH_EXTEND_I
`define ARITH_EXTEND_I

`include "./SignedUnsigned.v"
`include "../Util/Control.v"
`include "../Util/Pack.v"

module Arith_extend #
	( parameter IN_W  = 16
	, parameter OUT_W = 32
	, parameter DEPTH = 2
	, parameter DELAY = 0
	)
	( `Array_Pack_T(input, DEPTH, IN_W)  in
	, `Array_Pack_T(output, DEPTH, OUT_W) out
	, `Util_Control_T(input) ctrl
	); // this module can go die in the trash

`Array_Pack_unpackDecl(wire, DEPTH, IN_W, in, in$, i1, updl1)
`Array_Pack_packDecl(reg, DEPTH, IN_W, out$, out, i2, pdl1)

integer i;
always @(posedge `Util_Control_clock(ctrl))
	for(i = 0; i < DEPTH; i = i + 1)
		out$[i] <= OUT_W'(in$[i]);
endmodule

`endif
