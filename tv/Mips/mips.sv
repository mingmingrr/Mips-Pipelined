`include "Mips/mips_pipeline.v"
`include "Data/Control/Control.v"

module Mips_mips_tb #
	( parameter FILE = "asm/old/test0.mif"
	)();

`Data_Control_Control_T(reg) ctrl;

Mips_mips_pipeline #
	( .FILE (FILE)
	) DUT
	( .ctrl (ctrl)
	, .pcAddr ()
	);

initial `Data_Control_Control_Clock(ctrl) = 1'b0;
always #5 `Data_Control_Control_Clock(ctrl) = !`Data_Control_Control_Clock(ctrl);

initial begin
	#0;
	`Data_Control_Control_Reset(ctrl) = 1'b1;
	#20;
	`Data_Control_Control_Reset(ctrl) = 1'b0;
end

endmodule

