`ifndef OPCODE_INSTTOOPFUNC_I
`define OPCODE_INSTTOOPFUNC_I

`include "../../../Mips/Instruction/Parts.v"
`include "../../../Mips/Instruction/OpFunc/OpFunc.v"
`include "../../../Mips/Instruction/OpFunc/Source.v"

module Opcode_instToOpFunc
	( `Instruction_Parts_Op_T(input)   op
	, `Instruction_Parts_Func_T(input) func
	, `Opcode_OpFunc_T(output)         opfunc
	);

assign opfunc
	= (|op)
	? {`Opcode_Source_Op, op}
	: {`Opcode_Source_Func, func}
	;

endmodule

`endif
