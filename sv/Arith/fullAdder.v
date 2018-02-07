// vim: set ft=verilog:

`ifndef ARITH_FULLADDER_I
`define ARITH_FULLADDER_I

module Arith_fullAdder
	( input  a
	, input  b
	, input  cin
	, output s
	, output cout
	);

wire t;
assign t = a ^ b;
assign s = t ^ cin;
assign cout = (t & cin) | (a & b);

endmodule

`endif
