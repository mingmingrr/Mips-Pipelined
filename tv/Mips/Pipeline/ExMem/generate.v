`include "Mips/Type/Word.v"
`include "Mips/Datapath/Alu/Status.v"
`include "Mips/Pipeline/IdEx/Pipeline.v"
`include "Mips/Pipeline/ExMem/Pipeline.v"

module Mips_Pipeline_ExMem_generate
	( `Mips_Pipeline_IdEx_Pipeline_T(input) pipeIn
	, `Mips_Type_Word_T(input) aluResult
	, `Mips_Datapath_Alu_Status_T(input) aluStatus
	, `Mips_Pipeline_ExMem_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_ExMem_Pipeline_T(wire) pipeOut$;

`Mips_Pipeline_IdEx_Pipeline_Decl
assign `Mips_Pipeline_IdEx_Pipeline_Pack_Defaults = pipeIn;

assign pipeOut$ = `Mips_Pipeline_ExMem_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule
