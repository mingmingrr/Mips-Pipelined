`include "Mips/Type/Word.v"
`include "Mips/Type/AluStatus.v"
`include "Mips/Pipeline/IdEx/Pipeline.v"
`include "Mips/Pipeline/ExMem/Pipeline.v"

module Mips_Pipeline_IdIf_generate
	( `Mips_Type_AluStatus_T(input) aluStatus
	, `Mips_Pipeline_IdIf_Pipeline_T(output) pipeOut
	);

`Mips_Pipeline_IdIf_Pipeline_T(wire) pipeOut$;

assign pipeOut$ = `Mips_Pipeline_IdIf_Pipeline_Pack_Defaults;
assign pipeOut = pipeOut$;

endmodule
