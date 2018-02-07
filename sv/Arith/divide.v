// vim: set ft=verilog:

`ifndef ARITH_DIVIDE_I
`define ARITH_DIVIDE_I

`include "./SignedUnsigned.v"

module Arith_divide #
	( parameter WIDTH  = 32
	)
	( input  [WIDTH-1:0] data1
	, input  [WIDTH-1:0] data2
	, output [WIDTH-1:0] quotient
	, output [WIDTH-1:0] remainder
	, `Arith_SignedUnsigned_T(input) sign
	);

wire signed [WIDTH-1:0] data1$;
assign data1$ = data1;
wire signed [WIDTH-1:0] data2$;
assign data2$ = data2;

// wire [WIDTH-1:0] quotient$, remainder$;
assign quotient = sign == `Arith_SignedUnsigned_Signed
	? data1$ / data2$
	: data1 / data2
	;
assign remainder = sign == `Arith_SignedUnsigned_Signed
	? data1$ % data2$
	: data1 % data2
	;

// assign quotient  = quotient$;
// assign remainder = remainder$;

endmodule

`endif
