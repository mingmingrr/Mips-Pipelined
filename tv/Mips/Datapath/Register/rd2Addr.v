`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

module Mips_Datapath_Register_rd2Addr
	( `Mips_Type_Word_T    (input)  instruction
	, `Mips_Type_RegAddr_T (output) rd2Addr
	);

assign rd2Addr = `Mips_Instruction_Format_RFormat_Rt(instruction);

endmodule


