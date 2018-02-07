// vim: set ft=verilog:

`ifndef ARITH_MULTIPLY_I
`define ARITH_MULTIPLY_I

`include "./SignedUnsigned.v"

module Arith_multiply #
	( parameter WIDTH = 32
	)
	( input  [WIDTH-1:0]   data1
	, input  [WIDTH-1:0]   data2
	, output [WIDTH*2-1:0] result
	, `Arith_SignedUnsigned_T(input) sign
	);

wire signed [WIDTH-1:0] data1$;
assign data1$ = data1;
wire signed [WIDTH-1:0] data2$;
assign data2$ = data2;
wire [WIDTH*2-1:0] result$;
assign result$ = sign == `Arith_SignedUnsigned_Signed
	? signed'(data1) * signed'(data2)
	: data1 * data2
	;
assign result = result$;

endmodule

`endif
