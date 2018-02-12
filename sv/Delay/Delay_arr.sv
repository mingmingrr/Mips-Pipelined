`include "../Delay/Delay_arr.v"
`include "../Util/Util_Control.v"

module Delay_arr_tb;

logic [3:0] in, out;
`Util_Control_T(logic) ctrl;

Delay_arr #
	( .WIDTH (4)
	, .DELAY (2)
	) DUT
	( .ctrl (ctrl)
	, .in   (in)
	, .out  (out)
	);

initial `Util_Control_Clock(ctrl) = 0;
always #1 `Util_Control_Clock(ctrl) = !`Util_Control_Clock(ctrl);

initial in = 4'b0;
always #2 in = in + 1;

initial begin
	#0;
	`Util_Control_Reset(ctrl) = 1;
	#4;
	`Util_Control_Reset(ctrl) = 0;
end

endmodule

