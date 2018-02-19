`include "Mips/mips.v"
`include "Data/Control.v"

module Mips_mips_tb;

`Data_Control_T(reg) ctrl;

Mips_mips #
	( .FILE ("asm/test1.mif")
	) DUT
	( .ctrl (ctrl)
	);

initial `Data_Control_Clock(ctrl) = 1'b0;
always #5 `Data_Control_Clock(ctrl) = !`Data_Control_Clock(ctrl);

initial begin
	#0;
	`Data_Control_Reset(ctrl) = 1'b1;

	#20;
	`Data_Control_Reset(ctrl) = 1'b0;
end

endmodule

