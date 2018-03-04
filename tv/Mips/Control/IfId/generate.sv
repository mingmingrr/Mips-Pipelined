`include "Mips/Control/IfId/generate.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/Category/Category.v"
`include "Mips/Instruction/Category/categorize.v"

module Mips_Control_IfId_generate_tb;

`Mips_Instruction_OpFunc_OpFunc_T     (reg)  opFunc;
`Mips_Instruction_Category_Category_T (wire) category;
`Mips_Control_IfId_Control_T          (wire) control;

Mips_Control_IfId_generate DUT
	( .opFunc   (opFunc)
	, .category (category)
	, .control  (control)
	);

Mips_Instruction_Category_categorize UUT
	( .opFunc   (opFunc)
	, .category (category)
	);

initial opFunc = `Mips_Instruction_OpFunc_OpFunc_W'(0);
always #1 opFunc = opFunc + 1;

endmodule

