`include "../Mips/Control/generate.v"

module Mips_Control_generate_tb;

`Mips_Instruction_OpFunc_OpFunc_T ( reg  ) opFunc;
`Mips_Control_Control_T           ( wire ) control;

Mips_Control_generate DUT
	( .opFunc   (opFunc)
	, .control  (control)
	);

initial opFunc = `Mips_Instruction_OpFunc_OpFunc_W'(0);
always #1 opFunc = opFunc + 1;

endmodule

