`include "Util/Delay/arr.v"
`include "Data/Control.v"

module Util_Delay_arr_tb;

logic [3:0] in, out;
`Data_Control_T(logic) ctrl;

Delay_arr #
	( .WIDTH (4)
	, .DELAY (2)
	) DUT
	( .ctrl (ctrl)
	, .in   (in)
	, .out  (out)
	);

initial `Data_Control_Clock(ctrl) = 0;
always #1 `Data_Control_Clock(ctrl) = !`Data_Control_Clock(ctrl);

initial in = 4'b0;
always #2 in = in + 1;

initial begin
	#0;
	`Data_Control_Reset(ctrl) = 1;
	#4;
	`Data_Control_Reset(ctrl) = 0;
end

endmodule

