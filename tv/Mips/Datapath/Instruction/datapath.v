`include "Data/Control/Control.v"
`include "Mips/Type/Word.v"
`include "Mips/Control/Control.v"
`include "Util/Math.v"

module Mips_Datapath_Instruction_datapath #
	( parameter FILE   = "asm/test0.mif"
	, parameter ADDR_L = 64
	, parameter ADDR_W = Util_Math_log2(ADDR_L)
	, parameter DATA_W = 32
	)
	( `Data_Control_Control_T (input) ctrl
	, `Mips_Type_Word_T       (input) romAddr
	, `Mips_Type_Word_T       (output) instruction
	);

`Util_Math_log2_expr

Data_Memory_rom #
	( .FILE    (FILE)
	, .ADDR_L  (ADDR_L)
	, .ADDR_W  (ADDR_W)
	, .DATA_W  (DATA_W)
	) ROM
	( .addr  (romAddr[7:2])
	, .ctrl  (ctrl)
	, .out   (instruction)
	);

endmodule
