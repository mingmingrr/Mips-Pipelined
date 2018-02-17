`include "../Mips/Mips_mips.v"
`include "../Util/Util_Control.v"

module Mips_mips_tb;

`Util_Control_T(reg) ctrl;

Mips_mips #
	( .FILE ("asm/test1.mif")
	) DUT
	( .ctrl (ctrl)
	);

initial `Util_Control_Clock(ctrl) = 1'b0;
always #5 `Util_Control_Clock(ctrl) = !`Util_Control_Clock(ctrl);

initial begin
	#0;
	`Util_Control_Reset(ctrl) = 1'b1;

	#20;
	`Util_Control_Reset(ctrl) = 1'b0;
end

endmodule

