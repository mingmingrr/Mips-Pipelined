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
	( `Util_Pack_T(input, DEPTH, IN_W)  in
	, `Util_Pack_T(output, DEPTH, OUT_W) out
	, `Arith_SignedUnsigned_T(input) sign
	); // this module can go die in the trash

`Util_Pack_unpackDecl(wire, DEPTH, IN_W, in, in$, i1)
`Util_Pack_packDecl(reg, DEPTH, IN_W, out$, out, i2)
`Util_Pack_unpackDecl(wire signed, DEPTH, IN_W, in, in$s, i3)

integer i;
always @(posedge ctrl.clock)
	for(i = 0; i < DEPTH; i = i + 1)
		out$[i]
			= sign == Arith_SignedUnsigned.Signed
			? OUT_W'(in$[i])
			: OUT_W'(in$s[i])
			;

endmodule

`endif
