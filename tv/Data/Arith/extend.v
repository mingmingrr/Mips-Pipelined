// vim: set ft=verilog:

`ifndef DATA_ARITH_EXTEND_I
`define DATA_ARITH_EXTEND_I

`include "../../Data/Arith/SignedUnsigned.v"
`include "../../Data/Array/Pack.v"
`include "../../Data/Control.v"

module Data_Arith_extend #
	( parameter IN_W  = 16
	, parameter OUT_W = 32
	, parameter DEPTH = 2
	, parameter DELAY = 0
	)
	( `Data_Array_Pack_T(input, DEPTH, IN_W)  in
	, `Data_Array_Pack_T(output, DEPTH, OUT_W) out
	, `Data_Control_T(input) ctrl
	); // this module can go die in the trash

`Data_Array_Pack_unpackDecl(wire, DEPTH, IN_W, in, in$, i1, updl1)
`Data_Array_Pack_packDecl(reg, DEPTH, IN_W, out$, out, i2, pdl1)

integer i;
always @(posedge `Data_Control_Clock(ctrl))
	for(i = 0; i < DEPTH; i = i + 1)
		out$[i] <= OUT_W'(in$[i]);
endmodule

`endif
