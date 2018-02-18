`include "../../Data/Control.v"

module Util_Counter_counter_tb;

logic [3:0] d, q;
`Data_Control_T(logic) ctrl;
logic load, enable;

Counter_counter #
	( .MAX (12)
	) DUT
	( .d (d)
	, .q (q)
	, .ctrl (ctrl)
	, .load (load)
	, .enable (enable)
	);

initial `Data_Control_Clock(ctrl) = 0;
always #1 `Data_Control_Clock(ctrl) = !`Data_Control_Clock(ctrl);
initial d = 4'b0;
always #2 d = d - 1;

initial begin
	#0;
	load = 0;
	enable = 0;
	`Data_Control_Reset(ctrl) = 1;

	#4;
	`Data_Control_Reset(ctrl) = 0;

	#4;
	enable = 1;

	#32;
	enable = 0;

	#4;
	load = 1;

	#8;
	enable = 1;

	#4;
	`Data_Control_Reset(ctrl) = 1;

	#4;
	`Data_Control_Reset(ctrl) = 0;
	load = 0;
	enable = 0;

	$finish;
end

endmodule

