`include "Mips/Instruction/Format/RFormat.v"
`include "Mips/Instruction/OpFunc/OpFunc.v"
`include "Mips/Instruction/OpFunc/Source.v"

module Mips_Instruction_OpFunc_instToOpFunc
	( `Mips_Instruction_Format_RFormat_Op_T(input)   op
	, `Mips_Instruction_Format_RFormat_Func_T(input) func
	, `Mips_Instruction_OpFunc_OpFunc_T(output)      opFunc
	);

assign opFunc
	= (|op)
	? `Mips_Instruction_OpFunc_OpFunc_Init
		( `Mips_Instruction_OpFunc_Source_Op   , op   )
	: `Mips_Instruction_OpFunc_OpFunc_Init
		( `Mips_Instruction_OpFunc_Source_Func , func )
	;

endmodule

