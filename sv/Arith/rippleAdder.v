// vim: set ft=verilog:

`ifndef ARITH_RIPPLE_ADDER_I
`define ARITH_RIPPLE_ADDER_I

`include "../Alu/Status.v"

module Arith_rippleAdder #
	( parameter WIDTH = 32
	)
	( input  [WIDTH-1:0] data1
	, input  [WIDTH-1:0] data2
	, output [WIDTH-1:0] result
	, `Alu_Status_T(output) status
	);

/* verilator lint_off UNOPTFLAT */
wire carry[0:WIDTH];
genvar i;
generate for(i = 0; i < WIDTH; i = i + 1)
	full_adder fa
		( .a    (data1[i])
		, .b    (data2[i])
		, .cin  (carry[i])
		, .s    (result[i])
		, .cout (carry[i+1])
		);
endgenerate

assign `Alu_Status_carry(status) = carry[WIDTH];
assign `Alu_Status_over(status)  = carry[WIDTH] ^ carry[WIDTH-1];
assign `Alu_Status_zero(status)  = ~(|result);
assign `Alu_Status_sign(status)  = result[WIDTH-1];

endmodule

`endif
