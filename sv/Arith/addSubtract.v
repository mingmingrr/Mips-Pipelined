// vim: set ft=verilog:

`ifndef ARITH_ADDSUBTRACT_I
`define ARITH_ADDSUBTRACT_I

`include "./AddSub.v"
`include "../Alu/Status.v"

module Arith_addSubtract #
	( parameter WIDTH = 32
	)
	( input  [WIDTH-1:0]     data1
	, input  [WIDTH-1:0]     data2
	, `Arith_AddSub_T(input) addsub
	, output [WIDTH-1:0]     result
	, `Alu_Status_T(output)  status
	);

wire sub;
assign sub = addsub == `Arith_AddSub_Add ? 1'b0 : 1'b1 ;

wire [WIDTH-1:0] data2$;
assign data2$ = data2 ^ {WIDTH{sub}};

wire dc, carry$;
assign {carry$, result[WIDTH-2:0], dc} =
	{data1[WIDTH-2:0], sub} + {data2$[WIDTH-2:0], sub};

Arith_fullAdder fa
	( .a    (data1[WIDTH-1])
	, .b    (data2$[WIDTH-1])
	, .cin  (carry$)
	, .s    (result[WIDTH-1])
	, .cout ( `Alu_Status_carry(status) )
	);
assign `Alu_Status_over(status) = `Alu_Status_carry(status) ^ carry$;
assign `Alu_Status_zero(status) = !(|result);
assign `Alu_Status_sign(status) = result[WIDTH-1];

endmodule

`endif
