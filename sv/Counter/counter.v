// vim: set ft=verilog:

`ifndef COUNTER_COUNTER_I
`define COUNTER_COUNTER_I

`include "../Util/Math.v"
`include "../Arith/AddSub.v"
`include "../Util/Control.v"

// wow verilog, much industry standard
module Counter_counter #
	( parameter MAX   = 16
	, parameter WIDTH = Util_Math_log2(MAX)
	, parameter DELAY = 0
	)
	( input  [WIDTH-1:0] d
	, output [WIDTH-1:0] q
	, `Util_Control_T(input) ctrl
	, input load
	, input enable
	);

`Util_Math_log2_expr

wire [WIDTH-1:0] n;
reg  [WIDTH-1:0] q$;
add_subtract #
	( .WIDTH (WIDTH)
	) add
	( .data1  (q$)
	, .data2  (WIDTH'(1))
	, .result (n)
	, .addsub (AddSub_Add)
	);

always @(posedge Util_Control_clock(ctrl))
	if(`Util_Control_reset(ctrl))
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

delay_1d #
	( .WIDTH (WIDTH)
	, .DELAY (DELAY)
	) dl
	( .ctrl (ctrl)
	, .in   (q$)
	, .out  (q)
	);

endmodule

`endif
