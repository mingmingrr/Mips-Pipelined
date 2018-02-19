// vim: set ft=verilog:

`ifndef UTIL_COUNTER_COUNTER_I
`define UTIL_COUNTER_COUNTER_I

`include "Util/Util_Math.v"
`include "Data/Util_Control.v"

// wow verilog, much industry standard
module Counter_counter #
	( parameter MAX   = 16
	, parameter WIDTH = Util_Math_log2(MAX)
	, parameter DELAY = 0
	)
	( input  [WIDTH-1:0] d
	, output [WIDTH-1:0] q
	, `Data_Control_T(input) ctrl
	, input load
	, input enable
	);

`Util_Math_log2_expr

reg  [WIDTH-1:0] q$;
wire [WIDTH-1:0] n;
assign n = q$ + 1;

always @(posedge `Data_Control_Clock(ctrl))
	if(`Data_Control_Reset(ctrl))
		q$ <= 0;
	else if(load)
		q$ <= d;
	else if(enable)
		if(MAX == 2**WIDTH)
			q$ <= n;
		else if(n == WIDTH'(MAX))
			q$ <= 0;
		else
			q$ <= n;

Delay_arr #
	( .WIDTH (WIDTH)
	, .DELAY (DELAY)
	) dl
	( .ctrl (ctrl)
	, .in   (q$)
	, .out  (q)
	);

endmodule

`endif
