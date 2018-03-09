`include "Mips/mips_pipeline.v"
`include "Mips/Type/Word.v"
`include "Util/Math.v"

module top #
	( parameter FILE = "asm/old/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	)
	( `Data_Control_Control_T(input) ctrl
	, `Mips_Type_Word_T(output) pcAddr
	);

`Util_Math_log2_expr

Mips_mips_pipeline #
	( .FILE   (FILE)
	, .ADDR_L (ADDR_L)
	, .ADDR_W (ADDR_W)
	) MIPS
	( .ctrl (ctrl)
	, .pcAddr (pcAddr)
	);

endmodule

