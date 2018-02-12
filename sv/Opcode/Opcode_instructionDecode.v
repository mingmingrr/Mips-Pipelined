`ifndef OPCODE_INSTRUCTIONDECODE_I
`define OPCODE_INSTRUCTIONDECODE_I

`include "../Opcode/Opcode_Opcode.v"
`include "../Opcode/Opcode_Source.v"

module Opcode_instructionDecode
	( input [5:0] op
	, input [5:0] func
	, `Opcode_Opcode_T(output) out
	);

assign out
	= (|op)
	? {`Opcode_Source_Op, op}
	: {`Opcode_Source_Func, func}
	;

endmodule

`endif
