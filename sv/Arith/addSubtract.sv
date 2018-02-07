// vim: set ft=verilog:

`include "./AddSub.v"
`include "../Alu/Status.v"
`include "./addSubtract.v"

module Arith_addSubtract_tb;

logic [3:0] data1, data2, result;
`Arith_AddSub_T(logic) addsub;
`Alu_Status_T(logic) status;

Arith_addSubtract #
	( .WIDTH (4)
	) DUT
	( .data1  (data1)
	, .data2  (data2)
	, .addsub (addsub)
	, .result (result)
	, .status (status)
	);

initial data1 = 4'h0;
initial data2 = 4'h0;
initial addsub = 1'h0;

always #1 addsub = !addsub;
always #2 data1 = data1 + 1;
always #32 data2 = data2 + 1;

endmodule
