`include "Mips/Type/Word.v"
`include "Mips/Type/RegAddr.v"
`include "Mips/Instruction/Format/RFormat.v"

module Mips_Datapath_Register_rd1Addr
	( `Mips_Type_Word_T    (input)  instruction
	, `Mips_Type_RegAddr_T (output) rd1Addr
	);

assign rd1Addr = `Mips_Instruction_Format_RFormat_Rs(instruction);

endmodule


